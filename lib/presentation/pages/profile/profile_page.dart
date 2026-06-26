import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/constants/app_constants.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/presentation/widgets/navigation/bottom_navigation.dart';

class ProfilePage extends StatefulWidget {
  final bool isEmbedded;
  const ProfilePage({super.key, this.isEmbedded = false});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final int _currentIndex = 4;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.mediumSpacing),
          child: Column(
            children: [
              const SizedBox(height: AppConstants.smallSpacing),
              
              // Profile Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.tealPrimary,
                            AppColors.tealLight,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(32),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.tealPrimary.withValues(alpha: 0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 48,
                        ),
                      ),
                    ),
                    const SizedBox(height: AppConstants.mediumSpacing),
                    Text(
                      'John Doe',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'john.doe@email.com',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                      ),
                    ),
                    const SizedBox(height: AppConstants.mediumSpacing),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.tealPrimary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.workspace_premium,
                            color: AppColors.tealPrimary,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Premium Member',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: AppColors.tealPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppConstants.extraLargeSpacing),
              
              // Stats Section
              Row(
                children: [
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: Icons.shield,
                      label: 'Policies',
                      value: '4',
                      color: AppColors.tealPrimary,
                    ),
                  ),
                  const SizedBox(width: AppConstants.mediumSpacing),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: Icons.description,
                      label: 'Claims',
                      value: '3',
                      color: AppColors.secondary,
                    ),
                  ),
                  const SizedBox(width: AppConstants.mediumSpacing),
                  Expanded(
                    child: _buildStatCard(
                      context,
                      icon: Icons.star,
                      label: 'Score',
                      value: '85',
                      color: AppColors.accent,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.extraLargeSpacing),
              
              // Menu Items
              _buildMenuItem(
                context,
                icon: Icons.person_outline,
                title: 'Personal Information',
                subtitle: 'Update your profile details',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.payment,
                title: 'Payment Methods',
                subtitle: 'Manage your payment options',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.history,
                title: 'Claim History',
                subtitle: 'View your past claims',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.settings,
                title: 'Settings',
                subtitle: 'App preferences and settings',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.help_outline,
                title: 'Help & Support',
                subtitle: 'Get help with your account',
                onTap: () {},
              ),
              _buildMenuItem(
                context,
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'App version and information',
                onTap: () {},
              ),
              const SizedBox(height: AppConstants.largeSpacing),
              
              // Logout Button
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppConstants.mediumSpacing),
                decoration: BoxDecoration(
                  color: AppColors.danger.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: AppColors.danger,
                    ),
                    const SizedBox(width: AppConstants.smallSpacing),
                    Text(
                      'Log Out',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.danger,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 100),
            ],
          ),
        ),
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

  Widget _buildStatCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? AppColors.shadow.withValues(alpha: 0.3)
                : AppColors.shadow,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineSmall?.copyWith(
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.labelSmall?.copyWith(
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.smallSpacing),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppConstants.mediumRadius),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.mediumSpacing),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark 
                        ? AppColors.darkSurfaceVariant 
                        : AppColors.lightSurfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    icon,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    size: 20,
                  ),
                ),
                const SizedBox(width: AppConstants.mediumSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        subtitle,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
