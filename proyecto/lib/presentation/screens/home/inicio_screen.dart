import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../../viewmodels/inicio_viewmodel.dart';
import '../../viewmodels/auth_viewmodel.dart';
import 'package:VanguardMoney/data/models/productos_model.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:VanguardMoney/core/theme/app_colors.dart';
import 'package:VanguardMoney/core/theme/app_text_styles.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({Key? key}) : super(key: key);

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  double? limiteGastoDiario;
  bool _cargandoLimite = true;

  @override
  void initState() {
    super.initState();
    _cargarLimite();
  }

  Future<void> _cargarLimite() async {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final limite = await auth.getLimiteGastoDiario();
    setState(() {
      limiteGastoDiario = limite;
      _cargandoLimite = false;
    });
  }

  void _cambiarLimite() async {
    final controller = TextEditingController(
      text: limiteGastoDiario?.toStringAsFixed(2) ?? '',
    );
    final result = await showDialog<double>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Configurar límite diario'),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(labelText: 'Nuevo límite'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  final value = double.tryParse(controller.text);
                  if (value != null && value > 0) {
                    Navigator.pop(context, value);
                  }
                },
                child: const Text('Guardar'),
              ),
            ],
          ),
    );
    if (result != null) {
      final auth = Provider.of<AuthViewModel>(context, listen: false);
      await auth.setLimiteGastoDiario(result);
      setState(() {
        limiteGastoDiario = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthViewModel>(context, listen: false);
    final viewModel =
        auth.user != null
            ? InicioViewModel(
              auth.user!.uid,
              auth.userData?.nombreCompleto ?? 'Usuario',
            )
            : null;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: Text(
          'Resumen Financiero',
          style: AppTextStyles.headline.copyWith(fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings, color: AppColors.primary),
            onPressed: _cambiarLimite,
          ),
          IconButton(
            icon: Icon(Icons.refresh, color: AppColors.primary),
            onPressed: _cargarLimite,
          ),
        ],
      ),
      body:
          viewModel == null
              ? const Center(child: Text('Usuario no autenticado'))
              : _cargandoLimite
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Saludo
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 16),
                      child: Text(
                        viewModel.getSaludo(),
                        style: AppTextStyles.body.copyWith(
                          fontSize: 16,
                          color: AppColors.info,
                        ),
                      ),
                    ),
                    // Tarjeta de balance/resumen del día
                    _ResumenDiaCard(
                      viewModel: viewModel,
                      limiteGastoDiario: limiteGastoDiario,
                    ),
                    const SizedBox(height: 24),
                    // Últimos egresos (transacciones)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Últimos Egresos', style: AppTextStyles.title),
                        TextButton(
                          onPressed: () => context.go('/egresos'),
                          child: const Text('Ver todos'),
                        ),
                      ],
                    ),
                    _UltimosEgresosList(viewModel: viewModel),
                  ],
                ),
              ),
    );
  }
}

// Tarjeta resumen del día
class _ResumenDiaCard extends StatelessWidget {
  final InicioViewModel viewModel;
  final double? limiteGastoDiario;
  const _ResumenDiaCard({
    required this.viewModel,
    required this.limiteGastoDiario,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: StreamBuilder<double>(
          stream: viewModel.getTotalHoy(),
          builder: (context, snapshot) {
            final gasto = snapshot.data ?? 0.0;
            final limite = limiteGastoDiario ?? 0.0;
            final percent =
                (limite > 0) ? (gasto / limite).clamp(0.0, 1.0) : 0.0;
            Color color;
            if (percent < 0.5) {
              color = AppColors.secondary;
            } else if (percent < 0.8) {
              color = AppColors.warning;
            } else {
              color = AppColors.accent;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Gastos del Día', style: AppTextStyles.title),
                const SizedBox(height: 12),
                Row(
                  children: [
                    // Indicador circular
                    CircularPercentIndicator(
                      radius: 48,
                      lineWidth: 10,
                      percent: percent,
                      center: Text(
                        '\$${gasto.toStringAsFixed(2)}',
                        style: AppTextStyles.headline.copyWith(fontSize: 18),
                      ),
                      progressColor: color,
                      backgroundColor: AppColors.info.withOpacity(0.1),
                      circularStrokeCap: CircularStrokeCap.round,
                      animation: true,
                    ),
                    const SizedBox(width: 24),
                    // Info de límite
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Límite diario',
                            style: AppTextStyles.body.copyWith(
                              color: AppColors.info,
                            ),
                          ),
                          Text(
                            limiteGastoDiario == null
                                ? 'No definido'
                                : '\$${limiteGastoDiario!.toStringAsFixed(2)}',
                            style: AppTextStyles.title.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Lista de últimos egresos
class _UltimosEgresosList extends StatelessWidget {
  final InicioViewModel viewModel;
  const _UltimosEgresosList({required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CompraModel>>(
      stream: viewModel.getUltimasCompras(),
      builder: (context, snapshot) {
        final compras = snapshot.data ?? [];
        if (compras.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 24),
            child: Text('No hay egresos recientes', style: AppTextStyles.body),
          );
        }
        return Column(
          children:
              compras
                  .map((compra) => _TransaccionCard(compra: compra))
                  .toList(),
        );
      },
    );
  }
}

// Tarjeta de transacción
class _TransaccionCard extends StatelessWidget {
  final CompraModel compra;
  const _TransaccionCard({required this.compra});

  @override
  Widget build(BuildContext context) {
    DateTime? fecha;
    try {
      fecha = DateFormat('dd/MM/yyyy HH:mm:ss').parse(compra.fechaEmision);
    } catch (_) {}
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
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
          Icon(Icons.shopping_bag, color: AppColors.primary, size: 28),
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
                if (fecha != null)
                  Text(
                    DateFormat('dd MMM yyyy - HH:mm').format(fecha),
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.info,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            '-\$${compra.total.toStringAsFixed(2)}',
            style: AppTextStyles.body.copyWith(
              color: AppColors.accent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
