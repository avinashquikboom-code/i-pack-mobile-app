import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/constants/app_constants.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AppIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? size;
  final String? tooltip;

  const AppIconButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.backgroundColor,
    this.iconColor,
    this.size,
    this.tooltip,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Tooltip(
      message: tooltip ?? '',
      child: Container(
        width: size ?? 48,
        height: size ?? 48,
        decoration: BoxDecoration(
          color: backgroundColor ?? 
              (theme.brightness == Brightness.dark 
                  ? AppColors.darkSurfaceVariant 
                  : AppColors.lightSurfaceVariant),
          borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        ),
        child: IconButton(
          icon: PhosphorIcon(
            icon,
            color: iconColor ?? 
                (theme.brightness == Brightness.dark 
                    ? AppColors.darkTextPrimary 
                    : AppColors.lightTextPrimary),
            size: (size ?? 48) * 0.5,
          ),
          onPressed: onPressed,
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
