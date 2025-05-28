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

  // Bolitas de colores de fondo (igual que en profile_screen)
  Widget _colorCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
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
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: [
                // Bolitas de colores en el fondo (igual que en profile_screen)
                Positioned(
                  top: -40,
                  left: -30,
                  child: _colorCircle(90, AppColors.primary.withOpacity(0.35)),
                ),
                Positioned(
                  top: 80,
                  right: -40,
                  child: _colorCircle(60, AppColors.accent.withOpacity(0.30)),
                ),
                Positioned(
                  bottom: 80,
                  left: -30,
                  child: _colorCircle(50, AppColors.secondary.withOpacity(0.28)),
                ),
                Positioned(
                  bottom: -30,
                  right: 10,
                  child: _colorCircle(70, AppColors.pink.withOpacity(0.25)),
                ),
                // Contenido principal
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Column(
                        children: [
                          // Título y acciones
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Montos por Categoría',
                                style: AppTextStyles.headline.copyWith(
                                  fontSize: 22,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(width: 8),
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
                          const SizedBox(height: 8),
                          // Tarjeta resumen del plan (igual que la de ahorro)
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 32),
                            padding: const EdgeInsets.symmetric(
                              vertical: 24,
                              horizontal: 20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.black, width: 1.2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.03),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.account_balance_wallet, color: AppColors.accent, size: 36),
                                const SizedBox(height: 8),
                                Text(
                                  montoTotal != null
                                      ? '\$${montoTotal.toStringAsFixed(2)}'
                                      : 'Cargando...',
                                  style: AppTextStyles.headline.copyWith(
                                    color: AppColors.accent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Monto total del plan',
                                  style: AppTextStyles.body.copyWith(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 14,
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    // Lista de categorías
                    Expanded(
                      child: categoriasOrdenadas.isEmpty
                          ? const Center(child: Text('No hay datos de categorías guardados.'))
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                              itemCount: categoriasOrdenadas.length,
                              separatorBuilder: (context, index) => const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final cat = categoriasOrdenadas[index];
                                final montoTotal = viewModel.montoTotal;
                                final porcentaje = montoTotal > 0
                                    ? (cat.montoMaximo / montoTotal * 100)
                                    : 0;

                                final uid = Provider.of<AuthViewModel>(context, listen: false).user?.uid ?? '';
                                final logic = CategoriaDetalleLogic(categoria: cat.nombre, uid: uid);

                                return Card(
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                  margin: EdgeInsets.zero,
                                  color: Colors.white,
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
              ],
            ),
          ),
        );
      },
    );
  }
}