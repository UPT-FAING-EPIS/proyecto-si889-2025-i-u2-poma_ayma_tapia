import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
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
    semanaInicio = now.subtract(
      Duration(days: now.weekday - 1),
    ); // Lunes de esta semana
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
        length: 3, // Cambia de 4 a 3
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Análisis y Estadísticas',
              style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.date_range),
                onPressed: () async {
                  final now = DateTime.now();
                  final picked = await showDateRangePicker(
                    context: context,
                    firstDate: DateTime(now.year - 2),
                    lastDate: now,
                  );
                  if (picked != null) {
                    setState(() {
                      selectedRange = picked;
                    });
                  }
                },
              ),
            ],
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.black),
            bottom: const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.black54,
              tabs: [
                Tab(text: 'Diario'),
                Tab(text: 'Semanal'),
                Tab(text: 'Mensual'),
                // Quita este tab:
                // Tab(text: 'Categorías'),
              ],
            ),
          ),
          body: Consumer<AnalysisViewModel>(
            builder: (context, vm, _) {
              // Filtra las compras por rango de fechas si hay filtro
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

              // Calcula los datos de los gráficos usando comprasFiltradas
              final diario =
                  vm.getGastosDiarios(comprasFiltradas).entries.toList();
              final semanal =
                  vm.getGastosSemanales(comprasFiltradas).entries.toList();
              final mensual =
                  vm.getGastosMensuales(comprasFiltradas).entries.toList();
              final categorias =
                  vm.getGastosPorCategoria(comprasFiltradas).entries.toList();

              if (vm.compras.isEmpty) {
                return const Center(child: CircularProgressIndicator());
              }

              return Column(
                children: [
                  Expanded(
                    child: TabBarView(
                      children: [
                        // Tab 1: Diario
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: semanaInicio ?? DateTime.now(),
                                    firstDate: DateTime(
                                      DateTime.now().year - 2,
                                    ),
                                    lastDate: DateTime.now(),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      semanaInicio = picked.subtract(
                                        Duration(days: picked.weekday - 1),
                                      );
                                    });
                                  }
                                },
                                child: Text(
                                  semanaInicio == null
                                      ? 'Selecciona una semana'
                                      : 'Semana del ${DateFormat('dd/MM/yyyy').format(semanaInicio!)}',
                                ),
                              ),
                            ),
                            Expanded(
                              child: BarChart(
                                BarChartData(
                                  barGroups:
                                      (semanaInicio == null
                                              ? []
                                              : vm
                                                  .getGastoPorDiaSemana(
                                                    comprasFiltradas,
                                                    semanaInicio!,
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
                                                  color: Colors.blue,
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
                                          final dias = [
                                            'Lun',
                                            'Mar',
                                            'Mié',
                                            'Jue',
                                            'Vie',
                                            'Sáb',
                                            'Dom',
                                          ];
                                          if (value >= 0 &&
                                              value < dias.length) {
                                            return Text(dias[value.toInt()]);
                                          }
                                          return const Text('');
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Tab 2: Semanal
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
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
                                        (m) =>
                                            setState(() => mesSeleccionado = m),
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
                            ),
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
                                                  color: Colors.green,
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
                                            return Text(semanas[value.toInt()]);
                                          }
                                          return const Text('');
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        // Tab 3: Mensual
                        Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: DropdownButton<int>(
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
                            ),
                            Expanded(
                              child: BarChart(
                                BarChartData(
                                  barGroups:
                                      (anioMensualSeleccionado == null
                                              ? []
                                              : vm
                                                  .getGastoPorMes(
                                                    comprasFiltradas,
                                                    anioMensualSeleccionado!,
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
                                                  color: Colors.orange,
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
                                          final meses = [
                                            'Ene',
                                            'Feb',
                                            'Mar',
                                            'Abr',
                                            'May',
                                            'Jun',
                                            'Jul',
                                            'Ago',
                                            'Sep',
                                            'Oct',
                                            'Nov',
                                            'Dic',
                                          ];
                                          if (value >= 0 &&
                                              value < meses.length) {
                                            return Text(meses[value.toInt()]);
                                          }
                                          return const Text('');
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Gráfico de Categorías siempre visible abajo
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          'Gastos por Categoría',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 200,
                          child: PieChart(
                            PieChartData(
                              sections:
                                  categorias.map((e) {
                                    return PieChartSectionData(
                                      value: e.value,
                                      title: e.key,
                                      color:
                                          Colors.primaries[categorias.indexOf(
                                                e,
                                              ) %
                                              Colors.primaries.length],
                                      radius: 60,
                                      titleStyle: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    );
                                  }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
