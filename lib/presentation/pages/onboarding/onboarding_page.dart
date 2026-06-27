import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/core/utils/responsive_utils.dart';
import 'package:flutter_animate/flutter_animate.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      icon: Icons.security_rounded,
      title: 'Protect What Matters',
      description: 'Comprehensive insurance coverage for your devices, home, and everything you value.',
      color: AppColors.primary,
    ),
    OnboardingData(
      icon: Icons.flash_on_rounded,
      title: 'Instant Claims',
      description: 'File and track claims in minutes with our streamlined process.',
      color: AppColors.secondary,
    ),
    OnboardingData(
      icon: Icons.analytics_rounded,
      title: 'Smart Analytics',
      description: 'Get insights into your protection score and optimize your coverage.',
      color: AppColors.accent,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.of(context).pushReplacementNamed('/login');
    }
  }

  void _skip() {
    Navigator.of(context).pushReplacementNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      body: SafeArea(
        child: Column(
          children: [
                // Skip Button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _skip,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                
                // Page View
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemCount: _onboardingData.length,
                    itemBuilder: (context, index) {
                      final data = _onboardingData[index];
                      return SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Animated Icon Container
                            Container(
                              width: ResponsiveUtils.responsiveWidth(context, width: 180),
                              height: ResponsiveUtils.responsiveHeight(context, height: 180),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    data.color,
                                    data.color.withValues(alpha: 0.6),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: data.color.withValues(alpha: 0.4),
                                    blurRadius: 30,
                                    offset: const Offset(0, 15),
                                  ),
                                ],
                              ),
                              child: Center(
                                child: Icon(
                                  data.icon,
                                  size: ResponsiveUtils.responsiveFontSize(context, fontSize: 80),
                                  color: Colors.white,
                                ),
                              ).animate()
                                  .scale(
                                    duration: const Duration(milliseconds: 800),
                                    curve: Curves.elasticOut,
                                  )
                                  .then()
                                  .shimmer(
                                    duration: const Duration(milliseconds: 1500),
                                    color: Colors.white.withValues(alpha: 0.5),
                                  ),
                            ),
                            const SizedBox(height: 40),
                            
                            // Title
                            Text(
                              data.title,
                              style: TextStyle(
                                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                fontWeight: FontWeight.bold,
                                fontSize: ResponsiveUtils.responsiveFontSize(context, fontSize: 28),
                              ),
                              textAlign: TextAlign.center,
                            ).animate()
                                .fadeIn(
                                  delay: const Duration(milliseconds: 300),
                                  duration: const Duration(milliseconds: 600),
                                )
                                .slideY(
                                  begin: 0.3,
                                  end: 0,
                                  delay: const Duration(milliseconds: 300),
                                  duration: const Duration(milliseconds: 600),
                                ),
                            const SizedBox(height: 16),
                            
                            // Description
                            Text(
                              data.description,
                              style: TextStyle(
                                color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                                fontSize: ResponsiveUtils.responsiveFontSize(context, fontSize: 16),
                                height: 1.6,
                              ),
                              textAlign: TextAlign.center,
                            ).animate()
                                .fadeIn(
                                  delay: const Duration(milliseconds: 500),
                                  duration: const Duration(milliseconds: 600),
                                )
                                .slideY(
                                  begin: 0.3,
                                  end: 0,
                                  delay: const Duration(milliseconds: 500),
                                  duration: const Duration(milliseconds: 600),
                                ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                
                // Page Indicator with Animation
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _onboardingData.length,
                    (index) => AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 6),
                      width: _currentPage == index ? 32 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        gradient: _currentPage == index
                            ? LinearGradient(
                                colors: [AppColors.primary, AppColors.primaryLight],
                              )
                            : null,
                        color: _currentPage == index
                            ? null
                            : (isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: _currentPage == index
                            ? [
                                BoxShadow(
                                  color: AppColors.primary.withValues(alpha: 0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : null,
                      ),
                    ).animate().scale(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                
                // Buttons with Enhanced Styling
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: Row(
                    children: [
                      if (_currentPage > 0)
                        Expanded(
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                                width: 2,
                              ),
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  _pageController.previousPage(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Center(
                                  child: Text(
                                    'Back',
                                    style: TextStyle(
                                      color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ).animate().fadeIn(
                            duration: const Duration(milliseconds: 300),
                          ),
                        ),
                      if (_currentPage > 0) const SizedBox(width: 16),
                      Expanded(
                        child: Container(
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: AppColors.primaryGradient,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.4),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: _nextPage,
                              borderRadius: BorderRadius.circular(20),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _currentPage == _onboardingData.length - 1 ? 'Get Started' : 'Next',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (_currentPage < _onboardingData.length - 1)
                                      const SizedBox(width: 8),
                                    if (_currentPage < _onboardingData.length - 1)
                                      const Icon(
                                        Icons.arrow_forward_rounded,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ).animate().fadeIn(
                          duration: const Duration(milliseconds: 300),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
          ],
        ),
      ),
      ),
    );
  }
}

class OnboardingData {
  final IconData icon;
  final String title;
  final String description;
  final Color color;

  OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
  });
}
