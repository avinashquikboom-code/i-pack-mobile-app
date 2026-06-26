import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/presentation/widgets/navigation/bottom_navigation.dart';

class ClaimsPage extends StatefulWidget {
  final bool isEmbedded;
  const ClaimsPage({super.key, this.isEmbedded = false});

  @override
  State<ClaimsPage> createState() => _ClaimsPageState();
}

class _ClaimsPageState extends State<ClaimsPage> {
  final int _currentIndex = 2;

  final List<Claim> _claims = [
    Claim(
      id: '1',
      title: 'Screen Damage',
      description: 'iPhone 15 Pro Max screen cracked',
      device: 'iPhone 15 Pro Max',
      date: 'Dec 15, 2024',
      status: ClaimStatus.approved,
      amount: '₹299.00',
      icon: Icons.screen_rotation,
      color: AppColors.primary,
    ),
    Claim(
      id: '2',
      title: 'Water Damage',
      description: 'MacBook Pro liquid spill',
      device: 'MacBook Pro 14"',
      date: 'Dec 10, 2024',
      status: ClaimStatus.inProgress,
      amount: '₹1,200.00',
      icon: Icons.water_drop,
      color: AppColors.secondary,
    ),
    Claim(
      id: '3',
      title: 'Theft Claim',
      description: 'AirPods Pro stolen',
      device: 'AirPods Pro',
      date: 'Dec 5, 2024',
      status: ClaimStatus.pending,
      amount: '₹249.00',
      icon: Icons.report_problem,
      color: AppColors.accent,
    ),
    Claim(
      id: '4',
      title: 'Battery Replacement',
      description: 'Samsung S24 Ultra battery swollen',
      device: 'Samsung Galaxy S24 Ultra',
      date: 'Nov 28, 2024',
      status: ClaimStatus.rejected,
      amount: '₹150.00',
      icon: Icons.battery_charging_full,
      color: AppColors.error,
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
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Claims',
                    style: TextStyle(
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          // Summary Stats
          Container(
            margin: widget.isEmbedded 
                ? const EdgeInsets.all(20)
                : const EdgeInsets.all(20),
            child: Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    label: 'Total',
                    value: '${_claims.length}',
                    icon: Icons.description,
                    color: AppColors.primary,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    label: 'Approved',
                    value: '${_claims.where((c) => c.status == ClaimStatus.approved).length}',
                    icon: Icons.check_circle,
                    color: AppColors.success,
                    isDark: isDark,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatCard(
                    context,
                    label: 'Pending',
                    value: '${_claims.where((c) => c.status == ClaimStatus.pending || c.status == ClaimStatus.inProgress).length}',
                    icon: Icons.pending,
                    color: AppColors.warning,
                    isDark: isDark,
                  ),
                ),
              ],
            ),
          ),
          
          // Claims List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _claims.length,
              itemBuilder: (context, index) {
                final claim = _claims[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildClaimCard(claim, isDark),
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
                if (index == 3) Navigator.of(context).pushReplacementNamed('/profile');
              },
            ),
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildClaimCard(Claim claim, bool isDark) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _showClaimDetailsBottomSheet(context, claim, isDark),
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: claim.color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        claim.icon,
                        color: claim.color,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            claim.title,
                            style: TextStyle(
                              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            claim.device,
                            style: TextStyle(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildStatusChip(claim.status),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  claim.description,
                  style: TextStyle(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    fontSize: 14,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Timeline
                _buildTimeline(claim.status, isDark),
                
                const SizedBox(height: 20),
                
                // Footer
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBackground : AppColors.lightBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 16,
                            color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            claim.date,
                            style: TextStyle(
                              color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        claim.amount,
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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

  Widget _buildStatusChip(ClaimStatus status) {
    Color color;
    String label;
    
    switch (status) {
      case ClaimStatus.approved:
        color = AppColors.success;
        label = 'Approved';
        break;
      case ClaimStatus.inProgress:
        color = AppColors.accent;
        label = 'In Progress';
        break;
      case ClaimStatus.pending:
        color = AppColors.warning;
        label = 'Pending';
        break;
      case ClaimStatus.rejected:
        color = AppColors.error;
        label = 'Rejected';
        break;
    }
    
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
          width: 1.5,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildTimeline(ClaimStatus status, bool isDark) {
    final steps = [
      {'label': 'Submitted', 'icon': Icons.file_upload},
      {'label': 'Review', 'icon': Icons.search},
      {'label': 'Processing', 'icon': Icons.settings},
      {'label': 'Completed', 'icon': Icons.check_circle},
    ];
    
    final currentStep = status == ClaimStatus.approved 
        ? 3 
        : status == ClaimStatus.inProgress 
            ? 2 
            : status == ClaimStatus.pending 
                ? 1 
                : 0;
    
    return Column(
      children: [
        Row(
          children: List.generate(steps.length, (index) {
            final isCompleted = index <= currentStep;
            final isLast = index == steps.length - 1;
            final isCurrent = index == currentStep;
            
            return Expanded(
              child: Row(
                children: [
                  Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          gradient: isCompleted 
                              ? AppColors.primaryGradient 
                              : null,
                          color: !isCompleted 
                              ? (isDark 
                                  ? AppColors.darkSurfaceVariant 
                                  : AppColors.lightSurfaceVariant)
                              : null,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: isCompleted 
                                ? AppColors.primary 
                                : (isDark 
                                    ? AppColors.darkBorder 
                                    : AppColors.lightBorder),
                            width: 2,
                          ),
                          boxShadow: isCompleted || isCurrent
                              ? [
                                  BoxShadow(
                                    color: AppColors.primary.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: isCompleted
                            ? const Icon(
                                Icons.check,
                                size: 18,
                                color: Colors.white,
                              )
                            : Icon(
                                steps[index]['icon'] as IconData,
                                size: 18,
                                color: isCurrent 
                                    ? AppColors.primary 
                                    : (isDark 
                                        ? AppColors.darkTextTertiary 
                                        : AppColors.lightTextTertiary),
                              ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        steps[index]['label'] as String,
                        style: TextStyle(
                          color: isCompleted 
                              ? AppColors.primary 
                              : (isDark 
                                  ? AppColors.darkTextTertiary 
                                  : AppColors.lightTextTertiary),
                          fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w500,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  if (!isLast)
                    Expanded(
                      child: Container(
                        height: 3,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          gradient: isCompleted
                              ? AppColors.primaryGradient
                              : LinearGradient(
                                  colors: [
                                    isDark 
                                        ? AppColors.darkSurfaceVariant 
                                        : AppColors.lightSurfaceVariant,
                                    isDark 
                                        ? AppColors.darkSurfaceVariant 
                                        : AppColors.lightSurfaceVariant,
                                  ],
                                ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  void _showClaimDetailsBottomSheet(BuildContext context, Claim claim, bool isDark) {
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
                      color: claim.color.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      claim.icon,
                      color: claim.color,
                      size: 28,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          claim.title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          claim.device,
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
              const SizedBox(height: 20),
              
              // Description Box
              Text(
                'Description:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                claim.description,
                style: TextStyle(
                  fontSize: 14,
                  height: 1.4,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
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
                    _buildDetailRow('Claim ID', 'CLM-2024-${claim.id}742', isDark),
                    const Divider(height: 24),
                    _buildDetailRow('Claim Value', claim.amount, isDark, valueColor: claim.color),
                    const Divider(height: 24),
                    _buildDetailRow('Date Filed', claim.date, isDark),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Progress Timeline Header
              Text(
                'Tracking Timeline:',
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                ),
              ),
              const SizedBox(height: 12),
              
              // Embed Timeline
              _buildTimeline(claim.status, isDark),
              const SizedBox(height: 28),
              
              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                        _showSuccessSnackBar(context, 'Opening camera to scan documents...');
                      },
                      icon: const Icon(Icons.cloud_upload_outlined, color: Colors.white),
                      label: const Text('Upload Documents'),
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
                        _showSuccessSnackBar(context, 'Calling adjuster: +1 (800) 555-0155');
                      },
                      icon: Icon(Icons.headset_mic_outlined, color: claim.color),
                      label: Text('Contact Adjuster', style: TextStyle(color: claim.color)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: claim.color, width: 1.5),
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

class Claim {
  final String id;
  final String title;
  final String description;
  final String device;
  final String date;
  final ClaimStatus status;
  final String amount;
  final IconData icon;
  final Color color;

  Claim({
    required this.id,
    required this.title,
    required this.description,
    required this.device,
    required this.date,
    required this.status,
    required this.amount,
    required this.icon,
    required this.color,
  });
}

enum ClaimStatus {
  pending,
  inProgress,
  approved,
  rejected,
}
