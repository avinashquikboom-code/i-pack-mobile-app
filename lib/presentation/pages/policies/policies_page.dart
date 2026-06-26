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
  final int _currentIndex = 1;

  final List<Policy> _policies = [
    Policy(
      id: '1',
      name: 'Device Protection',
      description: 'iPhone 15 Pro Max',
      icon: Icons.phone_iphone,
      color: AppColors.tealPrimary,
      status: PolicyStatus.active,
      expiryDate: 'Dec 2025',
      premium: '₹12.99/mo',
    ),
    Policy(
      id: '2',
      name: 'Home Insurance',
      description: 'Premium Plan',
      icon: Icons.home_outlined,
      color: AppColors.secondary,
      status: PolicyStatus.active,
      expiryDate: 'Jun 2025',
      premium: '₹45.00/mo',
    ),
    Policy(
      id: '3',
      name: 'Auto Insurance',
      description: 'Tesla Model 3',
      icon: Icons.directions_car,
      color: AppColors.accent,
      status: PolicyStatus.active,
      expiryDate: 'Mar 2025',
      premium: '₹89.99/mo',
    ),
    Policy(
      id: '4',
      name: 'Travel Insurance',
      description: 'Annual Coverage',
      icon: Icons.flight_takeoff,
      color: AppColors.warning,
      status: PolicyStatus.expiring,
      expiryDate: 'Jan 2025',
      premium: '₹24.99/mo',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: Column(
        children: [
          if (widget.isEmbedded)
            Container(
              padding: const EdgeInsets.all(AppConstants.mediumSpacing),
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Policies',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        ),
                        onPressed: () {
                          _showSuccessSnackBar(context, 'Search feature activated');
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.filter_list,
                          color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        ),
                        onPressed: () {
                          _showSuccessSnackBar(context, 'Filters updated to All Policies');
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              padding: widget.isEmbedded 
                  ? const EdgeInsets.all(AppConstants.mediumSpacing)
                  : null,
              itemCount: _policies.length,
              itemBuilder: (context, index) {
          final policy = _policies[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
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
                    borderRadius: BorderRadius.circular(16),
                  ),
                  SlidableAction(
                    onPressed: (_) {},
                    backgroundColor: AppColors.error,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                    borderRadius: BorderRadius.circular(16),
                  ),
                ],
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => _showPolicyDetailsBottomSheet(context, policy, isDark),
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: policy.color.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Icon(
                              policy.icon,
                              color: policy.color,
                              size: 30,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  policy.name,
                                  style: TextStyle(
                                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  policy.description,
                                  style: TextStyle(
                                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                    fontSize: 13,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 4,
                                  children: [
                                    Text(
                                      policy.premium,
                                      style: TextStyle(
                                        color: policy.color,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      '•',
                                      style: TextStyle(
                                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      'Expires ${policy.expiryDate}',
                                      style: TextStyle(
                                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
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
          ),
        ],
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
        color: color.withValues(alpha: 0.1),
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

  void _showPolicyDetailsBottomSheet(BuildContext context, Policy policy, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
            border: Border.all(
              color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Pull Bar
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Header
              Row(
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: policy.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      policy.icon,
                      color: policy.color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          policy.name,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          policy.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Details Grid
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isDark ? AppColors.darkBorder.withValues(alpha: 0.5) : AppColors.lightBorder.withValues(alpha: 0.5),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    _buildDetailRow('Policy Number', 'POL-2024-${policy.id}829', isDark),
                    const Divider(height: 24),
                    _buildDetailRow('Monthly Premium', policy.premium, isDark, valueColor: policy.color),
                    const Divider(height: 24),
                    _buildDetailRow('Expiry Date', policy.expiryDate, isDark),
                    const Divider(height: 24),
                    _buildDetailRow('Coverage Limit', '₹5,000.00', isDark),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showSuccessSnackBar(context, 'Downloading policy document PDF...');
                      },
                      icon: const Icon(Icons.file_download_outlined, color: Colors.white),
                      label: const Text('Download PDF'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showSuccessSnackBar(context, 'Connecting to claims department...');
                      },
                      icon: Icon(Icons.add_moderator_outlined, color: policy.color),
                      label: Text('File Claim', style: TextStyle(color: policy.color)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: policy.color, width: 1.5),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    _showSuccessSnackBar(context, 'Calling agent: +1 (800) 555-0199');
                  },
                  icon: const Icon(Icons.phone_outlined, color: AppColors.secondary),
                  label: const Text(
                    'Contact Insurance Agent',
                    style: TextStyle(color: AppColors.secondary, fontWeight: FontWeight.bold),
                  ),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDark, {Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary),
          ),
        ),
      ],
    );
  }

  void _showSuccessSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 12),
            Text(message),
          ],
        ),
        backgroundColor: AppColors.success,
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
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
