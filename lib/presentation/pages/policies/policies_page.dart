import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:i_pack_mobile_app/core/constants/app_constants.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/presentation/widgets/navigation/bottom_navigation.dart';

class PoliciesPage extends StatefulWidget {
  final bool isEmbedded;

  // Constructor allows embedding within responsive home page wrapper
  const PoliciesPage({super.key, this.isEmbedded = false});

  @override
  State<PoliciesPage> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  int _currentIndex = 1;

  final List<Policy> _policies = [
    Policy(
      id: '1',
      name: 'Device Protection',
      description: 'iPhone 15 Pro Max',
      icon: Icons.phone_iphone,
      color: AppColors.tealPrimary,
      status: PolicyStatus.active,
      expiryDate: 'Dec 2025',
      premium: '\$12.99/mo',
    ),
    Policy(
      id: '2',
      name: 'Home Insurance',
      description: 'Premium Plan',
      icon: Icons.home_outlined,
      color: AppColors.secondary,
      status: PolicyStatus.active,
      expiryDate: 'Jun 2025',
      premium: '\$45.00/mo',
    ),
    Policy(
      id: '3',
      name: 'Auto Insurance',
      description: 'Tesla Model 3',
      icon: Icons.directions_car,
      color: AppColors.accent,
      status: PolicyStatus.active,
      expiryDate: 'Mar 2025',
      premium: '\$89.99/mo',
    ),
    Policy(
      id: '4',
      name: 'Travel Insurance',
      description: 'Annual Coverage',
      icon: Icons.flight_takeoff,
      color: AppColors.warning,
      status: PolicyStatus.expiring,
      expiryDate: 'Jan 2025',
      premium: '\$24.99/mo',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: widget.isEmbedded
          ? null
          : AppBar(
              title: Text(
                'My Policies',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.search,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.filter_list,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.mediumSpacing),
        itemCount: _policies.length,
        itemBuilder: (context, index) {
          final policy = _policies[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.mediumSpacing),
            child: Slidable(
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (_) {},
                    backgroundColor: AppColors.warning,
                    foregroundColor: Colors.white,
                    icon: Icons.archive,
                    label: 'Archive',
                    borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
                  ),
                  SlidableAction(
                    onPressed: (_) {},
                    backgroundColor: AppColors.danger,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                    borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(AppConstants.largeRadius),
                  boxShadow: [
                    BoxShadow(
                      color: isDark 
                          ? AppColors.shadow.withOpacity(0.3)
                          : AppColors.shadow,
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(AppConstants.largeRadius),
                    child: Padding(
                      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                      child: Row(
                        children: [
                          Container(
                            width: 56,
                            height: 56,
                            decoration: BoxDecoration(
                              color: policy.color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              policy.icon,
                              color: policy.color,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: AppConstants.mediumSpacing),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  policy.name,
                                  style: theme.textTheme.titleMedium?.copyWith(
                                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  policy.description,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      policy.premium,
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: policy.color,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: AppConstants.smallSpacing),
                                    Text(
                                      '•',
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                                      ),
                                    ),
                                    const SizedBox(width: AppConstants.smallSpacing),
                                    Text(
                                      'Expires ${policy.expiryDate}',
                                      style: theme.textTheme.labelSmall?.copyWith(
                                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: AppConstants.smallSpacing),
                          _buildStatusChip(policy.status, theme, isDark),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: widget.isEmbedded
          ? null
          : AppBottomNavigation(
              currentIndex: _currentIndex,
              onTap: (index) {
                if (index == 0) Navigator.of(context).pushReplacementNamed('/home');
                if (index == 1) Navigator.of(context).pushReplacementNamed('/policies');
                if (index == 2) Navigator.of(context).pushReplacementNamed('/claims');
                if (index == 3) Navigator.of(context).pushReplacementNamed('/notifications');
                if (index == 4) Navigator.of(context).pushReplacementNamed('/profile');
              },
            ),
    );
  }

  Widget _buildStatusChip(PolicyStatus status, ThemeData theme, bool isDark) {
    Color color;
    String label;
    
    switch (status) {
      case PolicyStatus.active:
        color = AppColors.success;
        label = 'Active';
        break;
      case PolicyStatus.expiring:
        color = AppColors.warning;
        label = 'Expiring';
        break;
      case PolicyStatus.expired:
        color = AppColors.danger;
        label = 'Expired';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: theme.textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class Policy {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;
  final PolicyStatus status;
  final String expiryDate;
  final String premium;

  Policy({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
    required this.status,
    required this.expiryDate,
    required this.premium,
  });
}

enum PolicyStatus {
  active,
  expiring,
  expired,
}
