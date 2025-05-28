import 'package:VanguardMoney/presentation/viewmodels/categoria_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:VanguardMoney/core/theme/app_colors.dart';
import 'package:VanguardMoney/core/theme/app_text_styles.dart';
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
  final List<String> ordenCategorias = const [
    'Alimentos',
    'Hogar',
    'Ropa',
    'Salud',
    'Tecnología',
    'Entretenimiento',
    'Transporte',
    'Mascotas',
    'Otros',
  ];

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

        final categoriasOrdenadas = [
          for (final nombre in ordenCategorias)
            ...viewModel.categorias.where((c) => c.nombre == nombre)
        ];

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            title: Text(
              'Montos por Categoría',
              style: AppTextStyles.headline.copyWith(fontSize: 20),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit, color: AppColors.primary),
                tooltip: 'Editar plan',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => PlanesScreen()),
                  );
                },
              ),
              IconButton(
                icon: Icon(Icons.refresh, color: AppColors.primary),
                onPressed: () {
                  setState(() {});
                },
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: categoriasOrdenadas.isEmpty
                ? const Center(child: Text('No hay datos de categorías guardados.'))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tarjeta resumen del plan
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.zero,
                        color: AppColors.background,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Monto total del plan',
                                style: AppTextStyles.title,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '\$${montoTotal.toStringAsFixed(2)}',
                                style: AppTextStyles.headline.copyWith(fontSize: 22, color: AppColors.primary),
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
                                          Icon(Icons.receipt_long, color: AppColors.primary, size: 22),
                                          const SizedBox(width: 8),
                                          Text(
                                            'Total gastado este mes: ',
                                            style: AppTextStyles.body.copyWith(
                                              color: AppColors.info,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 15,
                                            ),
                                          ),
                                          Text(
                                            '\$${totalFacturas.toStringAsFixed(2)}',
                                            style: AppTextStyles.body.copyWith(
                                              color: AppColors.secondary,
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
                          itemCount: categoriasOrdenadas.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final cat = categoriasOrdenadas[index];
                            final porcentaje = montoTotal > 0
                                ? (cat.montoMaximo / montoTotal * 100)
                                : 0;

                            final uid = Provider.of<AuthViewModel>(context, listen: false).user?.uid ?? '';
                            final logic = CategoriaDetalleLogic(categoria: cat.nombre, uid: uid);

                            return Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                              margin: EdgeInsets.zero,
                              color: AppColors.background,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ListTile(
                                      leading: Icon(Icons.category, color: AppColors.primary),
                                      title: Text(
                                        cat.nombre,
                                        style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18, color: AppColors.primary),
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
                                    StreamBuilder<double>(
                                      stream: logic.getTotalGastado(),
                                      builder: (context, snapshot) {
                                        final gastado = snapshot.data ?? 0.0;
                                        final meta = cat.montoMaximo;
                                        final porcentaje = meta > 0 ? (gastado / meta).clamp(0.0, 1.0) : 0.0;

                                        // Selección de color según el porcentaje
                                        Color barraColor;
                                        if (porcentaje > 0.9) {
                                          barraColor = AppColors.accent;
                                        } else if (porcentaje > 0.75) {
                                          barraColor = AppColors.warning;
                                        } else {
                                          barraColor = AppColors.secondary;
                                        }

                                        return Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                                              child: Row(
                                                children: [
                                                  // Monto gastado a la izquierda, fuera de la barra
                                                  Text(
                                                    '\$${gastado.toStringAsFixed(2)}',
                                                    style: AppTextStyles.body.copyWith(
                                                      color: AppColors.info,
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  // Barra de progreso
                                                  Expanded(
                                                    child: Stack(
                                                      alignment: Alignment.centerLeft,
                                                      children: [
                                                        Container(
                                                          height: 14,
                                                          decoration: BoxDecoration(
                                                            color: AppColors.info.withOpacity(0.1),
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        FractionallySizedBox(
                                                          alignment: Alignment.centerLeft,
                                                          widthFactor: porcentaje,
                                                          child: Container(
                                                            height: 14,
                                                            decoration: BoxDecoration(
                                                              color: barraColor,
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  // Meta a la derecha, fuera de la barra
                                                  Text(
                                                    '\$${meta.toStringAsFixed(2)}',
                                                    style: AppTextStyles.body.copyWith(
                                                      color: AppColors.primary,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'Meta: \$${meta.toStringAsFixed(2)}',
                                              style: AppTextStyles.body.copyWith(
                                                color: AppColors.primary,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              'Gastado este mes: \$${gastado.toStringAsFixed(2)}',
                                              style: AppTextStyles.body.copyWith(
                                                color: AppColors.info,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ],
                                ),
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