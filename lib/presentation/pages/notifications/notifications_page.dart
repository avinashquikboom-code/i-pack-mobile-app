import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/constants/app_constants.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/presentation/widgets/navigation/bottom_navigation.dart';

class NotificationsPage extends StatefulWidget {
  final bool isEmbedded;
  const NotificationsPage({super.key, this.isEmbedded = false});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  int _currentIndex = 3;

  final List<Notification> _notifications = [
    Notification(
      id: '1',
      title: 'Claim Approved',
      description: 'Your screen damage claim has been approved',
      time: '2 hours ago',
      icon: Icons.check_circle,
      color: AppColors.success,
      isRead: false,
    ),
    Notification(
      id: '2',
      title: 'Policy Renewal',
      description: 'Your device protection policy expires in 30 days',
      time: '1 day ago',
      icon: Icons.refresh,
      color: AppColors.warning,
      isRead: false,
    ),
    Notification(
      id: '3',
      title: 'Payment Successful',
      description: 'Your monthly premium payment has been processed',
      time: '2 days ago',
      icon: Icons.payment,
      color: AppColors.tealPrimary,
      isRead: true,
    ),
    Notification(
      id: '4',
      title: 'New Feature Available',
      description: 'Check out our new claims tracking feature',
      time: '3 days ago',
      icon: Icons.star,
      color: AppColors.secondary,
      isRead: true,
    ),
    Notification(
      id: '5',
      title: 'Security Alert',
      description: 'New login detected from your account',
      time: '5 days ago',
      icon: Icons.security,
      color: AppColors.danger,
      isRead: true,
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
                'Notifications',
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      for (var notification in _notifications) {
                        notification.isRead = true;
                      }
                    });
                  },
                  child: Text(
                    'Mark all read',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.tealPrimary,
                    ),
                  ),
                ),
              ],
            ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppConstants.mediumSpacing),
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: AppConstants.mediumSpacing),
            child: _buildNotificationCard(notification, theme, isDark),
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

  Widget _buildNotificationCard(Notification notification, ThemeData theme, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(AppConstants.largeRadius),
        boxShadow: !notification.isRead
            ? [
                BoxShadow(
                  color: notification.color.withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ]
            : [
                BoxShadow(
                  color: isDark 
                      ? AppColors.shadow.withOpacity(0.3)
                      : AppColors.shadow,
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
        border: Border.all(
          color: !notification.isRead 
              ? notification.color.withOpacity(0.3)
              : Colors.transparent,
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              notification.isRead = true;
            });
          },
          borderRadius: BorderRadius.circular(AppConstants.largeRadius),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.mediumSpacing),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: notification.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    notification.icon,
                    color: notification.color,
                    size: 24,
                  ),
                ),
                const SizedBox(width: AppConstants.mediumSpacing),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              notification.title,
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                fontWeight: notification.isRead 
                                    ? FontWeight.w500 
                                    : FontWeight.w600,
                              ),
                            ),
                          ),
                          if (!notification.isRead)
                            Container(
                              width: 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: notification.color,
                                shape: BoxShape.circle,
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        notification.description,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        notification.time,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Notification {
  final String id;
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;
  bool isRead;

  Notification({
    required this.id,
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
    this.isRead = false,
  });
}
