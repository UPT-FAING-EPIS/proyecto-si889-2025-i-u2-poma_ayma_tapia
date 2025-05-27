import 'package:VanguardMoney/data/models/productos_model.dart';
import 'package:VanguardMoney/presentation/viewmodels/auth_viewmodel.dart';
import 'package:VanguardMoney/presentation/viewmodels/categoria_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoriaDetalleView extends StatelessWidget {
  final String categoria;

  const CategoriaDetalleView({Key? key, required this.categoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uid = Provider.of<AuthViewModel>(context, listen: false).user?.uid;
    if (uid == null) {
      return const Scaffold(
        body: Center(child: Text('Usuario no autenticado.')),
      );
    }

    final logic = CategoriaDetalleLogic(categoria: categoria, uid: uid);

    return Scaffold(
      appBar: AppBar(
        title: Text('Facturas: $categoria'),
        backgroundColor: Colors.teal[700],
      ),
      body: Column(
        children: [
          // Total gastado (suma solo el total de la factura, no productos individuales)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.teal[50],
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: StreamBuilder<double>(
                stream: logic.getTotalGastado(),
                builder: (context, snapshot) {
                  final total = snapshot.data ?? 0.0;
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        const Icon(Icons.summarize, color: Colors.teal, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Total gastado este mes:',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: Colors.teal[900],
                            ),
                          ),
                        ),
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.teal[800],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          // Lista de facturas
          Expanded(
            child: StreamBuilder<List<CompraModel>>(
              stream: logic.getFacturasFiltradas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No hay facturas en esta categoría.'));
                }

                final facturasFiltradas = snapshot.data!;

                return ListView.separated(
                  itemCount: facturasFiltradas.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final factura = facturasFiltradas[index];
                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: ListTile(
                        leading: const Icon(Icons.receipt_long, color: Colors.teal),
                        title: Text(
                          factura.lugarCompra,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fecha: ${factura.fechaEmision}'),
                            Text('Total: \$${factura.total.toStringAsFixed(2)}'),
                          ],
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.teal),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FacturaDetalleView(factura: factura),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Ahora el detalle de la factura muestra todos los productos de la factura, no solo los de la categoría
class FacturaDetalleView extends StatelessWidget {
  final CompraModel factura;

  const FacturaDetalleView({Key? key, required this.factura}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productos = factura.productos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle de Factura'),
        backgroundColor: Colors.teal[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: ListView.separated(
            padding: const EdgeInsets.all(12.0),
            itemCount: productos.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final producto = productos[index];
              return ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.teal),
                title: Text(producto.descripcion, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Monto: \$${producto.importe.toStringAsFixed(2)}\nCategoría: ${producto.categoria}',
                  style: const TextStyle(fontSize: 14),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}