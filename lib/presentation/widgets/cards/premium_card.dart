import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/constants/app_constants.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';

class PremiumCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? backgroundColor;
  final bool showShadow;
  final bool showBorder;
  final Widget? header;
  final Widget? footer;

  const PremiumCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.onTap,
    this.backgroundColor,
    this.showShadow = true,
    this.showBorder = false,
    this.header,
    this.footer,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(
        horizontal: AppConstants.mediumSpacing,
        vertical: AppConstants.smallSpacing,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? 
            (isDark ? AppColors.darkSurface : AppColors.lightSurface),
        borderRadius: BorderRadius.circular(AppConstants.largeRadius),
        boxShadow: showShadow
            ? [
                BoxShadow(
                  color: isDark 
                      ? AppColors.shadow.withOpacity(0.3)
                      : AppColors.shadow,
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
        border: showBorder
            ? Border.all(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                width: 1,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.largeRadius),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (header != null)
                Padding(
                  padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                  child: header,
                ),
              Padding(
                padding: padding ?? const EdgeInsets.all(AppConstants.mediumSpacing),
                child: child,
              ),
              if (footer != null)
                Padding(
                  padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                  child: footer,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
