import 'package:VanguardMoney/presentation/viewmodels/categoria_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/planes_model.dart';
import '../../viewmodels/planes_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';
import '../complementos/planes_edit_view.dart';
import '../complementos/categoria_detalle_view.dart';
import '../../../data/models/productos_model.dart';

class PlanesVisualizacionScreen extends StatefulWidget {
  @override
  State<PlanesVisualizacionScreen> createState() => _PlanesVisualizacionScreenState();
}

class _PlanesVisualizacionScreenState extends State<PlanesVisualizacionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
      final uid = authViewModel.user?.uid;
      if (uid != null) {
        await Provider.of<PlanesViewModel>(context, listen: false).cargarPlanDesdeFirebase(uid);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlanesViewModel>(
      builder: (context, viewModel, child) {
        final categorias = viewModel.categorias;
        final montoTotal = viewModel.montoTotal;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Montos por Categoría'),
            actions: [
              IconButton(
                icon: const Icon(Icons.edit),
                tooltip: 'Editar plan',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PlanesScreen()),
                  );
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: categorias.isEmpty
                ? const Center(child: Text('No hay datos de categorías guardados.'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        color: Colors.teal[50],
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Monto total del plan',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.teal[900],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '\$${montoTotal.toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                  color: Colors.teal[800],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Builder(
                                builder: (context) {
                                  final uid = Provider.of<AuthViewModel>(context, listen: false).user?.uid ?? '';
                                  final logic = CategoriaDetalleLogic(categoria: '', uid: uid);
                                  return StreamBuilder<double>(
                                    stream: logic.getTotalGastadoGeneral(),
                                    builder: (context, snapshot) {
                                      final totalFacturas = snapshot.data ?? 0.0;
                                      return Row(
                                        children: [
                                          const Icon(Icons.receipt_long, color: Colors.teal, size: 22),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Total gastado este mes: ',
                                            style: TextStyle(
                                              color: Colors.teal[900],
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            '\$${totalFacturas.toStringAsFixed(2)}',
                                            style: TextStyle(
                                              color: Colors.teal[700],
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      Expanded(
                        child: ListView.separated(
                          itemCount: categorias.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            final cat = categorias[index];
                            final porcentaje = montoTotal > 0
                                ? (cat.montoMaximo / montoTotal * 100)
                                : 0;

                            final uid = Provider.of<AuthViewModel>(context, listen: false).user?.uid ?? '';
                            final logic = CategoriaDetalleLogic(categoria: cat.nombre, uid: uid);

                            return Card(
                              elevation: 3,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: ListTile(
                                leading: Icon(Icons.category, color: Colors.teal[700]),
                                title: Text(
                                  cat.nombre,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Monto: \$${cat.montoMaximo.toStringAsFixed(2)}   (${porcentaje.toStringAsFixed(1)}%)',
                                      style: TextStyle(fontSize: 13, color: Colors.grey[700]),
                                    ),
                                    const SizedBox(height: 4),
                                    StreamBuilder<double>(
                                      stream: logic.getTotalGastado(),
                                      builder: (context, snapshot) {
                                        final sumaCategoria = snapshot.data ?? 0.0;
                                        return Text(
                                          'Gastado este mes: \$${sumaCategoria.toStringAsFixed(2)}',
                                          style: TextStyle(
                                            color: Colors.blueGrey[700],
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.teal),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CategoriaDetalleView(
                                        categoria: cat.nombre,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        );
      },
    );
  }
}