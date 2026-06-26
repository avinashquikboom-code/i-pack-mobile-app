import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/constants/app_constants.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? AppColors.shadow.withValues(alpha: 0.3)
                : AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.mediumSpacing,
            vertical: AppConstants.smallSpacing,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                context,
                icon: Icons.home_rounded,
                label: 'Home',
                index: 0,
                isSelected: currentIndex == 0,
              ),
              _buildNavItem(
                context,
                icon: Icons.shield_rounded,
                label: 'Policies',
                index: 1,
                isSelected: currentIndex == 1,
              ),
              _buildNavItem(
                context,
                icon: Icons.description_rounded,
                label: 'Claims',
                index: 2,
                isSelected: currentIndex == 2,
              ),
              _buildNavItem(
                context,
                icon: Icons.notifications_rounded,
                label: 'Alerts',
                index: 3,
                isSelected: currentIndex == 3,
              ),
              _buildNavItem(
                context,
                icon: Icons.person_rounded,
                label: 'Profile',
                index: 4,
                isSelected: currentIndex == 4,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required int index,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Expanded(
      child: InkWell(
        onTap: () => onTap(index),
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(
            vertical: AppConstants.smallSpacing,
          ),
          decoration: BoxDecoration(
            color: isSelected 
                ? AppColors.tealPrimary.withValues(alpha: 0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: isSelected 
                    ? const EdgeInsets.all(8)
                    : EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: isSelected 
                      ? AppColors.tealPrimary
                      : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: isSelected
                      ? Colors.white
                      : (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
                  size: 24,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: isSelected
                      ? AppColors.tealPrimary
                      : (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
