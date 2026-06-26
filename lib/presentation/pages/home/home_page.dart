import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/constants/app_constants.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/core/utils/responsive_utils.dart';
import 'package:i_pack_mobile_app/presentation/widgets/navigation/bottom_navigation.dart';
import 'package:i_pack_mobile_app/presentation/pages/policies/policies_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/claims/claims_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/notifications/notifications_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/profile/profile_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/home/brand_details_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  int _protectionScore = 85;
  bool _isHovered = false;

  final List<Map<String, dynamic>> _brands = [
    {
      'name': 'Apple',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/f/fa/Apple_logo_black.svg',
      'color': AppColors.primary,
    },
    {
      'name': 'Samsung',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/2/24/Samsung_Logo.svg',
      'color': AppColors.secondary,
    },
    {
      'name': 'Google',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
      'color': AppColors.success,
    },
    {
      'name': 'OnePlus',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/8/82/OnePlus_logo.svg',
      'color': AppColors.accent,
    },
    {
      'name': 'Xiaomi',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/a/ae/Xiaomi_logo_%282021-%29.svg',
      'color': AppColors.warning,
    },
    {
      'name': 'OPPO',
      'image': 'https://upload.wikimedia.org/wikipedia/commons/5/5d/Oppo_logo.svg',
      'color': AppColors.error,
    },
  ];

  final List<Map<String, dynamic>> _policies = [
    {
      'name': 'Device Protection',
      'description': 'iPhone 15 Pro Max',
      'icon': Icons.phone_iphone_rounded,
      'color': AppColors.tealPrimary,
      'status': 'Active',
      'expiryDate': 'Dec 2025',
      'premium': '₹12.99/mo',
    },
    {
      'name': 'Home Insurance',
      'description': 'Premium Plan - 3BR House',
      'icon': Icons.home_rounded,
      'color': AppColors.secondary,
      'status': 'Active',
      'expiryDate': 'Jun 2025',
      'premium': '₹45.00/mo',
    },
    {
      'name': 'Auto Insurance',
      'description': 'Tesla Model 3',
      'icon': Icons.directions_car_rounded,
      'color': AppColors.accent,
      'status': 'Active',
      'expiryDate': 'Mar 2025',
      'premium': '₹89.99/mo',
    },
    {
      'name': 'Travel Insurance',
      'description': 'Annual Coverage',
      'icon': Icons.flight_rounded,
      'color': AppColors.warning,
      'status': 'Expiring',
      'expiryDate': 'Jan 2025',
      'premium': '₹24.99/mo',
    },
    {
      'name': 'Health Insurance',
      'description': 'Family Plan',
      'icon': Icons.health_and_safety_rounded,
      'color': AppColors.success,
      'status': 'Active',
      'expiryDate': 'Aug 2025',
      'premium': '₹150.00/mo',
    },
    {
      'name': 'Pet Insurance',
      'description': 'Golden Retriever',
      'icon': Icons.pets_rounded,
      'color': AppColors.danger,
      'status': 'Active',
      'expiryDate': 'Nov 2025',
      'premium': '₹35.00/mo',
    },
  ];

  final List<Map<String, dynamic>> _claims = [
    {
      'title': 'Screen Damage',
      'description': 'iPhone 15 Pro Max screen cracked',
      'date': 'Dec 15, 2024',
      'status': 'Approved',
      'amount': '₹299.00',
    },
    {
      'title': 'Water Damage',
      'description': 'MacBook Pro liquid spill',
      'date': 'Dec 10, 2024',
      'status': 'In Progress',
      'amount': '₹1,200.00',
    },
    {
      'title': 'Theft Claim',
      'description': 'AirPods Pro stolen',
      'date': 'Dec 5, 2024',
      'status': 'Pending',
      'amount': '₹249.00',
    },
    {
      'title': 'Car Accident',
      'description': 'Minor fender bender - Tesla Model 3',
      'date': 'Nov 28, 2024',
      'status': 'Approved',
      'amount': '₹850.00',
    },
    {
      'title': 'Medical Emergency',
      'description': 'Emergency room visit coverage',
      'date': 'Nov 15, 2024',
      'status': 'Approved',
      'amount': '₹2,500.00',
    },
  ];

  final List<Map<String, dynamic>> _recentActivities = [
    {
      'title': 'Payment Successful',
      'description': 'Monthly premium for Device Protection',
      'time': '2 hours ago',
      'icon': Icons.check_circle_rounded,
      'color': AppColors.success,
    },
    {
      'title': 'Policy Renewed',
      'description': 'Travel Insurance renewed for 2025',
      'time': '1 day ago',
      'icon': Icons.refresh_rounded,
      'color': AppColors.tealPrimary,
    },
    {
      'title': 'Claim Approved',
      'description': 'Screen damage claim approved',
      'time': '2 days ago',
      'icon': Icons.done_all_rounded,
      'color': AppColors.success,
    },
    {
      'title': 'New Document',
      'description': 'Policy document uploaded',
      'time': '3 days ago',
      'icon': Icons.description_rounded,
      'color': AppColors.secondary,
    },
  ];

  Widget _getActiveView() {
    switch (_currentIndex) {
      case 0:
        return _buildMobileHomeContent();
      case 1:
        // Returns the policies view embedded in the home wrapper
        return const PoliciesPage(isEmbedded: true);
      case 2:
        return const ClaimsPage(isEmbedded: true);
      case 3:
        return const ProfilePage(isEmbedded: true);
      case 4:
        return _buildBuyNewPlanView();
      default:
        return _buildMobileHomeContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;

    if (isDesktop) {
      return _buildDesktopLayout();
    }

    return _buildMobileLayout();
  }

  // --- MOBILE LAYOUT ---
  Widget _buildMobileLayout() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: _getActiveView(),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex > 4 ? 0 : _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildMobileHomeContent() {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return ListView(
      physics: const BouncingScrollPhysics(),
      padding: ResponsiveUtils.responsivePadding(context, all: 20),
      children: [
          SizedBox(height: ResponsiveUtils.getSpacingXS(context)),
          
          // Premium Greeting Section
          Row(
            children: [
              Container(
                width: ResponsiveUtils.responsiveWidth(context, width: 56),
                height: ResponsiveUtils.responsiveHeight(context, height: 56),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(ResponsiveUtils.responsiveBorderRadius(context, radius: 20)),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: ResponsiveUtils.responsiveIconSize(context, size: 28),
                  ),
                ),
              ),
              SizedBox(width: ResponsiveUtils.getSpacingM(context)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning',
                      style: TextStyle(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        fontSize: ResponsiveUtils.getBodyMedium(context),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: ResponsiveUtils.getSpacingXS(context)),
                    Text(
                      'Avinash Magar',
                      style: TextStyle(
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        fontSize: ResponsiveUtils.getHeading5(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Icon(
                        Icons.notifications_rounded,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        size: 24,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.error,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          
          // Premium Protection Score Card
          // Premium Protection Score Card (Redesigned)
          GestureDetector(
            onTap: () => _showProtectionScoreDetails(context, isDark),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primaryDark,
                    AppColors.primary,
                    AppColors.secondaryDark,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                  BoxShadow(
                    color: AppColors.secondary.withValues(alpha: 0.15),
                    blurRadius: 30,
                    offset: const Offset(0, -5),
                  ),
                ],
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.2),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Title & Badge
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                            width: 1,
                          ),
                        ),
                        child: const Icon(
                          Icons.verified_user_rounded,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Protection Score',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                            Text(
                              'Real-time security index',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.6),
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.successLight.withValues(alpha: 0.5),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.success.withValues(alpha: 0.2),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 14,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Excellent',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Gauge & Stats Grid
                  Row(
                    children: [
                      // Radial Gauge
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.08),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SizedBox(
                              width: 84,
                              height: 84,
                              child: CircularProgressIndicator(
                                value: _protectionScore / 100,
                                strokeWidth: 8,
                                backgroundColor: Colors.white.withValues(alpha: 0.15),
                                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                strokeCap: StrokeCap.round,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$_protectionScore',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                    height: 1.1,
                                  ),
                                ),
                                Text(
                                  'out of 100',
                                  style: TextStyle(
                                    color: Colors.white.withValues(alpha: 0.6),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      
                      // Stats List
                      Expanded(
                        child: Column(
                          children: [
                            _buildScoreStat(
                              label: 'Policies',
                              value: '4',
                              icon: Icons.shield_rounded,
                            ),
                            const SizedBox(height: 10),
                            _buildScoreStat(
                              label: 'Claims',
                              value: '2',
                              icon: Icons.assignment_turned_in_rounded,
                            ),
                            const SizedBox(height: 10),
                            _buildScoreStat(
                              label: 'Devices',
                              value: '3',
                              icon: Icons.devices_rounded,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Divider
                  Container(
                    height: 1,
                    color: Colors.white.withValues(alpha: 0.15),
                  ),
                  const SizedBox(height: 16),
                  
                  // Footer Action
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Colors.white.withValues(alpha: 0.7),
                              size: 16,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Your coverage is in excellent condition',
                                style: TextStyle(
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'View Details',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white24,
                            ),
                            child: const Icon(
                              Icons.arrow_forward_rounded,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 28),
          
          // Mobile Brands Section
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Brands',
                    style: TextStyle(
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    'View All',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _brands.length,
                  itemBuilder: (context, index) {
                    return _buildBrandCard(_brands[index], isDark);
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          
          // Quick Actions Section
          Text(
            'Quick Actions',
            style: TextStyle(
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildQuickAction(
                  context,
                  icon: Icons.add_circle_rounded,
                  label: 'New Claim',
                  color: AppColors.primary,
                  onTap: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickAction(
                  context,
                  icon: Icons.shield_rounded,
                  label: 'My Policies',
                  color: AppColors.secondary,
                  onTap: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildQuickAction(
                  context,
                  icon: Icons.shopping_bag_rounded,
                  label: 'Buy Plan',
                  color: AppColors.warning,
                  onTap: () {
                    setState(() {
                      _currentIndex = 5;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 28),
          
          // Active Policies
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Policies',
                style: TextStyle(
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._policies.take(2).map((policy) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
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
                  child: Row(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: (policy['color'] as Color).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          policy['icon'] as IconData,
                          color: policy['color'] as Color,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              policy['name'] as String,
                              style: TextStyle(
                                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              policy['description'] as String,
                              style: TextStyle(
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                fontSize: 13,
                              ),
                            ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        policy['status'] as String,
                        style: TextStyle(
                          color: AppColors.success,
                          fontWeight: FontWeight.w600,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
          }),
          const SizedBox(height: 28),
          
          // Recent Activities
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activities',
                style: TextStyle(
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                child: Text(
                  'View All',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ..._recentActivities.take(3).map((activity) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 3;
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: (activity['color'] as Color).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          activity['icon'] as IconData,
                          color: activity['color'] as Color,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity['title'] as String,
                              style: TextStyle(
                                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              activity['description'] as String,
                              style: TextStyle(
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        activity['time'] as String,
                        style: TextStyle(
                          color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 80),
      ]);
  }

  Widget _buildQuickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? AppColors.shadow.withValues(alpha: 0.2)
                : AppColors.shadow.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(AppConstants.mediumSpacing),
            child: Column(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 26,
                  ),
                ),
                const SizedBox(height: AppConstants.smallSpacing),
                Text(
                  label,
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBrandCard(Map<String, dynamic> brand, bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BrandDetailsPage(
                  brandName: brand['name'] as String,
                  brandColor: brand['color'] as Color,
                  brandImage: brand['image'] as String?,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            width: 90,
            decoration: BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.03),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: (brand['color'] as Color).withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: SvgPicture.network(
                      brand['image'] as String,
                      fit: BoxFit.contain,
                      colorFilter: brand['name'] == 'Apple'
                          ? ColorFilter.mode(isDark ? Colors.white : Colors.black87, BlendMode.srcIn)
                          : null,
                      placeholderBuilder: (context) => const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  brand['name'] as String,
                  style: TextStyle(
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget _buildScoreStat({
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- DESKTOP LAYOUT ---
  Widget _buildDesktopLayout() {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Slate 100 for web background
      body: Row(
        children: [
          // Sidebar
          _buildSidebar(),
          
          // Main Body
          Expanded(
            child: Column(
              children: [
                // Header
                _buildHeader(),
                
                // Content View
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(32.0),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 1200),
                      child: _getDesktopContentView(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar() {
    return Container(
      width: 280,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Logo Block
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF97316), // Orange primary
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.shield,
                      color: Colors.white,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  'I-PACK',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E293B),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          
          // Sidebar Nav Items
          Expanded(
            child: ListView(
              children: [
                _buildSidebarItem(
                  label: 'Dashboard Overview',
                  icon: Icons.grid_view_rounded,
                  index: 0,
                ),
                _buildSidebarItem(
                  label: 'My Policies',
                  icon: Icons.shield_outlined,
                  index: 1,
                ),
                _buildSidebarItem(
                  label: 'My Claims',
                  icon: Icons.description_outlined,
                  index: 2,
                ),
                _buildSidebarItem(
                  label: 'Buy New Plan',
                  icon: Icons.shopping_cart_outlined,
                  index: 5,
                ),
              ],
            ),
          ),
          
          // User profile at bottom left
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFF1E3A8A), // Dark blue
                  child: Text(
                    'A',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Avinash Magar',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E293B),
                        ),
                      ),
                      Text(
                        'avinashmagar@gmail.com',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF64748B),
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSidebarItem({
    required String label,
    required IconData icon,
    required int index,
  }) {
    final isSelected = _currentIndex == index || (_currentIndex == 3 && index == 0) || (_currentIndex == 4 && index == 0);
    // highlight dashboard if we are on alerts/profile views
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              _currentIndex = index;
            });
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
            decoration: BoxDecoration(
              color: isSelected ? const Color(0xFFF97316) : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected ? Colors.white : const Color(0xFF64748B),
                  size: 22,
                ),
                const SizedBox(width: 16),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : const Color(0xFF475569),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 80,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        children: [
          // Navigation Links
          _buildHeaderLink('Home', 0),
          const SizedBox(width: 24),
          _buildHeaderLink('Plans', 5),
          const SizedBox(width: 24),
          _buildHeaderLink('Accessories', 5),
          const SizedBox(width: 24),
          _buildHeaderLink('How to Claim', 2),
          const SizedBox(width: 24),
          _buildHeaderLink('About Us', 4),
          const SizedBox(width: 24),
          _buildHeaderLink('Support', 4),
          
          const Spacer(),
          
          // Alerts Button
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: Color(0xFF475569)),
            onPressed: () {
              setState(() {
                _currentIndex = 3; // Alerts
              });
            },
          ),
          const SizedBox(width: 16),
          
          // Profile Widget
          MouseRegion(
            onEnter: (_) => setState(() => _isHovered = true),
            onExit: (_) => setState(() => _isHovered = false),
            child: InkWell(
              onTap: () {
                setState(() {
                  _currentIndex = 4; // Profile
                });
              },
              borderRadius: BorderRadius.circular(20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                decoration: BoxDecoration(
                  color: _isHovered ? const Color(0xFFF1F5F9) : const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: _isHovered ? AppColors.primary : const Color(0xFFE2E8F0)),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 14,
                      backgroundColor: Color(0xFF1E3A8A),
                      child: Text(
                        'A',
                        style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      'Avinash Magar',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          
          // Logout Button
          TextButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/login');
            },
            icon: const Icon(Icons.logout, size: 18, color: Color(0xFF64748B)),
            label: const Text(
              'Logout',
              style: TextStyle(color: Color(0xFF64748B), fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderLink(String label, int index) {
    final isSelected = _currentIndex == index;
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
      },
      child: Text(
        label,
        style: TextStyle(
          fontSize: 15,
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          color: isSelected ? const Color(0xFFF97316) : const Color(0xFF64748B),
        ),
      ),
    );
  }

  // --- CONTENT ROUTING ---
  Widget _getDesktopContentView() {
    switch (_currentIndex) {
      case 0:
        return _buildDesktopDashboard();
      case 1:
        return const PoliciesPage(isEmbedded: true);
      case 2:
        return const ClaimsPage(isEmbedded: true);
      case 3:
        return const NotificationsPage(isEmbedded: true);
      case 4:
        return const ProfilePage(isEmbedded: true);
      case 5:
        return _buildBuyNewPlanView();
      default:
        return _buildDesktopDashboard();
    }
  }

  // --- DESKTOP VIEWS ---
  Widget _buildDesktopDashboard() {
    final activePoliciesCount = _policies.length;
    final activeCount = _policies.where((p) => p['status'] == 'Active').length;
    final claimsCount = _claims.length;
    final pendingClaimsCount = _claims.where((c) => c['status'] == 'Pending').length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Dashboard',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 6),
        const Text(
          'Manage your protection plans and claims',
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF64748B),
          ),
        ),
        const SizedBox(height: 32),
        
        // Grid of 4 Stats Cards
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                title: 'Total Policies',
                value: '$activePoliciesCount',
                icon: Icons.shield_outlined,
                iconColor: const Color(0xFF2563EB),
                bgColor: const Color(0xFFEFF6FF),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildStatCard(
                title: 'Active Policies',
                value: '$activeCount',
                icon: Icons.check_circle_outline,
                iconColor: const Color(0xFF16A34A),
                bgColor: const Color(0xFFF0FDF4),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildStatCard(
                title: 'Total Claims',
                value: '$claimsCount',
                icon: Icons.description_outlined,
                iconColor: const Color(0xFFD97706),
                bgColor: const Color(0xFFFEF3C7),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: _buildStatCard(
                title: 'Pending Claims',
                value: '$pendingClaimsCount',
                icon: Icons.pending_actions_outlined,
                iconColor: const Color(0xFF0891B2),
                bgColor: const Color(0xFFECFEFF),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        
        // Main Panels (Active Policies & Recent Claims)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Active Policies Card
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Active Policies',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        TextButton(
                          onPressed: () => setState(() => _currentIndex = 1),
                          child: const Text(
                            'View All',
                            style: TextStyle(color: Color(0xFFF97316), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_policies.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Center(
                          child: Text(
                            'No active policies found.',
                            style: TextStyle(color: Color(0xFF64748B)),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _policies.length > 3 ? 3 : _policies.length,
                        itemBuilder: (context, idx) {
                          final p = _policies[idx];
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Row(
                              children: [
                                Icon(p['icon'] as IconData, color: p['color'] as Color, size: 24),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        p['name'] as String,
                                        style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                                      ),
                                      Text(
                                        p['description'] as String,
                                        style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDCFCE7),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Active',
                                    style: TextStyle(color: Color(0xFF16A34A), fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 24),
            
            // Recent Claims Card
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.02),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Recent Claims',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        TextButton(
                          onPressed: () => setState(() => _currentIndex = 2),
                          child: const Text(
                            'View All',
                            style: TextStyle(color: Color(0xFFF97316), fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (_claims.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 40.0),
                        child: Center(
                          child: Text(
                            'No claims raised yet.',
                            style: TextStyle(color: Color(0xFF64748B)),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _claims.length > 3 ? 3 : _claims.length,
                        itemBuilder: (context, idx) {
                          final c = _claims[idx];
                          final isApproved = c['status'] == 'Approved';
                          final isPending = c['status'] == 'Pending';
                          Color statusColor = const Color(0xFF0891B2);
                          Color statusBg = const Color(0xFFECFEFF);
                          if (isApproved) {
                            statusColor = const Color(0xFF16A34A);
                            statusBg = const Color(0xFFDCFCE7);
                          } else if (isPending) {
                            statusColor = const Color(0xFFD97706);
                            statusBg = const Color(0xFFFEF3C7);
                          }

                          return Container(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF8FAFC),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: const Color(0xFFE2E8F0)),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.receipt_long_outlined, color: Color(0xFFF97316), size: 24),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        c['title'] as String,
                                        style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF1E293B)),
                                      ),
                                      Text(
                                        c['description'] as String,
                                        style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: statusBg,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    c['status'] as String,
                                    style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        
        // Damaged Device Banner Card
        Container(
          padding: const EdgeInsets.all(28.0),
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A), // Dark slate background
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFEA580C).withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.report_problem_outlined,
                  color: Color(0xFFEA580C),
                  size: 28,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Need help with a damaged device?',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Our claim process is simple and hassle-free. Raise a claim in minutes.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF94A3B8),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 24),
              ElevatedButton(
                onPressed: () => setState(() => _currentIndex = 2),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFF97316),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text('Start Claim Process', style: TextStyle(color: Colors.white, fontSize: 15)),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.015),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 28,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF64748B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- BUY NEW PLAN VIEW ---
  Widget _buildBuyNewPlanView() {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width >= 900;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0.0 : 20.0, vertical: isDesktop ? 0.0 : 28.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Text(
            'Buy New Plan',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Choose the perfect protection plan for your device',
            style: TextStyle(
              fontSize: 15,
              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
            ),
          ),
          const SizedBox(height: 32),
          
          isDesktop
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: _buildPlanCard(
                      title: 'BASIC',
                      subtitle: 'Coverage up to ₹20,000',
                      price: '₹699',
                      features: [
                        'Accidental Damage Cover',
                        'Screen Protection',
                        'Liquid Damage Cover',
                        'Extended Warranty',
                      ],
                      borderColor: const Color(0xFF22C55E),
                      buttonColor: const Color(0xFF22C55E),
                      isPopular: false,
                    )),
                    const SizedBox(width: 24),
                    Expanded(child: _buildPlanCard(
                      title: 'PREMIUM',
                      subtitle: 'Coverage up to ₹20,000',
                      price: '₹1,299',
                      features: [
                        'Everything in Basic Plan',
                        'Theft Protection',
                        'Accessories Coverage',
                        'Priority Claim Support',
                      ],
                      borderColor: const Color(0xFF1E3A8A),
                      buttonColor: const Color(0xFF1E3A8A),
                      isPopular: true,
                    )),
                    const SizedBox(width: 24),
                    Expanded(child: _buildPlanCard(
                      title: 'ULTIMATE',
                      subtitle: 'Coverage up to ₹1,00,000',
                      price: '₹1,999',
                      features: [
                        'Everything in Premium Plan',
                        'Worldwide Coverage',
                        'No Service Center Hassle',
                        'Express Claim Settlement',
                      ],
                      borderColor: const Color(0xFFF97316),
                      buttonColor: const Color(0xFFF97316),
                      isPopular: false,
                    )),
                  ],
                )
              : Column(
                  children: [
                    _buildPlanCard(
                      title: 'BASIC',
                      subtitle: 'Coverage up to ₹20,000',
                      price: '₹699',
                      features: [
                        'Accidental Damage Cover',
                        'Screen Protection',
                        'Liquid Damage Cover',
                        'Extended Warranty',
                      ],
                      borderColor: const Color(0xFF22C55E),
                      buttonColor: const Color(0xFF22C55E),
                      isPopular: false,
                    ),
                    const SizedBox(height: 24),
                    _buildPlanCard(
                      title: 'PREMIUM',
                      subtitle: 'Coverage up to ₹20,000',
                      price: '₹1,299',
                      features: [
                        'Everything in Basic Plan',
                        'Theft Protection',
                        'Accessories Coverage',
                        'Priority Claim Support',
                      ],
                      borderColor: const Color(0xFF1E3A8A),
                      buttonColor: const Color(0xFF1E3A8A),
                      isPopular: true,
                    ),
                    const SizedBox(height: 24),
                    _buildPlanCard(
                      title: 'ULTIMATE',
                      subtitle: 'Coverage up to ₹1,00,000',
                      price: '₹1,999',
                      features: [
                        'Everything in Premium Plan',
                        'Worldwide Coverage',
                        'No Service Center Hassle',
                        'Express Claim Settlement',
                      ],
                      borderColor: const Color(0xFFF97316),
                      buttonColor: const Color(0xFFF97316),
                      isPopular: false,
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
        ],
      ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String title,
    required String subtitle,
    required String price,
    required List<String> features,
    required Color borderColor,
    required Color buttonColor,
    required bool isPopular,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: borderColor.withValues(alpha: 0.15),
            blurRadius: 24,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Popular Ribbon Tag
          if (isPopular)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.star, color: Colors.white, size: 16),
                  SizedBox(width: 6),
                  Text(
                    'MOST POPULAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          
          Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: buttonColor,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '/year',
                      style: TextStyle(
                        fontSize: 16,
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                
                // Divider
                Container(height: 1, color: isDark ? AppColors.darkDivider : AppColors.lightDivider),
                const SizedBox(height: 24),
                
                // Features List
                ...features.map((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: buttonColor,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: TextStyle(
                              fontSize: 15,
                              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 32),
                
                // Button
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected $title Protection Plan!'),
                          backgroundColor: buttonColor,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Buy This Plan',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showProtectionScoreDetails(BuildContext context, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            final double progressValue = _protectionScore / 100;
            String scoreRating;
            Color scoreColor;
            if (_protectionScore >= 90) {
              scoreRating = 'Excellent';
              scoreColor = AppColors.success;
            } else if (_protectionScore >= 75) {
              scoreRating = 'Very Good';
              scoreColor = AppColors.primary;
            } else {
              scoreRating = 'Fair';
              scoreColor = AppColors.warning;
            }

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
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: scoreColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Icon(
                          Icons.verified_user_rounded,
                          color: scoreColor,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Protection Score Analysis',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Real-time security breakdown',
                              style: TextStyle(
                                fontSize: 13,
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Score Indicator Box
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
                    child: Row(
                      children: [
                        SizedBox(
                          width: 70,
                          height: 70,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              CircularProgressIndicator(
                                value: progressValue,
                                strokeWidth: 7,
                                backgroundColor: isDark ? Colors.white10 : Colors.black12,
                                valueColor: AlwaysStoppedAnimation<Color>(scoreColor),
                                strokeCap: StrokeCap.round,
                              ),
                              Text(
                                '$_protectionScore',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    scoreRating,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: scoreColor,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: scoreColor.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      'Active',
                                      style: TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                        color: scoreColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 6),
                              Text(
                                'Your coverage is highly secure. Complete the recommended actions below to achieve a 100/100 perfect rating.',
                                style: TextStyle(
                                  fontSize: 12,
                                  height: 1.4,
                                  color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Breakdown Title
                  Text(
                    'Score Breakdown',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Breakdown Items
                  _buildBreakdownRow(
                    icon: Icons.shield_outlined,
                    title: 'Active Policies',
                    subtitle: 'All active coverage is in good standing',
                    pts: '+35 pts',
                    color: AppColors.success,
                    isDark: isDark,
                  ),
                  _buildBreakdownRow(
                    icon: Icons.phonelink_lock_outlined,
                    title: 'Device Verification',
                    subtitle: '3/4 personal devices fully registered',
                    pts: _protectionScore >= 95 ? '+35 pts' : '+25 pts',
                    color: _protectionScore >= 95 ? AppColors.success : AppColors.primary,
                    isDark: isDark,
                  ),
                  _buildBreakdownRow(
                    icon: Icons.fingerprint_outlined,
                    title: 'KYC & Verification',
                    subtitle: 'Identity verification is 100% complete',
                    pts: '+15 pts',
                    color: AppColors.success,
                    isDark: isDark,
                  ),
                  _buildBreakdownRow(
                    icon: Icons.assignment_outlined,
                    title: 'Claims Health',
                    subtitle: 'Good standing with zero active disputes',
                    pts: '+10 pts',
                    color: AppColors.success,
                    isDark: isDark,
                  ),

                  const SizedBox(height: 24),

                  // Recommendations Section
                  if (_protectionScore < 95) ...[
                    Text(
                      'Recommended Actions',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    
                    // Action Card
                    InkWell(
                      onTap: () {
                        // Action
                        setModalState(() {
                          _protectionScore = 95;
                        });
                        setState(() {
                          _protectionScore = 95;
                        });
                        Navigator.pop(context);
                        
                        // Show Success Dialog
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            backgroundColor: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            title: Row(
                              children: [
                                const Icon(Icons.check_circle, color: AppColors.success, size: 28),
                                const SizedBox(width: 12),
                                Text(
                                  'Device Protected!',
                                  style: TextStyle(
                                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                  ),
                                ),
                              ],
                            ),
                            content: Text(
                              'iPad Pro has been successfully registered and fully covered under Device Protection plan. Your Protection Score is now updated to 95!',
                              style: TextStyle(
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text(
                                  'Awesome',
                                  style: TextStyle(
                                    color: isDark ? AppColors.primary : AppColors.primaryDark,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: 0.25),
                            width: 1.5,
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: AppColors.primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.tablet_mac_rounded,
                                color: AppColors.primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Protect Uninsured iPad Pro',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Increase your score by +10 points',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 16,
                              color: AppColors.primary,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Close button
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isDark ? AppColors.darkSurfaceVariant : Colors.grey[200],
                        foregroundColor: isDark ? Colors.white : Colors.black87,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBreakdownRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required String pts,
    required Color color,
    required bool isDark,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 11,
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            pts,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
