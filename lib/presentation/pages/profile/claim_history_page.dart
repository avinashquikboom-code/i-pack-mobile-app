import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';

class ClaimHistoryPage extends StatefulWidget {
  const ClaimHistoryPage({super.key});

  @override
  State<ClaimHistoryPage> createState() => _ClaimHistoryPageState();
}

class _ClaimHistoryPageState extends State<ClaimHistoryPage> {
  final List<ClaimHistoryItem> _claims = [
    ClaimHistoryItem(
      id: '1',
      title: 'Screen Damage',
      policyNumber: 'POL-001',
      amount: '₹250.00',
      date: 'Dec 15, 2024',
      status: 'Approved',
      statusColor: AppColors.success,
    ),
    ClaimHistoryItem(
      id: '2',
      title: 'Water Damage',
      policyNumber: 'POL-002',
      amount: '₹500.00',
      date: 'Nov 28, 2024',
      status: 'In Progress',
      statusColor: AppColors.warning,
    ),
    ClaimHistoryItem(
      id: '3',
      title: 'Theft',
      policyNumber: 'POL-001',
      amount: '₹1,200.00',
      date: 'Oct 10, 2024',
      status: 'Rejected',
      statusColor: AppColors.error,
    ),
    ClaimHistoryItem(
      id: '4',
      title: 'Accidental Damage',
      policyNumber: 'POL-003',
      amount: '₹150.00',
      date: 'Sep 5, 2024',
      status: 'Approved',
      statusColor: AppColors.success,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: const Text('Claim History'),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Theme.of(context).platform == TargetPlatform.iOS
                ? Icons.arrow_back_ios_new
                : Icons.arrow_back,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: _claims.map((claim) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: _buildClaimCard(claim, isDark),
            );
          }).toList(),
        ),
      ),
      ),
    );
  }

  Widget _buildClaimCard(ClaimHistoryItem claim, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                claim.title,
                style: TextStyle(
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: claim.statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  claim.status,
                  style: TextStyle(
                    color: claim.statusColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(
                Icons.description_outlined,
                size: 16,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                'Policy: ${claim.policyNumber}',
                style: TextStyle(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                size: 16,
                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                claim.date,
                style: TextStyle(
                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Claim Amount',
                style: TextStyle(
                  color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                  fontSize: 13,
                ),
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
        ],
      ),
    );
  }
}

class ClaimHistoryItem {
  final String id;
  final String title;
  final String policyNumber;
  final String amount;
  final String date;
  final String status;
  final Color statusColor;

  ClaimHistoryItem({
    required this.id,
    required this.title,
    required this.policyNumber,
    required this.amount,
    required this.date,
    required this.status,
    required this.statusColor,
  });
}
