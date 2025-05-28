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
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: AppColors.accent),
            tooltip: 'Cerrar sesión',
            onPressed: () => _showLogoutDialog(context, authViewModel),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Avatar
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.primary.withOpacity(0.1),
                  width: 3,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.08),
                    blurRadius: 16,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.background,
                backgroundImage:
                    (user?.photoURL ?? userData?.photoUrl) != null
                        ? NetworkImage((user?.photoURL ?? userData?.photoUrl)!)
                        : null,
                child:
                    (user?.photoURL ?? userData?.photoUrl) == null
                        ? Icon(Icons.person, size: 48, color: AppColors.info)
                        : null,
              ),
            ),
            const SizedBox(height: 24),
            // Nombre
            Text(
              userData?.nombreCompleto ?? user?.displayName ?? 'Usuario',
              style: AppTextStyles.headline.copyWith(
                color: AppColors.text,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            // Email
            Text(
              userData?.email ?? user?.email ?? 'correo@ejemplo.com',
              style: AppTextStyles.body.copyWith(
                color: AppColors.info,
                fontSize: 15,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            // Botón Editar Perfil
            SizedBox(
              width: 180,
              child: ElevatedButton.icon(
                icon: Icon(Icons.edit, color: AppColors.background, size: 20),
                label: Text('Editar Perfil', style: AppTextStyles.button),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.background,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: AppTextStyles.button,
                ),
                onPressed: () => _goToEditProfile(context),
              ),
            ),
            const SizedBox(height: 16),
            // Botón Cerrar Sesión
            TextButton.icon(
              icon: Icon(Icons.logout, color: AppColors.accent, size: 20),
              label: Text(
                'Cerrar Sesión',
                style: AppTextStyles.button.copyWith(
                  color: AppColors.accent,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.accent,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () => _showLogoutDialog(context, authViewModel),
            ),
          ],
        ),
      ),
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
                // Captura el messenger ANTES de cerrar el diálogo
                final messenger = ScaffoldMessenger.of(context);
                
                // Cierra el diálogo
                Navigator.of(dialogContext).pop();
                
                try {
                  await authViewModel.logout();
                  if (context.mounted) {
                    context.go('/login');
                  }
                } catch (e) {
                  // Verifica que el contexto siga montado antes de mostrar el SnackBar
                  if (context.mounted) {
                    messenger.showSnackBar(
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
