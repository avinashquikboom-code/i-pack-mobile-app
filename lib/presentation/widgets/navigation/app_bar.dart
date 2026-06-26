import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';

class AppAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const AppAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.showBackButton = false,
    this.onBackPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return AppBar(
      title: Text(
        title,
        style: theme.textTheme.headlineSmall?.copyWith(
          color: textColor ?? 
              (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: backgroundColor ?? 
          (isDark ? AppColors.darkSurface : AppColors.lightSurface),
      leading: leading ??
          (showBackButton
              ? IconButton(
                  icon: Icon(
                    Theme.of(context).platform == TargetPlatform.iOS
                        ? Icons.arrow_back_ios_new
                        : Icons.arrow_back,
                    color: textColor ?? 
                        (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
                    size: 24,
                  ),
                  onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                )
              : (automaticallyImplyLeading ? null : const SizedBox())),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
