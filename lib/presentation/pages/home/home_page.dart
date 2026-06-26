import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/constants/app_constants.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/presentation/widgets/cards/premium_card.dart';
import 'package:i_pack_mobile_app/presentation/widgets/navigation/bottom_navigation.dart';
import 'package:i_pack_mobile_app/presentation/pages/policies/policies_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/claims/claims_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/notifications/notifications_page.dart';
import 'package:i_pack_mobile_app/presentation/pages/profile/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool _isHovered = false;

  final List<Map<String, dynamic>> _policies = [
    {
      'name': 'Device Protection',
      'description': 'iPhone 15 Pro Max',
      'icon': Icons.phone_iphone_rounded,
      'color': AppColors.tealPrimary,
      'status': 'Active',
      'expiryDate': 'Dec 2025',
      'premium': '\$12.99/mo',
    },
    {
      'name': 'Home Insurance',
      'description': 'Premium Plan - 3BR House',
      'icon': Icons.home_rounded,
      'color': AppColors.secondary,
      'status': 'Active',
      'expiryDate': 'Jun 2025',
      'premium': '\$45.00/mo',
    },
    {
      'name': 'Auto Insurance',
      'description': 'Tesla Model 3',
      'icon': Icons.directions_car_rounded,
      'color': AppColors.accent,
      'status': 'Active',
      'expiryDate': 'Mar 2025',
      'premium': '\$89.99/mo',
    },
    {
      'name': 'Travel Insurance',
      'description': 'Annual Coverage',
      'icon': Icons.flight_rounded,
      'color': AppColors.warning,
      'status': 'Expiring',
      'expiryDate': 'Jan 2025',
      'premium': '\$24.99/mo',
    },
    {
      'name': 'Health Insurance',
      'description': 'Family Plan',
      'icon': Icons.health_and_safety_rounded,
      'color': AppColors.success,
      'status': 'Active',
      'expiryDate': 'Aug 2025',
      'premium': '\$150.00/mo',
    },
    {
      'name': 'Pet Insurance',
      'description': 'Golden Retriever',
      'icon': Icons.pets_rounded,
      'color': AppColors.danger,
      'status': 'Active',
      'expiryDate': 'Nov 2025',
      'premium': '\$35.00/mo',
    },
  ];

  final List<Map<String, dynamic>> _claims = [
    {
      'title': 'Screen Damage',
      'description': 'iPhone 15 Pro Max screen cracked',
      'date': 'Dec 15, 2024',
      'status': 'Approved',
      'amount': '\$299.00',
    },
    {
      'title': 'Water Damage',
      'description': 'MacBook Pro liquid spill',
      'date': 'Dec 10, 2024',
      'status': 'In Progress',
      'amount': '\$1,200.00',
    },
    {
      'title': 'Theft Claim',
      'description': 'AirPods Pro stolen',
      'date': 'Dec 5, 2024',
      'status': 'Pending',
      'amount': '\$249.00',
    },
    {
      'title': 'Car Accident',
      'description': 'Minor fender bender - Tesla Model 3',
      'date': 'Nov 28, 2024',
      'status': 'Approved',
      'amount': '\$850.00',
    },
    {
      'title': 'Medical Emergency',
      'description': 'Emergency room visit coverage',
      'date': 'Nov 15, 2024',
      'status': 'Approved',
      'amount': '\$2,500.00',
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
        return const NotificationsPage(isEmbedded: true);
      case 4:
        return const ProfilePage(isEmbedded: true);
      case 5:
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
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: _getActiveView(),
        ),
      ),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentIndex > 4 ? 0 : _currentIndex, // default to 0 if subpage selected
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

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.mediumSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppConstants.smallSpacing),
          
          // Greeting Section with modern avatar
          Row(
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      AppColors.tealPrimary,
                      AppColors.tealLight,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Center(
                  child: Icon(
                    Icons.person_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
              const SizedBox(width: AppConstants.mediumSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good Morning',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'Avinash Magar',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
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
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Stack(
                    children: [
                      Icon(
                        Icons.notifications_rounded,
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        size: 22,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.danger,
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
          const SizedBox(height: AppConstants.largeSpacing),
          
          // Protection Score Card with modern design
          GestureDetector(
            onTap: () {
              setState(() {
                _currentIndex = 1; // Navigate to policies
              });
            },
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isDark
                      ? [AppColors.tealPrimary.withValues(alpha: 0.2), AppColors.tealPrimary.withValues(alpha: 0.1)]
                      : [AppColors.tealPrimary.withValues(alpha: 0.15), AppColors.tealLight.withValues(alpha: 0.1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.tealPrimary.withValues(alpha: 0.2),
                  width: 1,
                ),
              ),
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Protection Score',
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        'Excellent',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: AppColors.success,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.mediumSpacing),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: LinearProgressIndicator(
                          value: 0.85,
                          backgroundColor: isDark 
                              ? AppColors.darkSurfaceVariant 
                              : AppColors.lightSurfaceVariant,
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.success),
                          minHeight: 10,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppConstants.mediumSpacing),
                    Text(
                      '85%',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        color: AppColors.success,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppConstants.smallSpacing),
                Text(
                  'Your coverage is in excellent condition',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'View Details',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: AppColors.tealPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: AppColors.tealPrimary,
                    ),
                  ],
                ),
              ],
            ),
            ),
          ),
          const SizedBox(height: AppConstants.largeSpacing),
          
          // Quick Actions
          Text(
            'Quick Actions',
            style: theme.textTheme.titleLarge?.copyWith(
              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppConstants.mediumSpacing),
          Row(
            children: [
              Expanded(
                child: _buildQuickAction(
                  context,
                  icon: Icons.add_circle_rounded,
                  label: 'New Claim',
                  color: AppColors.tealPrimary,
                  onTap: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  },
                ),
              ),
              const SizedBox(width: AppConstants.mediumSpacing),
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
              const SizedBox(width: AppConstants.mediumSpacing),
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
          const SizedBox(height: AppConstants.largeSpacing),
          
          // Active Policies
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Active Policies',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
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
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.tealPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.mediumSpacing),
          ..._policies.take(2).map((policy) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.mediumSpacing),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 1; // Navigate to policies
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                  child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        color: (policy['color'] as Color).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        policy['icon'] as IconData,
                        color: policy['color'] as Color,
                        size: 26,
                      ),
                    ),
                    const SizedBox(width: AppConstants.mediumSpacing),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            policy['name'] as String,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            policy['description'] as String,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.success.withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppColors.success.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        policy['status'] as String,
                        style: theme.textTheme.labelSmall?.copyWith(
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
          const SizedBox(height: AppConstants.largeSpacing),
          
          // Recent Activities
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Activities',
                style: theme.textTheme.titleLarge?.copyWith(
                  color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                  fontWeight: FontWeight.w700,
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 3; // Notifications
                  });
                },
                child: Text(
                  'View All',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.tealPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.mediumSpacing),
          ..._recentActivities.take(3).map((activity) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppConstants.smallSpacing),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _currentIndex = 3; // Notifications
                  });
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: (activity['color'] as Color).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          activity['icon'] as IconData,
                          color: activity['color'] as Color,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppConstants.mediumSpacing),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              activity['title'] as String,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              activity['description'] as String,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        activity['time'] as String,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: isDark ? AppColors.darkTextTertiary : AppColors.lightTextTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 80),
        ],
      ),
    );
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
                  color: const Color(0xFFF8FAFC),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
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

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 0.0 : 16.0, vertical: isDesktop ? 0.0 : 24.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          const Text(
            'Buy New Plan',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Apne device ke liye best protection plan chunein',
            style: TextStyle(
              fontSize: 15,
              color: Color(0xFF64748B),
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
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 12,
            offset: const Offset(0, 6),
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
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              decoration: BoxDecoration(
                color: borderColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.star, color: Colors.white, size: 14),
                  SizedBox(width: 6),
                  Text(
                    'MOST POPULAR',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
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
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: buttonColor,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 13,
                    color: Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Text(
                      price,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      '/year',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                
                // Divider
                Container(height: 1, color: const Color(0xFFF1F5F9)),
                const SizedBox(height: 24),
                
                // Features List
                ...features.map((feature) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check,
                          color: buttonColor,
                          size: 18,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF475569),
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
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          'Buy This Plan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                      ],
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
}
