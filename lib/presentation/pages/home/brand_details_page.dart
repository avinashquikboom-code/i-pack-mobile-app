import 'package:flutter/material.dart';
import 'package:i_pack_mobile_app/core/theme/app_colors.dart';
import 'package:i_pack_mobile_app/presentation/pages/payment/payment_mode_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BrandDetailsPage extends StatefulWidget {
  final String brandName;
  final Color brandColor;
  final String? brandImage;

  const BrandDetailsPage({
    super.key,
    required this.brandName,
    required this.brandColor,
    this.brandImage,
  });

  @override
  State<BrandDetailsPage> createState() => _BrandDetailsPageState();
}

class _BrandDetailsPageState extends State<BrandDetailsPage> {
  final List<BrandDevice> _devices = [
    BrandDevice(
      name: 'iPhone 15 Pro Max',
      model: 'A3108',
      price: '₹1,199',
      image: 'iPhone 15 Pro Max',
      protectionPlan: 'Premium',
    ),
    BrandDevice(
      name: 'iPhone 15 Pro',
      model: 'A3102',
      price: '₹999',
      image: 'iPhone 15 Pro',
      protectionPlan: 'Standard',
    ),
    BrandDevice(
      name: 'iPhone 15',
      model: 'A3093',
      price: '₹799',
      image: 'iPhone 15',
      protectionPlan: 'Basic',
    ),
    BrandDevice(
      name: 'iPhone 14 Pro Max',
      model: 'A2893',
      price: '₹1,099',
      image: 'iPhone 14 Pro Max',
      protectionPlan: 'Premium',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.darkBackground : AppColors.lightBackground,
      appBar: AppBar(
        title: Text(widget.brandName),
        backgroundColor: Colors.transparent,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand Header
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    widget.brandColor.withValues(alpha: 0.15),
                    widget.brandColor.withValues(alpha: 0.05),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: widget.brandColor.withValues(alpha: 0.3),
                  width: 1.5,
                ),
              ),
              child: Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      color: widget.brandColor.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: widget.brandImage != null
                          ? SvgPicture.network(
                              widget.brandImage!,
                              fit: BoxFit.contain,
                              colorFilter: widget.brandName == 'Apple'
                                  ? ColorFilter.mode(isDark ? Colors.white : Colors.black87, BlendMode.srcIn)
                                  : null,
                              placeholderBuilder: (context) => const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            )
                          : Text(
                              _getBrandLogo(widget.brandName),
                              style: TextStyle(
                                color: widget.brandColor,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.brandName,
                          style: TextStyle(
                            color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${_devices.length} Devices Available',
                          style: TextStyle(
                            color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Devices Section
            Text(
              'Available Devices',
              style: TextStyle(
                color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 16),

            // Device Cards
            ..._devices.map((device) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildDeviceCard(device, isDark),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  Widget _buildDeviceCard(BrandDevice device, bool isDark) {
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
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaymentModePage(
                  deviceName: device.name,
                  deviceModel: device.model,
                  price: device.price,
                  brandColor: widget.brandColor,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(20),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: widget.brandColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.phone_iphone,
                  color: widget.brandColor,
                  size: 40,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      device.name,
                      style: TextStyle(
                        color: isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Model: ${device.model}',
                      style: TextStyle(
                        color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withValues(alpha: 0.12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            device.protectionPlan,
                            style: const TextStyle(
                              color: AppColors.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    device.price,
                    style: TextStyle(
                      color: widget.brandColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getBrandLogo(String brandName) {
    switch (brandName) {
      case 'Apple':
        return '';
      case 'Samsung':
        return 'S';
      case 'Google':
        return 'G';
      case 'OnePlus':
        return '1+';
      case 'Xiaomi':
        return 'MI';
      case 'OPPO':
        return 'OPPO';
      default:
        return brandName[0];
    }
  }
}

class BrandDevice {
  final String name;
  final String model;
  final String price;
  final String image;
  final String protectionPlan;

  BrandDevice({
    required this.name,
    required this.model,
    required this.price,
    required this.image,
    required this.protectionPlan,
  });
}
