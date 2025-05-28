import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:VanguardMoney/core/theme/app_colors.dart';
import 'package:VanguardMoney/core/theme/app_text_styles.dart';
import '../../viewmodels/auth_viewmodel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _goToEditProfile(BuildContext context) {
    context.pushNamed('edit-profile');
  }

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final userData = authViewModel.userData;
    final user = authViewModel.user;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Bolitas de colores en el fondo
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
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black, width: 3),
                        ),
                        child: CircleAvatar(
                          radius: 44,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              (user?.photoURL ?? userData?.photoUrl) != null
                                  ? NetworkImage(
                                    (user?.photoURL ?? userData?.photoUrl)!,
                                  )
                                  : null,
                          child:
                              (user?.photoURL ?? userData?.photoUrl) == null
                                  ? Icon(
                                    Icons.person,
                                    size: 44,
                                    color: Colors.black,
                                  )
                                  : null,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        userData?.nombreCompleto ??
                            user?.displayName ??
                            'Usuario',
                        style: AppTextStyles.headline.copyWith(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userData?.email ?? user?.email ?? 'correo@ejemplo.com',
                        style: AppTextStyles.body.copyWith(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                // Tarjeta de ahorro
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
                    children: [
                      Icon(Icons.savings, color: AppColors.accent, size: 36),
                      const SizedBox(height: 8),
                      Text(
                        '\$1,250.00',
                        style: AppTextStyles.headline.copyWith(
                          color: AppColors.accent,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Total Ahorrado',
                        style: AppTextStyles.body.copyWith(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // Indicador de porcentaje solo con borde accent y texto accent
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.accent, width: 1),
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                        ),
                        child: Text(
                          '+15% este mes',
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.accent,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Botón editar perfil
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.edit,
                        size: 18,
                        color: Colors.white,
                      ),
                      label: const Text('Editar Perfil'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black, // Fondo negro
                        foregroundColor: Colors.white, // Texto blanco
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        textStyle: AppTextStyles.button.copyWith(fontSize: 15),
                        elevation: 0,
                      ),
                      onPressed: () => _goToEditProfile(context),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Opciones de menú
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 0,
                    ),
                    children: [
                      _buildMenuOption(
                        context,
                        icon: Icons.notifications_none,
                        title: 'Notificaciones',
                        onTap: () {},
                        iconColor: Colors.black,
                        textColor: Colors.black,
                      ),
                      _buildMenuOption(
                        context,
                        icon: Icons.security_outlined,
                        title: 'Privacidad y Seguridad',
                        onTap: () {},
                        iconColor: Colors.black,
                        textColor: Colors.black,
                      ),
                      _buildMenuOption(
                        context,
                        icon: Icons.palette_outlined,
                        title: 'Tema',
                        onTap: () => _showThemeDialog(context),
                        iconColor: Colors.black,
                        textColor: Colors.black,
                      ),
                      _buildMenuOption(
                        context,
                        icon: Icons.language_outlined,
                        title: 'Idioma',
                        onTap: () => _showLanguageDialog(context),
                        iconColor: Colors.black,
                        textColor: Colors.black,
                      ),
                      _buildMenuOption(
                        context,
                        icon: Icons.info_outline,
                        title: 'Acerca de',
                        onTap: () => _showAboutDialog(context),
                        iconColor: Colors.black,
                        textColor: Colors.black,
                      ),
                      const SizedBox(height: 12),
                      OutlinedButton.icon(
                        icon: Icon(
                          Icons.logout,
                          color: AppColors.accent,
                          size: 18,
                        ),
                        label: Text(
                          'Cerrar Sesión',
                          style: AppTextStyles.button.copyWith(
                            color: Colors.black, // Texto negro
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                          side: const BorderSide(
                            color: Colors.black,
                            width: 1.2,
                          ), // Borde negro
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed:
                            () => _showLogoutDialog(context, authViewModel),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Widget para las bolitas de colores
  Widget _colorCircle(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }

  // Menú con colores personalizables
  Widget _buildMenuOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color iconColor,
    required Color textColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 22),
        title: Text(
          title,
          style: AppTextStyles.body.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: textColor,
          ),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: AppColors.accent,
          size: 20,
        ), // Flecha roja
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        tileColor: Colors.transparent,
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
        minLeadingWidth: 0,
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Seleccionar Tema'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Icon(Icons.light_mode),
                  title: const Text('Claro'),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tema claro seleccionado')),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: const Text('Oscuro'),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Tema oscuro próximamente')),
                    );
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Seleccionar Idioma'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: const Text('🇪🇸'),
                  title: const Text('Español'),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Idioma: Español')),
                    );
                  },
                ),
                ListTile(
                  leading: const Text('🇺🇸'),
                  title: const Text('English'),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Inglés próximamente')),
                    );
                  },
                ),
              ],
            ),
          ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'VanguardMoney',
      applicationVersion: '1.0.0',
      applicationIcon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(Icons.account_balance_wallet, color: Colors.white),
      ),
      children: [
        const Text('Tu aplicación de gestión financiera personal.'),
        const SizedBox(height: 16),
        const Text('Desarrollado con ❤️ por el equipo VanguardMoney.'),
      ],
    );
  }

  Future<void> _showLogoutDialog(
    BuildContext context,
    AuthViewModel authViewModel,
  ) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(dialogContext).pop(),
            ),
            TextButton(
              child: Text(
                'Cerrar Sesión',
                style: TextStyle(color: AppColors.accent),
              ),
              onPressed: () async {
                Navigator.of(dialogContext).pop();

                // Mostrar indicador de carga
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder:
                      (context) =>
                          const Center(child: CircularProgressIndicator()),
                );

                try {
                  await authViewModel.logout();
                  if (context.mounted) {
                    Navigator.of(context).pop(); // Cierra el loading
                    context.go('/login');
                  }
                } catch (e) {
                  if (context.mounted) {
                    Navigator.of(context).pop(); // Cierra el loading
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al cerrar sesión: $e'),
                        backgroundColor: AppColors.accent,
                      ),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }
}
