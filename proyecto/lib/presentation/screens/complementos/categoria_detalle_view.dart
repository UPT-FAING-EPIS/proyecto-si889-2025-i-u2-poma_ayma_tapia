import 'package:VanguardMoney/data/models/productos_model.dart';
import 'package:VanguardMoney/presentation/viewmodels/auth_viewmodel.dart';
import 'package:VanguardMoney/presentation/viewmodels/categoria_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:VanguardMoney/core/theme/app_colors.dart';
import 'package:VanguardMoney/core/theme/app_text_styles.dart';

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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Facturas: $categoria'),
        backgroundColor: AppColors.background,
        elevation: 0,
        titleTextStyle: AppTextStyles.headline.copyWith(fontSize: 20),
        iconTheme: IconThemeData(color: AppColors.primary),
      ),
      body: Column(
        children: [
          // Total gastado (suma solo el total de la factura, no productos individuales)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: AppColors.background,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: StreamBuilder<double>(
                stream: logic.getTotalGastado(),
                builder: (context, snapshot) {
                  final total = snapshot.data ?? 0.0;
                  return Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      children: [
                        Icon(Icons.summarize, color: AppColors.primary, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Total gastado este mes:',
                            style: AppTextStyles.body.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                              color: AppColors.info,
                            ),
                          ),
                        ),
                        Text(
                          '\$${total.toStringAsFixed(2)}',
                          style: AppTextStyles.headline.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: AppColors.primary,
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
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Text('No hay facturas en esta categoría.', style: AppTextStyles.body),
                  );
                }

                final facturasFiltradas = snapshot.data!;

                return ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: facturasFiltradas.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final factura = facturasFiltradas[index];
                    return Container(
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
                      child: ListTile(
                        leading: Icon(Icons.receipt_long, color: AppColors.primary),
                        title: Text(
                          factura.lugarCompra,
                          style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Fecha: ${factura.fechaEmision}',
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.info,
                                  fontSize: 13,
                                )),
                            Text('Total: \$${factura.total.toStringAsFixed(2)}',
                                style: AppTextStyles.body.copyWith(
                                  color: AppColors.secondary,
                                  fontSize: 13,
                                )),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18, color: AppColors.primary),
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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Detalle de Factura'),
        backgroundColor: AppColors.background,
        elevation: 0,
        titleTextStyle: AppTextStyles.headline.copyWith(fontSize: 20),
        iconTheme: IconThemeData(color: AppColors.primary),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: AppColors.background,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // Datos principales de la factura
              Row(
                children: [
                  Icon(Icons.receipt_long, color: AppColors.primary, size: 28),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      factura.lugarCompra,
                      style: AppTextStyles.headline.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text('Fecha de emisión: ${factura.fechaEmision}', style: AppTextStyles.body),
              const SizedBox(height: 4),
              Text('Subtotal: \$${factura.subtotal.toStringAsFixed(2)}', style: AppTextStyles.body),
              const SizedBox(height: 4),
              Text('Impuestos: \$${factura.impuestos.toStringAsFixed(2)}', style: AppTextStyles.body),
              const SizedBox(height: 4),
              Text('Total: \$${factura.total.toStringAsFixed(2)}', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Categoría superior: ${factura.categoriaSuperior}', style: AppTextStyles.body),
              const SizedBox(height: 16),
              Divider(thickness: 1.2, color: AppColors.info.withOpacity(0.2)),
              const SizedBox(height: 8),
              Text('Productos:', style: AppTextStyles.title.copyWith(fontSize: 16)),
              const SizedBox(height: 8),
              ...productos.map((producto) => Card(
                    elevation: 0,
                    color: AppColors.background,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    child: ListTile(
                      leading: Icon(Icons.shopping_cart, color: AppColors.primary),
                      title: Text(producto.descripcion, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                      subtitle: Text(
                        'Monto: \$${producto.importe.toStringAsFixed(2)}\nCategoría: ${producto.categoria}',
                        style: AppTextStyles.body.copyWith(fontSize: 14, color: AppColors.info),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}