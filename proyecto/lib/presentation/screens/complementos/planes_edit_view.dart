import 'package:VanguardMoney/data/models/planes_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../viewmodels/planes_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';

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
        return Scaffold(
          appBar: AppBar(
            title: const Text('Editar Plan Monetario'),
            backgroundColor: Colors.teal[700],
          ),
          body: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                'Monto total del plan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.teal[900],
                  letterSpacing: 0.5,
                ),
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
                  prefixIcon: const Icon(Icons.attach_money, color: Colors.teal),
                  filled: true,
                  fillColor: Colors.white,
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
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: Colors.teal[800],
                  letterSpacing: 0.5,
                ),
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
                            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
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
                              style: TextStyle(
                                color: porcentaje > 100 ? Colors.red : Colors.teal[700],
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )),
              const SizedBox(height: 30),
              Divider(thickness: 1.2, color: Colors.teal[200]),
              const SizedBox(height: 10),
              _ResumenPlan(viewModel: viewModel),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.save),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal[700],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: () async {
                    final total = viewModel.montoTotal;
                    final usado = viewModel.montoCategorias;
                    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
                    final uid = authViewModel.user?.uid;

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
  const _ResumenPlan({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    final total = viewModel.montoTotal;
    final usado = viewModel.montoCategorias;
    final noUsado = (total - usado).clamp(0, total);
    final porcentajeUsado = (total > 0) ? (usado / total * 100) : 0;
    final porcentajeNoUsado = (total > 0) ? (noUsado / total * 100) : 0;
    final sobrepasado = porcentajeUsado > 100;

    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.teal[100]!),
      ),
      padding: const EdgeInsets.all(18),
      child: Column(
        children: [
          Row(
            children: [
              Icon(Icons.pie_chart, color: sobrepasado ? Colors.red : Colors.teal, size: 28),
              const SizedBox(width: 10),
              Text(
                'Resumen del plan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: sobrepasado ? Colors.red : Colors.teal[900],
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
                  const Text('Total usado:', style: TextStyle(fontWeight: FontWeight.w500)),
                  Text(
                    '\$${usado.toStringAsFixed(2)} (${porcentajeUsado.toStringAsFixed(1)}%)',
                    style: TextStyle(
                      color: sobrepasado ? Colors.red : Colors.teal[800],
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text('No usado:', style: TextStyle(fontWeight: FontWeight.w500)),
                  Text(
                    '\$${noUsado.toStringAsFixed(2)} (${porcentajeNoUsado.toStringAsFixed(1)}%)',
                    style: TextStyle(
                      color: Colors.blueGrey[700],
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
    );
  }
}