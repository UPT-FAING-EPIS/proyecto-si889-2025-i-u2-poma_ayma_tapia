import 'package:VanguardMoney/data/models/planes_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../viewmodels/planes_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'package:VanguardMoney/core/theme/app_colors.dart';
import 'package:VanguardMoney/core/theme/app_text_styles.dart';

class PlanesScreen extends StatefulWidget {
  @override
  _PlanesScreenState createState() => _PlanesScreenState();
}

class _PlanesScreenState extends State<PlanesScreen> {
  final _montoTotalController = TextEditingController();
  final Map<String, TextEditingController> _montoCategoriaControllers = {
    for (var cat in categoriasPermitidas) cat: TextEditingController()
  };

  @override
  void dispose() {
    _montoTotalController.dispose();
    _montoCategoriaControllers.values.forEach((c) => c.dispose());
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      final uid = authViewModel.user?.uid;
      if (uid != null) {
        final viewModel = Provider.of<PlanesViewModel>(context, listen: false);
        await viewModel.cargarPlanDesdeFirebase(uid);

        _montoTotalController.text = viewModel.montoTotal.toString();
        for (var cat in categoriasPermitidas) {
          final categoria = viewModel.categorias.firstWhere(
            (c) => c.nombre == cat,
            orElse: () => CategoriaModel(nombre: cat, montoMaximo: 0),
          );
          _montoCategoriaControllers[cat]?.text =
              categoria.montoMaximo > 0 ? categoria.montoMaximo.toString() : '';
        }
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanesViewModel>(
      builder: (context, viewModel, child) {
        // Calcular monto de ahorros
        final ahorroCategoria = viewModel.categorias.firstWhere(
          (c) => c.nombre == 'Ahorros',
          orElse: () => CategoriaModel(nombre: 'Ahorros', montoMaximo: 0),
        );
        final montoAhorros = ahorroCategoria.montoMaximo;

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            title: const Text('Editar Plan Monetario'),
            backgroundColor: AppColors.background,
            elevation: 0,
            titleTextStyle: AppTextStyles.headline.copyWith(fontSize: 20),
            iconTheme: IconThemeData(color: AppColors.primary),
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Monto total del plan',
                style: AppTextStyles.title,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _montoTotalController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                ],
                decoration: InputDecoration(
                  hintText: 'Ej: 1000',
                  prefixIcon: Icon(Icons.attach_money, color: AppColors.primary),
                  filled: true,
                  fillColor: AppColors.background,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                  contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                ),
                onChanged: (value) {
                  final monto = double.tryParse(value) ?? 0.0;
                  viewModel.setMontoTotal(monto);
                },
              ),
              const SizedBox(height: 24),
              Text(
                'Montos máximos por categoría',
                style: AppTextStyles.title.copyWith(fontSize: 17),
              ),
              const SizedBox(height: 10),
              ...categoriasPermitidas.map((cat) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            cat,
                            style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500, fontSize: 15),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            controller: _montoCategoriaControllers[cat],
                            keyboardType: TextInputType.numberWithOptions(decimal: true),
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                            ],
                            decoration: InputDecoration(
                              hintText: 'Monto',
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              fillColor: AppColors.background,
                              filled: true,
                            ),
                            onChanged: (value) {
                              final monto = double.tryParse(value) ?? 0.0;
                              final index = viewModel.categorias.indexWhere((c) => c.nombre == cat);
                              if (index >= 0) {
                                viewModel.eliminarCategoria(index);
                              }
                              if (monto > 0) {
                                viewModel.agregarCategoria(cat, monto);
                              }
                              setState(() {});
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Builder(
                          builder: (_) {
                            final monto = double.tryParse(_montoCategoriaControllers[cat]?.text ?? '') ?? 0.0;
                            final total = viewModel.montoTotal;
                            final porcentaje = (total > 0) ? (monto / total * 100) : 0;
                            return Text(
                              '${porcentaje.toStringAsFixed(1)}%',
                              style: AppTextStyles.body.copyWith(
                                color: porcentaje > 100 ? AppColors.accent : AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 30),
              Divider(thickness: 1.2, color: AppColors.info.withOpacity(0.2)),
              const SizedBox(height: 10),
              _ResumenPlan(viewModel: viewModel, montoAhorros: montoAhorros),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    textStyle: AppTextStyles.headline.copyWith(fontSize: 16),
                  ),
                  onPressed: () async {
                    final total = viewModel.montoTotal;
                    final usado = viewModel.montoCategorias;
                    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
                    final uid = authViewModel.user?.uid;

                    // Calcular monto de ahorros
                    final ahorroCategoria = viewModel.categorias.firstWhere(
                      (c) => c.nombre == 'Ahorros',
                      orElse: () => CategoriaModel(nombre: 'Ahorros', montoMaximo: 0),
                    );
                    final montoAhorros = ahorroCategoria.montoMaximo;

                    // Calcular lo no usado (excluyendo ahorros)
                    final noUsado = (total - usado).clamp(0, total);

                    // Suma de ahorros y lo no usado
                    final ahorroTotal = montoAhorros + noUsado;

                    if (total == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Debes ingresar un monto total.')),
                      );
                      return;
                    }
                    if (usado > total) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('El total usado no puede superar el monto total.')),
                      );
                      return;
                    }
                    if (uid == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('No se pudo obtener el usuario.')),
                      );
                      return;
                    }
                    try {
                      final snapshot = await FirebaseFirestore.instance
                          .collection('planes')
                          .where('uid', isEqualTo: uid)
                          .orderBy('fecha', descending: true)
                          .limit(1)
                          .get();

                      final planData = {
                        'uid': uid,
                        'montoTotal': total,
                        'categorias': viewModel.categorias.map((cat) => {
                          'nombre': cat.nombre,
                          'montoMaximo': cat.montoMaximo,
                        }).toList(),
                        'ahorro_total': ahorroTotal, // <-- Nuevo campo
                        'fecha': FieldValue.serverTimestamp(),
                        'fechaLocal': DateTime.now().toIso8601String(),
                      };

                      if (snapshot.docs.isNotEmpty) {
                        await FirebaseFirestore.instance
                            .collection('planes')
                            .doc(snapshot.docs.first.id)
                            .update(planData);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('¡Plan actualizado exitosamente!')),
                        );
                      } else {
                        await FirebaseFirestore.instance.collection('planes').add(planData);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('¡Plan guardado exitosamente!')),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Error al guardar el plan: $e')),
                      );
                    }
                  },
                  label: const Text('Guardar plan'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}

class _ResumenPlan extends StatelessWidget {
  final PlanesViewModel viewModel;
  final double montoAhorros;
  const _ResumenPlan({required this.viewModel, required this.montoAhorros});

  @override
  Widget build(BuildContext context) {
    final total = viewModel.montoTotal;
    // Suma de todos los montos asignados a categorías EXCEPTO "Ahorros"
    final usadoSinAhorros = viewModel.categorias
        .where((c) => c.nombre != 'Ahorros')
        .fold<double>(0.0, (sum, c) => sum + c.montoMaximo);

    // Lo no usado es el sobrante del total menos lo asignado a categorías (excepto ahorros)
    final noUsado = (total - usadoSinAhorros - montoAhorros).clamp(0, total);

    // Suma de ahorros y lo no usado
    final sumaAhorrosYNoUsado = montoAhorros + noUsado;

    final porcentajeUsado = (total > 0) ? (usadoSinAhorros / total * 100) : 0;
    final sobrepasado = porcentajeUsado > 100;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.zero,
      color: AppColors.background,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.pie_chart, color: sobrepasado ? AppColors.accent : AppColors.primary, size: 28),
                const SizedBox(width: 10),
                Text(
                  'Resumen del plan',
                  style: AppTextStyles.title.copyWith(
                    color: sobrepasado ? AppColors.accent : AppColors.primary,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total usado (sin ahorros):', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
                    Text(
                      '\$${usadoSinAhorros.toStringAsFixed(2)} (${porcentajeUsado.toStringAsFixed(1)}%)',
                      style: AppTextStyles.body.copyWith(
                        color: sobrepasado ? AppColors.accent : AppColors.secondary,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text('No usado + Ahorros:', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
                    Text(
                      '\$${sumaAhorrosYNoUsado.toStringAsFixed(2)}',
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.info,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}