import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_pack_mobile_app/core/constants/app_constants.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/presentation/widgets/buttons/primary_button.dart';
import 'package:i_pack_mobile_app/presentation/widgets/buttons/outline_button.dart';
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
      icon: Icons.security,
      title: 'Protect What Matters',
      description: 'Comprehensive insurance coverage for your devices, home, and everything you value.',
    ),
    OnboardingData(
      icon: Icons.flash_on,
      title: 'Instant Claims',
      description: 'File and track claims in minutes with our streamlined process.',
    ),
    OnboardingData(
      icon: Icons.analytics,
      title: 'Smart Analytics',
      description: 'Get insights into your protection score and optimize your coverage.',
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
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
        body: SafeArea(
        child: Column(
          children: [
            // Skip Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.mediumSpacing),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: _skip,
                  child: Text(
                    'Skip',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: AppColors.tealPrimary,
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
                  return Padding(
                    padding: const EdgeInsets.all(AppConstants.largeSpacing),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Icon
                        Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.tealPrimary.withValues(alpha: 0.1),
                                AppColors.tealLight.withValues(alpha: 0.1),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(48),
                          ),
                          child: Center(
                            child: Icon(
                              data.icon,
                              size: 100,
                              color: AppColors.tealPrimary,
                            ),
                          ),
                        ).animate().scale(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.elasticOut,
                        ),
                        const SizedBox(height: AppConstants.extraLargeSpacing),
                        
                        // Title
                        Text(
                          data.title,
                          style: theme.textTheme.headlineLarge?.copyWith(
                            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(
                          delay: const Duration(milliseconds: 200),
                        ).slideY(
                          begin: 0.3,
                          end: 0,
                          delay: const Duration(milliseconds: 200),
                        ),
                        const SizedBox(height: AppConstants.mediumSpacing),
                        
                        // Description
                        Text(
                          data.description,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          ),
                          textAlign: TextAlign.center,
                        ).animate().fadeIn(
                          delay: const Duration(milliseconds: 400),
                        ).slideY(
                          begin: 0.3,
                          end: 0,
                          delay: const Duration(milliseconds: 400),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            
            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColors.tealPrimary
                        : (isDark ? AppColors.darkSurfaceVariant : AppColors.lightSurfaceVariant),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppConstants.largeSpacing),
            
            // Buttons
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppConstants.mediumSpacing),
              child: Row(
                children: [
                  if (_currentPage > 0)
                    Expanded(
                      child: OutlineButton(
                        text: 'Back',
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                      ),
                    ),
                  if (_currentPage > 0) const SizedBox(width: AppConstants.mediumSpacing),
                  Expanded(
                    child: PrimaryButton(
                      text: _currentPage == _onboardingData.length - 1 ? 'Get Started' : 'Next',
                      onPressed: _nextPage,
                      isFullWidth: true,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppConstants.largeSpacing),
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

  OnboardingData({
    required this.icon,
    required this.title,
    required this.description,
  });
}
