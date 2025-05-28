import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:VanguardMoney/core/theme/app_colors.dart';
import 'package:VanguardMoney/core/theme/app_text_styles.dart';

import '../../viewmodels/analysis_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';

class AnalysisScreen extends StatefulWidget {
  const AnalysisScreen({super.key});

  @override
  State<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  DateTimeRange? selectedRange;
  DateTime? semanaInicio;
  int? mesSeleccionado;
  int? anioSeleccionado;
  int? anioMensualSeleccionado;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    // Calcula el lunes de esta semana
    final lunes = now.subtract(Duration(days: now.weekday - 1));
    // Calcula el viernes de esta semana, pero no más allá de hoy
    final viernes = lunes.add(Duration(days: 4));
    final fechaFin = viernes.isAfter(now) ? now : viernes;

    // Inicializa selectedRange con esta semana (lunes hasta hoy o viernes)
    selectedRange = DateTimeRange(start: lunes, end: fechaFin);

    semanaInicio = lunes;
    mesSeleccionado = now.month;
    anioSeleccionado = now.year;
    anioMensualSeleccionado = now.year;
  }

  @override
  Widget build(BuildContext context) {
    final authVM = Provider.of<AuthViewModel>(context, listen: false);
    final userId = authVM.user?.uid ?? '';

    return ChangeNotifierProvider(
      create: (_) => AnalysisViewModel()..fetchCompras(userId),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            iconTheme: IconThemeData(color: AppColors.text),
            title: Text(
              'Análisis y Estadísticas',
              style: AppTextStyles.headline.copyWith(fontSize: 20),
            ),
            bottom: const TabBar(
              labelColor: AppColors.primary,
              unselectedLabelColor: AppColors.info,
              indicatorColor: AppColors.primary,
              tabs: [
                Tab(text: 'Diario'),
                Tab(text: 'Semanal'),
                Tab(text: 'Mensual'),
              ],
            ),
          ),
          body: Consumer<AnalysisViewModel>(
            builder: (context, vm, _) {
              final comprasFiltradas =
                  selectedRange == null
                      ? vm.compras
                      : vm.compras.where((compra) {
                        final fecha = DateFormat(
                          'dd/MM/yyyy',
                        ).parse(compra.fechaEmision.split(' ').first);
                        return fecha.isAfter(
                              selectedRange!.start.subtract(
                                const Duration(days: 1),
                              ),
                            ) &&
                            fecha.isBefore(
                              selectedRange!.end.add(const Duration(days: 1)),
                            );
                      }).toList();

              final categorias =
                  vm.getGastosPorCategoria(comprasFiltradas).entries.toList();

              if (vm.compras.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // TAB VIEW
                    SizedBox(
                      height: 340,
                      child: TabBarView(
                        children: [
                          // Tab 1: Diario
                          _ChartCard(
                            title: 'Gasto Diario',
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton.icon(
                                      icon: const Icon(
                                        Icons.date_range,
                                        size: 18,
                                      ),
                                      label: Text(
                                        selectedRange == null
                                            ? 'Elegir rango de días'
                                            : '${DateFormat('dd/MM').format(selectedRange!.start)} - ${DateFormat('dd/MM').format(selectedRange!.end)} (Esta semana)',
                                        style: AppTextStyles.body.copyWith(
                                          fontSize: 12,
                                        ),
                                      ),
                                      onPressed: () async {
                                        final picked =
                                            await showDateRangePicker(
                                              context: context,
                                              firstDate: DateTime(2020),
                                              lastDate: DateTime.now(),
                                              initialDateRange:
                                                  selectedRange ??
                                                  DateTimeRange(
                                                    start: DateTime.now()
                                                        .subtract(
                                                          const Duration(
                                                            days: 6,
                                                          ),
                                                        ),
                                                    end: DateTime.now(),
                                                  ),
                                              helpText:
                                                  'Selecciona el rango de días',
                                              cancelText: 'Cancelar',
                                              confirmText: 'Confirmar',
                                            );
                                        if (picked != null) {
                                          setState(() {
                                            selectedRange = picked;
                                          });
                                        }
                                      },
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child:
                                      selectedRange == null
                                          ? Center(
                                            child: Text(
                                              'Selecciona un rango de fechas\npara ver los gastos diarios',
                                              textAlign: TextAlign.center,
                                              style: AppTextStyles.body
                                                  .copyWith(
                                                    color: AppColors.info,
                                                  ),
                                            ),
                                          )
                                          : BarChart(
                                            BarChartData(
                                              barGroups:
                                                  vm
                                                      .getGastoPorRangoFechas(
                                                        comprasFiltradas,
                                                        selectedRange!.start,
                                                        selectedRange!.end,
                                                      )
                                                      .entries
                                                      .toList()
                                                      .asMap()
                                                      .entries
                                                      .map(
                                                        (
                                                          e,
                                                        ) => BarChartGroupData(
                                                          x: e.key,
                                                          barRods: [
                                                            BarChartRodData(
                                                              toY:
                                                                  e.value.value,
                                                              color:
                                                                  AppColors
                                                                      .primary,
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                    8,
                                                                  ),
                                                              width: 18,
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                      .toList(),
                                              titlesData: FlTitlesData(
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: true,
                                                    getTitlesWidget: (
                                                      value,
                                                      meta,
                                                    ) {
                                                      final labels =
                                                          vm
                                                              .getGastoPorRangoFechas(
                                                                comprasFiltradas,
                                                                selectedRange!
                                                                    .start,
                                                                selectedRange!
                                                                    .end,
                                                              )
                                                              .keys
                                                              .toList();
                                                      if (value >= 0 &&
                                                          value <
                                                              labels.length) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                top: 8.0,
                                                              ),
                                                          child: Transform.rotate(
                                                            angle:
                                                                labels.length >
                                                                        7
                                                                    ? -0.5
                                                                    : 0,
                                                            child: Text(
                                                              labels[value
                                                                  .toInt()],
                                                              style: AppTextStyles
                                                                  .body
                                                                  .copyWith(
                                                                    fontSize:
                                                                        labels.length >
                                                                                10
                                                                            ? 10
                                                                            : 12,
                                                                  ),
                                                            ),
                                                          ),
                                                        );
                                                      }
                                                      return const Text('');
                                                    },
                                                    reservedSize: 32,
                                                  ),
                                                ),
                                                leftTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: true,
                                                    reservedSize: 40,
                                                  ),
                                                ),
                                                topTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: false,
                                                  ),
                                                ),
                                                rightTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: false,
                                                  ),
                                                ),
                                              ),
                                              gridData: FlGridData(show: false),
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                            ),
                                          ),
                                ),
                              ],
                            ),
                          ),
                          // Tab 2: Semanal
                          _ChartCard(
                            title: 'Gasto Semanal',
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DropdownButton<int>(
                                      hint: const Text('Mes'),
                                      value: mesSeleccionado,
                                      items:
                                          List.generate(12, (i) => i + 1)
                                              .map(
                                                (m) => DropdownMenuItem(
                                                  value: m,
                                                  child: Text(
                                                    DateFormat.MMMM().format(
                                                      DateTime(0, m),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                      onChanged:
                                          (m) => setState(
                                            () => mesSeleccionado = m,
                                          ),
                                    ),
                                    const SizedBox(width: 16),
                                    DropdownButton<int>(
                                      hint: const Text('Año'),
                                      value: anioSeleccionado,
                                      items:
                                          List.generate(
                                                5,
                                                (i) => DateTime.now().year - i,
                                              )
                                              .map(
                                                (y) => DropdownMenuItem(
                                                  value: y,
                                                  child: Text('$y'),
                                                ),
                                              )
                                              .toList(),
                                      onChanged:
                                          (y) => setState(
                                            () => anioSeleccionado = y,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Expanded(
                                  child: BarChart(
                                    BarChartData(
                                      barGroups:
                                          (mesSeleccionado == null ||
                                                      anioSeleccionado == null
                                                  ? []
                                                  : vm
                                                      .getGastoPorSemanaMes(
                                                        comprasFiltradas,
                                                        anioSeleccionado!,
                                                        mesSeleccionado!,
                                                      )
                                                      .entries
                                                      .toList())
                                              .asMap()
                                              .entries
                                              .map(
                                                (e) => BarChartGroupData(
                                                  x: e.key,
                                                  barRods: [
                                                    BarChartRodData(
                                                      toY: e.value.value,
                                                      color:
                                                          AppColors.secondary,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                      width: 18,
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                      titlesData: FlTitlesData(
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              final semanas = [
                                                'Semana 1',
                                                'Semana 2',
                                                'Semana 3',
                                                'Semana 4',
                                                'Semana 5',
                                              ];
                                              if (value >= 0 &&
                                                  value < semanas.length) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 8.0,
                                                      ),
                                                  child: Transform.rotate(
                                                    angle:
                                                        -0.5, // Rota el texto unos -28 grados
                                                    child: Text(
                                                      semanas[value.toInt()],
                                                      style: AppTextStyles.body
                                                          .copyWith(
                                                            fontSize: 11,
                                                          ),
                                                    ),
                                                  ),
                                                );
                                              }
                                              return const Text('');
                                            },
                                            reservedSize:
                                                32, // Aumenta el espacio para los labels
                                          ),
                                        ),
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize:
                                                40, // Opcional: más espacio para los valores Y
                                          ),
                                        ),
                                        topTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                          ), // Oculta los índices arriba
                                        ),
                                        rightTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: false,
                                          ),
                                        ),
                                      ),
                                      gridData: FlGridData(show: false),
                                      borderData: FlBorderData(show: false),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // Tab 3: Mensual
                          _ChartCard(
                            title: 'Gasto Mensual',
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DropdownButton<int>(
                                      hint: const Text('Mes'),
                                      value: mesSeleccionado,
                                      items:
                                          List.generate(12, (i) => i + 1)
                                              .map(
                                                (m) => DropdownMenuItem(
                                                  value: m,
                                                  child: Text(
                                                    DateFormat.MMMM().format(
                                                      DateTime(0, m),
                                                    ),
                                                  ),
                                                ),
                                              )
                                              .toList(),
                                      onChanged:
                                          (m) => setState(
                                            () => mesSeleccionado = m,
                                          ),
                                    ),
                                    const SizedBox(width: 16),
                                    DropdownButton<int>(
                                      hint: const Text('Año'),
                                      value: anioMensualSeleccionado,
                                      items:
                                          List.generate(
                                                5,
                                                (i) => DateTime.now().year - i,
                                              )
                                              .map(
                                                (y) => DropdownMenuItem(
                                                  value: y,
                                                  child: Text('$y'),
                                                ),
                                              )
                                              .toList(),
                                      onChanged:
                                          (y) => setState(
                                            () => anioMensualSeleccionado = y,
                                          ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Expanded(
                                  child: BarChart(
                                    BarChartData(
                                      barGroups:
                                          (anioMensualSeleccionado == null ||
                                                      mesSeleccionado == null
                                                  ? []
                                                  : vm
                                                      .getGastoPorMesVentana(
                                                        comprasFiltradas,
                                                        anioMensualSeleccionado!,
                                                        mesSeleccionado!, // mes central
                                                        ventana:
                                                            5, // puedes cambiar a 3 si prefieres
                                                      )
                                                      .entries
                                                      .toList())
                                              .asMap()
                                              .entries
                                              .map(
                                                (e) => BarChartGroupData(
                                                  x: e.key,
                                                  barRods: [
                                                    BarChartRodData(
                                                      toY: e.value.value,
                                                      color: AppColors.accent,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                      width: 18,
                                                    ),
                                                  ],
                                                ),
                                              )
                                              .toList(),
                                      titlesData: FlTitlesData(
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              final labels =
                                                  (anioMensualSeleccionado ==
                                                              null ||
                                                          mesSeleccionado ==
                                                              null)
                                                      ? []
                                                      : vm
                                                          .getGastoPorMesVentana(
                                                            comprasFiltradas,
                                                            anioMensualSeleccionado!,
                                                            mesSeleccionado!,
                                                            ventana: 5,
                                                          )
                                                          .keys
                                                          .toList();
                                              if (value >= 0 &&
                                                  value < labels.length) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 8.0,
                                                      ),
                                                  child: Text(
                                                    labels[value.toInt()],
                                                    style: AppTextStyles.body
                                                        .copyWith(fontSize: 12),
                                                  ),
                                                );
                                              }
                                              return const Text('');
                                            },
                                            reservedSize: 32,
                                          ),
                                        ),
                                      ),
                                      gridData: FlGridData(show: false),
                                      borderData: FlBorderData(show: false),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Pie Chart Card
                    _ChartCard(
                      title: 'Gastos por Categoría',
                      child: SizedBox(
                        height: 180,
                        child: PieChart(
                          PieChartData(
                            sections:
                                categorias.map((e) {
                                  final pieColors = [
                                    AppColors.primary,
                                    AppColors.secondary,
                                    AppColors.accent,
                                    AppColors.info,
                                    AppColors.warning,
                                    AppColors.pink,
                                  ];
                                  return PieChartSectionData(
                                    value: e.value,
                                    title: e.key,
                                    color:
                                        pieColors[categorias.indexOf(e) %
                                            pieColors.length],
                                    radius: 60,
                                    titleStyle: AppTextStyles.body.copyWith(
                                      color: Colors.white,
                                      fontSize: 12,
                                    ),
                                  );
                                }).toList(),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Widget para tarjetas de gráficos
class _ChartCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _ChartCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.06),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTextStyles.title),
          const SizedBox(height: 16),
          SizedBox(height: 180, child: child),
        ],
      ),
    );
  }
}
