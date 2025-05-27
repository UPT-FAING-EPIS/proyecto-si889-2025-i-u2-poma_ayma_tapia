import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/inicio_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:VanguardMoney/data/models/productos_model.dart';
import 'package:VanguardMoney/core/theme/app_colors.dart';
import 'package:VanguardMoney/core/theme/app_text_styles.dart';

class TodosEgresosScreen extends StatefulWidget {
  const TodosEgresosScreen({Key? key}) : super(key: key);

  @override
  State<TodosEgresosScreen> createState() => _TodosEgresosScreenState();
}

class _TodosEgresosScreenState extends State<TodosEgresosScreen> {
  DateTimeRange? _rangoSeleccionado;
  DateTime? _fechaSeleccionada;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final viewModel = InicioViewModel(
      auth.user!.uid,
      auth.userData?.nombreCompleto ?? 'Usuario',
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Todos los Egresos',
          style: AppTextStyles.headline.copyWith(fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/home');
          },
          tooltip: 'Regresar al menú',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            tooltip: 'Buscar por rango de fechas',
            onPressed: () async {
              final now = DateTime.now();
              final picked = await showDateRangePicker(
                context: context,
                firstDate: DateTime(now.year - 5),
                lastDate: DateTime(now.year + 1),
                initialDateRange: _rangoSeleccionado,
              );
              if (picked != null) {
                setState(() {
                  _rangoSeleccionado = picked;
                  _fechaSeleccionada = null;
                });
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            tooltip: 'Buscar por día',
            onPressed: () async {
              final now = DateTime.now();
              final picked = await showDatePicker(
                context: context,
                initialDate: _fechaSeleccionada ?? now,
                firstDate: DateTime(now.year - 5),
                lastDate: DateTime(now.year + 1),
              );
              if (picked != null) {
                setState(() {
                  _fechaSeleccionada = picked;
                  _rangoSeleccionado = null;
                });
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<List<CompraModel>>(
        stream: viewModel.getAllCompras(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          var compras = snapshot.data ?? [];

          // Filtro por rango de fechas
          if (_rangoSeleccionado != null) {
            compras =
                compras.where((compra) {
                  final fecha = DateFormat(
                    'dd/MM/yyyy HH:mm:ss',
                  ).parse(compra.fechaEmision);
                  return fecha.isAfter(
                        _rangoSeleccionado!.start.subtract(
                          const Duration(days: 1),
                        ),
                      ) &&
                      fecha.isBefore(
                        _rangoSeleccionado!.end.add(const Duration(days: 1)),
                      );
                }).toList();
          }

          // Filtro por día específico
          if (_fechaSeleccionada != null) {
            compras =
                compras.where((compra) {
                  final fecha = DateFormat(
                    'dd/MM/yyyy HH:mm:ss',
                  ).parse(compra.fechaEmision);
                  return fecha.year == _fechaSeleccionada!.year &&
                      fecha.month == _fechaSeleccionada!.month &&
                      fecha.day == _fechaSeleccionada!.day;
                }).toList();
          }

          if (compras.isEmpty) {
            return const Center(child: Text('No hay egresos registrados'));
          }

          // Agrupar por día
          final Map<String, List<CompraModel>> comprasPorDia = {};
          for (var compra in compras) {
            final fecha = DateFormat('dd/MM/yyyy').format(
              DateFormat('dd/MM/yyyy HH:mm:ss').parse(compra.fechaEmision),
            );
            comprasPorDia.putIfAbsent(fecha, () => []).add(compra);
          }

          final dias =
              comprasPorDia.keys.toList()..sort((a, b) => b.compareTo(a));

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: dias.length,
            itemBuilder: (context, index) {
              final dia = dias[index];
              final comprasDelDia = comprasPorDia[dia]!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4, bottom: 8, top: 12),
                    child: Text(
                      dia,
                      style: AppTextStyles.title.copyWith(fontSize: 16),
                    ),
                  ),
                  ...comprasDelDia.map(
                    (compra) => Container(
                      margin: const EdgeInsets.symmetric(vertical: 6),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.background,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.05),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: AppColors.primary,
                            size: 28,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  compra.lugarCompra,
                                  style: AppTextStyles.body.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Total: \$${compra.total.toStringAsFixed(2)}',
                                  style: AppTextStyles.body.copyWith(
                                    color: AppColors.info,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            DateFormat('HH:mm').format(
                              DateFormat(
                                'dd/MM/yyyy HH:mm:ss',
                              ).parse(compra.fechaEmision),
                            ),
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.info,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
