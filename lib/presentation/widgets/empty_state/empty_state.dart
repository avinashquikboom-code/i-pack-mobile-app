import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';

class EmptyState extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String? actionText;
  final VoidCallback? onActionPressed;

  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    this.actionText,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 56,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 15,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            if (actionText != null && onActionPressed != null) ...[
              const SizedBox(height: 24),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: onActionPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    actionText!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyPolicyState extends StatelessWidget {
  const EmptyPolicyState({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.shield_outlined,
      title: 'No Policies Yet',
      description: 'You don\'t have any active policies. Start protecting your devices today!',
      actionText: 'Buy New Plan',
      onActionPressed: () {
        // Navigate to buy plan
      },
    );
  }
}

class EmptyClaimsState extends StatelessWidget {
  const EmptyClaimsState({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.description_outlined,
      title: 'No Claims Yet',
      description: 'You haven\'t filed any claims yet. All your policies are looking great!',
      actionText: 'File a Claim',
      onActionPressed: () {
        // Navigate to file claim
      },
    );
  }
}

class EmptyNotificationsState extends StatelessWidget {
  const EmptyNotificationsState({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.notifications_outlined,
      title: 'No Notifications',
      description: 'You\'re all caught up! We\'ll notify you when there\'s something important.',
    );
  }
}

class EmptySearchState extends StatelessWidget {
  final String searchQuery;

  const EmptySearchState({
    super.key,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.search_off,
      title: 'No Results Found',
      description: 'We couldn\'t find anything matching "$searchQuery". Try a different search term.',
    );
  }
}

class EmptyActivitiesState extends StatelessWidget {
  const EmptyActivitiesState({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.history_outlined,
      title: 'No Recent Activities',
      description: 'Your activity history will appear here once you start using the app.',
    );
  }
}
