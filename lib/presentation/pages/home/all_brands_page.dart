import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/presentation/pages/home/brand_details_page.dart';

class AllBrandsPage extends StatefulWidget {
  const AllBrandsPage({super.key});

  @override
  State<AllBrandsPage> createState() => _AllBrandsPageState();
}

class _AllBrandsPageState extends State<AllBrandsPage> {
  final List<Map<String, dynamic>> _allBrands = [
    {
      'name': 'Apple',
      'image': 'https://cdn.jsdelivr.net/gh/devicons/devicon/icons/apple/apple-original.svg',
      'color': AppColors.primary,
    },
    {
      'name': 'Samsung',
      'image': 'https://www.svgrepo.com/show/303194/samsung-11-logo.svg',
      'color': AppColors.secondary,
    },
    {
      'name': 'Google',
      'image': 'https://www.svgrepo.com/show/475656/google-color.svg',
      'color': AppColors.success,
    },
    {
      'name': 'OnePlus',
      'image': 'https://www.svgrepo.com/show/475667/oneplus-color.svg',
      'color': AppColors.accent,
    },
    {
      'name': 'Xiaomi',
      'image': 'https://www.svgrepo.com/show/475693/xiaomi-color.svg',
      'color': AppColors.warning,
    },
    {
      'name': 'OPPO',
      'image': 'https://www.svgrepo.com/show/475688/oppo-color.svg',
      'color': AppColors.error,
    },
    {
      'name': 'Vivo',
      'image': 'https://www.svgrepo.com/show/475692/vivo-color.svg',
      'color': AppColors.tealPrimary,
    },
    {
      'name': 'Realme',
      'image': 'https://www.svgrepo.com/show/475689/realme-color.svg',
      'color': AppColors.primary,
    },
    {
      'name': 'Motorola',
      'image': 'https://www.svgrepo.com/show/475676/motorola-color.svg',
      'color': AppColors.secondary,
    },
    {
      'name': 'Nokia',
      'image': 'https://www.svgrepo.com/show/475677/nokia-color.svg',
      'color': AppColors.success,
    },
    {
      'name': 'Sony',
      'image': 'https://www.svgrepo.com/show/475681/sony-color.svg',
      'color': AppColors.accent,
    },
    {
      'name': 'LG',
      'image': 'https://www.svgrepo.com/show/475673/lg-color.svg',
      'color': AppColors.warning,
    },
  ];

  String _getBrandLogo(String brandName) {
    switch (brandName) {
      case 'Apple':
        return '';
      case 'Samsung':
        return '';
      case 'Google':
        return 'G';
      case 'OnePlus':
        return '1+';
      case 'Xiaomi':
        return 'MI';
      case 'OPPO':
        return 'OP';
      default:
        return brandName.substring(0, 2).toUpperCase();
    }
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
      appBar: AppBar(
        title: const Text('All Brands'),
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            theme.platform == TargetPlatform.iOS
                ? Icons.arrow_back_ios_new
                : Icons.arrow_back,
            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.85,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: _allBrands.length,
          itemBuilder: (context, index) {
            final brand = _allBrands[index];
            return Material(
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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          color: (brand['color'] as Color).withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: brand['image'] != null
                            ? Padding(
                                padding: const EdgeInsets.all(12),
                                child: SvgPicture.network(
                                  brand['image'] as String,
                                  width: 32,
                                  height: 32,
                                  fit: BoxFit.contain,
                                  placeholderBuilder: (context) => SizedBox(
                                    width: 32,
                                    height: 32,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        brand['color'] as Color,
                                      ),
                                    ),
                                  ),
                                  errorBuilder: (context, error, stackTrace) {
                                    return Icon(
                                      Icons.phone_iphone,
                                      color: brand['color'] as Color,
                                      size: 28,
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child: Text(
                                  _getBrandLogo(brand['name'] as String),
                                  style: TextStyle(
                                    color: brand['color'] as Color,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
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
            );
          },
        ),
      ),
      ),
    );
  }
}
