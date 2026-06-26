import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/presentation/widgets/buttons/primary_button.dart';
import 'package:i_pack_mobile_app/presentation/widgets/navigation/app_bar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _isLoading = false;
  bool _agreeToTerms = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (!_agreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please agree to the terms and conditions')),
        );
        return;
      }
      
      setState(() {
        _isLoading = true;
      });
      
      // Simulate registration
      await Future.delayed(const Duration(seconds: 2));
      
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: const AppAppBar(
        title: 'Create Account',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screenWidth * 0.05),
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: screenHeight * 0.02),
                  
                  // Logo
                  Center(
                    child: Container(
                      width: screenWidth * 0.2,
                      height: screenWidth * 0.2,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.tealPrimary,
                            AppColors.tealLight,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Center(
                        child: Text(
                          'iP',
                          style: TextStyle(
                            fontSize: screenWidth * 0.08,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ).animate().scale(
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.elasticOut,
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03),
                
                // Welcome Text
                Text(
                  'Create your account',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                    fontWeight: FontWeight.w600,
                    fontSize: screenWidth * 0.05,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 200),
                ).slideY(
                  begin: 0.3,
                  end: 0,
                  delay: const Duration(milliseconds: 200),
                ),
                SizedBox(height: screenHeight * 0.01),
                
                Text(
                  'Sign up to get started with i-Pack',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    fontSize: screenWidth * 0.04,
                  ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 300),
                ),
                SizedBox(height: screenHeight * 0.05),
                
                // Name Field
                TextFormField(
                  controller: _nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: 'Full name',
                    prefixIcon: const Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 400),
                ).slideX(
                  begin: -0.2,
                  end: 0,
                  delay: const Duration(milliseconds: 400),
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Email Field
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Email address',
                    prefixIcon: const Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 500),
                ).slideX(
                  begin: -0.2,
                  end: 0,
                  delay: const Duration(milliseconds: 500),
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Password Field
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 600),
                ).slideX(
                  begin: -0.2,
                  end: 0,
                  delay: const Duration(milliseconds: 600),
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Confirm Password Field
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 700),
                ).slideX(
                  begin: -0.2,
                  end: 0,
                  delay: const Duration(milliseconds: 700),
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Terms Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _agreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          _agreeToTerms = value ?? false;
                        });
                      },
                      activeColor: AppColors.tealPrimary,
                    ),
                    Expanded(
                      child: Text(
                        'I agree to the Terms of Service and Privacy Policy',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                          fontSize: screenWidth * 0.035,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 800),
                ),
                SizedBox(height: screenHeight * 0.03),
                
                // Register Button
                PrimaryButton(
                  text: 'Create Account',
                  onPressed: _handleRegister,
                  isLoading: _isLoading,
                  isFullWidth: true,
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 900),
                ).scale(
                  begin: const Offset(0.95, 0.95),
                  end: const Offset(1, 1),
                  delay: const Duration(milliseconds: 900),
                ),
                SizedBox(height: screenHeight * 0.02),
                
                // Login Link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/login');
                      },
                      child: Text(
                        'Sign In',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: AppColors.tealPrimary,
                          fontSize: screenWidth * 0.04,
                        ),
                      ),
                    ),
                  ],
                ).animate().fadeIn(
                  delay: const Duration(milliseconds: 1000),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
