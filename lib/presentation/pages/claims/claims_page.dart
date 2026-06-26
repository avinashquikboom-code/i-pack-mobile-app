import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/constants/app_constants.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/presentation/widgets/buttons/primary_button.dart';
import 'package:i_pack_mobile_app/presentation/widgets/navigation/bottom_navigation.dart';

class ClaimsPage extends StatefulWidget {
  final bool isEmbedded;
  const ClaimsPage({super.key, this.isEmbedded = false});

  @override
  State<ClaimsPage> createState() => _ClaimsPageState();
}

class _ClaimsPageState extends State<ClaimsPage> {
  int _currentIndex = 2;

  final List<Claim> _claims = [
    Claim(
      id: '1',
      title: 'Screen Damage',
      description: 'iPhone 15 Pro Max screen cracked',
      date: 'Dec 15, 2024',
      status: ClaimStatus.approved,
      amount: '\$299.00',
    ),
    Claim(
      id: '2',
      title: 'Water Damage',
      description: 'MacBook Pro liquid spill',
      date: 'Dec 10, 2024',
      status: ClaimStatus.inProgress,
      amount: '\$1,200.00',
    ),
    Claim(
      id: '3',
      title: 'Theft Claim',
      description: 'AirPods Pro stolen',
      date: 'Dec 5, 2024',
      status: ClaimStatus.pending,
      amount: '\$249.00',
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
                'Claims',
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
                    Icons.add,
                    color: AppColors.tealPrimary,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
      body: Column(
        children: [
          // Summary Card
          Container(
            margin: const EdgeInsets.all(AppConstants.mediumSpacing),
            padding: const EdgeInsets.all(AppConstants.largeSpacing),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.tealPrimary,
                  AppColors.tealLight,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppConstants.largeRadius),
              boxShadow: [
                BoxShadow(
                  color: AppColors.tealPrimary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Claims',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${_claims.length}',
                      style: theme.textTheme.displayMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                PrimaryButton(
                  text: 'New Claim',
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  textColor: AppColors.tealPrimary,
                ),
              ],
            ),
          ),
          
          // Claims List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.mediumSpacing),
              itemCount: _claims.length,
              itemBuilder: (context, index) {
                final claim = _claims[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: AppConstants.mediumSpacing),
                  child: _buildClaimCard(claim, theme, isDark),
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

  Widget _buildClaimCard(Claim claim, ThemeData theme, bool isDark) {
    return Container(
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      claim.title,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    _buildStatusChip(claim.status, theme),
                  ],
                ),
                const SizedBox(height: AppConstants.smallSpacing),
                Text(
                  claim.description,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: AppConstants.mediumSpacing),
                
                // Timeline
                _buildTimeline(claim.status, theme, isDark),
                
                const SizedBox(height: AppConstants.mediumSpacing),
                
                // Footer
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      claim.date,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                      ),
                    ),
                    Text(
                      claim.amount,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: AppColors.tealPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(ClaimStatus status, ThemeData theme) {
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
        color = AppColors.danger;
        label = 'Rejected';
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

  Widget _buildTimeline(ClaimStatus status, ThemeData theme, bool isDark) {
    final steps = [
      'Submitted',
      'Review',
      'Processing',
      'Completed',
    ];
    
    final currentStep = status == ClaimStatus.approved 
        ? 3 
        : status == ClaimStatus.inProgress 
            ? 2 
            : status == ClaimStatus.pending 
                ? 1 
                : 0;
    
    return Row(
      children: List.generate(steps.length, (index) {
        final isCompleted = index <= currentStep;
        final isLast = index == steps.length - 1;
        
        return Expanded(
          child: Row(
            children: [
              Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: isCompleted ? AppColors.tealPrimary : 
                          (isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isCompleted ? AppColors.tealPrimary : 
                            (isDark ? AppColors.darkBorder : AppColors.lightBorder),
                      ),
                    ),
                    child: isCompleted
                        ? const Icon(
                            Icons.check,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    steps[index],
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: isCompleted 
                          ? AppColors.tealPrimary 
                          : (isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary),
                      fontWeight: isCompleted ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    height: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isCompleted ? AppColors.tealPrimary : 
                          (isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant),
                    ),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}

class Claim {
  final String id;
  final String title;
  final String description;
  final String date;
  final ClaimStatus status;
  final String amount;

  Claim({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.amount,
  });
}

enum ClaimStatus {
  pending,
  inProgress,
  approved,
  rejected,
}
