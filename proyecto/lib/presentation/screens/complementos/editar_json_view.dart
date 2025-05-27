import 'dart:ui';
import 'package:VanguardMoney/presentation/screens/home/inicio_screen.dart';
import 'package:VanguardMoney/presentation/widgets/check.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../viewmodels/editar_json_recibido_viewmodel.dart';
import '../../../data/models/productos_model.dart';

class EditarJsonView extends StatefulWidget {
  const EditarJsonView({Key? key}) : super(key: key);

  @override
  State<EditarJsonView> createState() => _EditarJsonViewState();
}

class _EditarJsonViewState extends State<EditarJsonView> {
  bool _showOverlay = false;

  // Controladores para los campos principales
  late TextEditingController lugarController;
  late TextEditingController fechaController;
  late TextEditingController subtotalController;
  late TextEditingController impuestosController;
  late TextEditingController totalController;
  late TextEditingController categoriaSuperiorController;

  // Listas de controladores para los productos
  final List<TextEditingController> descControllers = [];
  final List<TextEditingController> importeControllers = [];
  final List<TextEditingController> categoriaControllers = [];

  @override
  void initState() {
    super.initState();
    final viewModel = Provider.of<EditarJsonRecibidoViewModel>(context, listen: false);

    lugarController = TextEditingController(text: viewModel.compra.lugarCompra);
    fechaController = TextEditingController(text: viewModel.compra.fechaEmision);
    subtotalController = TextEditingController(text: viewModel.compra.subtotal.toString());
    impuestosController = TextEditingController(text: viewModel.compra.impuestos.toString());
    totalController = TextEditingController(text: viewModel.compra.total.toString());
    categoriaSuperiorController = TextEditingController(text: viewModel.compra.categoriaSuperior);

    _initProductoControllers(viewModel);
  }

  void _initProductoControllers(EditarJsonRecibidoViewModel viewModel) {
    descControllers.clear();
    importeControllers.clear();
    categoriaControllers.clear();
    for (var producto in viewModel.compra.productos) {
      descControllers.add(TextEditingController(text: producto.descripcion));
      importeControllers.add(TextEditingController(text: producto.importe.toString()));
      categoriaControllers.add(TextEditingController(text: producto.categoria));
    }
  }

  @override
  void dispose() {
    lugarController.dispose();
    fechaController.dispose();
    subtotalController.dispose();
    impuestosController.dispose();
    totalController.dispose();
    categoriaSuperiorController.dispose();
    for (var c in descControllers) c.dispose();
    for (var c in importeControllers) c.dispose();
    for (var c in categoriaControllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<EditarJsonRecibidoViewModel>(context);

    if (descControllers.length != viewModel.compra.productos.length) {
      _initProductoControllers(viewModel);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Transacción'),
        backgroundColor: Colors.teal[700],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  color: Colors.teal[50],
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Datos principales',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color: Colors.teal,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: fechaController,
                          decoration: const InputDecoration(
                            labelText: 'Fecha de emisión',
                            prefixIcon: Icon(Icons.calendar_today, color: Colors.teal),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            viewModel.actualizarCompra(
                              fechaEmision: value,
                              subtotal: double.tryParse(subtotalController.text) ?? 0,
                              impuestos: double.tryParse(impuestosController.text) ?? 0,
                              total: double.tryParse(totalController.text) ?? 0,
                              lugarCompra: lugarController.text,
                              categoriaSuperior: categoriaSuperiorController.text,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: subtotalController,
                          decoration: const InputDecoration(
                            labelText: 'Subtotal',
                            prefixIcon: Icon(Icons.attach_money, color: Colors.teal),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            viewModel.actualizarCompra(
                              fechaEmision: fechaController.text,
                              subtotal: double.tryParse(value) ?? 0,
                              impuestos: double.tryParse(impuestosController.text) ?? 0,
                              total: double.tryParse(totalController.text) ?? 0,
                              lugarCompra: lugarController.text,
                              categoriaSuperior: categoriaSuperiorController.text,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: impuestosController,
                          decoration: const InputDecoration(
                            labelText: 'Impuestos',
                            prefixIcon: Icon(Icons.percent, color: Colors.teal),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            viewModel.actualizarCompra(
                              fechaEmision: fechaController.text,
                              subtotal: double.tryParse(subtotalController.text) ?? 0,
                              impuestos: double.tryParse(value) ?? 0,
                              total: double.tryParse(totalController.text) ?? 0,
                              lugarCompra: lugarController.text,
                              categoriaSuperior: categoriaSuperiorController.text,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: totalController,
                          decoration: const InputDecoration(
                            labelText: 'Total',
                            prefixIcon: Icon(Icons.calculate, color: Colors.teal),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            viewModel.actualizarCompra(
                              fechaEmision: fechaController.text,
                              subtotal: double.tryParse(subtotalController.text) ?? 0,
                              impuestos: double.tryParse(impuestosController.text) ?? 0,
                              total: double.tryParse(value) ?? 0,
                              lugarCompra: lugarController.text,
                              categoriaSuperior: categoriaSuperiorController.text,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: lugarController,
                          decoration: const InputDecoration(
                            labelText: 'Lugar de Transacción',
                            prefixIcon: Icon(Icons.store, color: Colors.teal),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            viewModel.actualizarCompra(
                              fechaEmision: fechaController.text,
                              subtotal: double.tryParse(subtotalController.text) ?? 0,
                              impuestos: double.tryParse(impuestosController.text) ?? 0,
                              total: double.tryParse(totalController.text) ?? 0,
                              lugarCompra: value,
                              categoriaSuperior: categoriaSuperiorController.text,
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: categoriaSuperiorController,
                          decoration: const InputDecoration(
                            labelText: 'Categoría Superior',
                            prefixIcon: Icon(Icons.category, color: Colors.teal),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            viewModel.actualizarCategoriaSuperior(value);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Detalles de productos',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.teal),
                ),
                ...List.generate(viewModel.compra.productos.length, (index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    color: Colors.white,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: descControllers[index],
                            decoration: const InputDecoration(
                              labelText: 'Descripción',
                              prefixIcon: Icon(Icons.description, color: Colors.teal),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              viewModel.actualizarProducto(
                                index,
                                ProductoModel(
                                  descripcion: value,
                                  importe: double.tryParse(importeControllers[index].text) ?? 0,
                                  categoria: categoriaControllers[index].text,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: importeControllers[index],
                            decoration: const InputDecoration(
                              labelText: 'Importe',
                              prefixIcon: Icon(Icons.attach_money, color: Colors.teal),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                            ),
                            keyboardType: TextInputType.number,
                            onChanged: (value) {
                              viewModel.actualizarProducto(
                                index,
                                ProductoModel(
                                  descripcion: descControllers[index].text,
                                  importe: double.tryParse(value) ?? 0,
                                  categoria: categoriaControllers[index].text,
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 8),
                          TextField(
                            controller: categoriaControllers[index],
                            decoration: const InputDecoration(
                              labelText: 'Categoría',
                              prefixIcon: Icon(Icons.category, color: Colors.teal),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (value) {
                              viewModel.actualizarProducto(
                                index,
                                ProductoModel(
                                  descripcion: descControllers[index].text,
                                  importe: double.tryParse(importeControllers[index].text) ?? 0,
                                  categoria: value,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.save),
                    label: const Text('Guardar Cambios'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    onPressed: () async {
                      try {
                        await viewModel.guardarEnFirestore();
                        setState(() => _showOverlay = true);
                        await Future.delayed(const Duration(seconds: 1));
                        setState(() => _showOverlay = false);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => InicioScreen()),
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error al guardar la información: $e'),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          if (_showOverlay) const StatusOverlay(message: ''),
        ],
      ),
    );
  }
}
