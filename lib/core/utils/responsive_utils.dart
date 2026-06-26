import 'package:flutter/material.dart';

class ResponsiveUtils {
  // Base design dimensions (iPhone 14 Pro)
  static const double baseWidth = 393.0;
  static const double baseHeight = 852.0;

  // Get screen dimensions
  static Size screenSize(BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double screenWidth(BuildContext context) {
    return screenSize(context).width;
  }

  static double screenHeight(BuildContext context) {
    return screenSize(context).height;
  }

  // Scale factor based on width
  static double scaleFactor(BuildContext context) {
    return screenWidth(context) / baseWidth;
  }

  // Scale factor based on height
  static double scaleFactorHeight(BuildContext context) {
    return screenHeight(context) / baseHeight;
  }

  // Responsive font size (scales primarily with width)
  static double responsiveFontSize(
    BuildContext context, {
    required double fontSize,
    double? min,
    double? max,
  }) {
    final scaled = fontSize * scaleFactor(context);
    if (min != null && scaled < min) return min;
    if (max != null && scaled > max) return max;
    return scaled;
  }

  // Responsive spacing (scales with width)
  static double responsiveSpacing(
    BuildContext context, {
    required double spacing,
    double? min,
    double? max,
  }) {
    final scaled = spacing * scaleFactor(context);
    if (min != null && scaled < min) return min;
    if (max != null && scaled > max) return max;
    return scaled;
  }

  // Responsive width (scales with screen width)
  static double responsiveWidth(
    BuildContext context, {
    required double width,
    double? min,
    double? max,
  }) {
    final scaled = width * scaleFactor(context);
    if (min != null && scaled < min) return min;
    if (max != null && scaled > max) return max;
    return scaled;
  }

  // Responsive height (scales with screen height)
  static double responsiveHeight(
    BuildContext context, {
    required double height,
    double? min,
    double? max,
  }) {
    final scaled = height * scaleFactorHeight(context);
    if (min != null && scaled < min) return min;
    if (max != null && scaled > max) return max;
    return scaled;
  }

  // Responsive border radius
  static double responsiveBorderRadius(
    BuildContext context, {
    required double radius,
    double? min,
    double? max,
  }) {
    final scaled = radius * scaleFactor(context);
    if (min != null && scaled < min) return min;
    if (max != null && scaled > max) return max;
    return scaled;
  }

  // Responsive icon size
  static double responsiveIconSize(
    BuildContext context, {
    required double size,
    double? min,
    double? max,
  }) {
    final scaled = size * scaleFactor(context);
    if (min != null && scaled < min) return min;
    if (max != null && scaled > max) return max;
    return scaled;
  }

  // Responsive padding
  static EdgeInsets responsivePadding(
    BuildContext context, {
    double? all,
    double? horizontal,
    double? vertical,
    double? top,
    double? bottom,
    double? left,
    double? right,
  }) {
    if (all != null) {
      final padding = responsiveSpacing(context, spacing: all);
      return EdgeInsets.all(padding);
    }
    final hPadding = horizontal != null ? responsiveSpacing(context, spacing: horizontal) : 0.0;
    return EdgeInsets.only(
      top: top != null ? responsiveSpacing(context, spacing: top) : hPadding,
      bottom: bottom != null ? responsiveSpacing(context, spacing: bottom) : hPadding,
      left: left != null ? responsiveSpacing(context, spacing: left) : hPadding,
      right: right != null ? responsiveSpacing(context, spacing: right) : hPadding,
    );
  }

  // Percentage of screen width
  static double widthPercentage(BuildContext context, double percentage) {
    return screenWidth(context) * (percentage / 100);
  }

  // Percentage of screen height
  static double heightPercentage(BuildContext context, double percentage) {
    return screenHeight(context) * (percentage / 100);
  }

  // Check if device is tablet
  static bool isTablet(BuildContext context) {
    final size = screenSize(context);
    return size.shortestSide >= 600;
  }

  // Check if device is mobile
  static bool isMobile(BuildContext context) {
    return !isTablet(context);
  }

  // Get text style with responsive font size
  static TextStyle responsiveTextStyle(
    BuildContext context, {
    required double fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
    double? min,
    double? max,
  }) {
    return TextStyle(
      fontSize: responsiveFontSize(
        context,
        fontSize: fontSize,
        min: min,
        max: max,
      ),
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  // Predefined responsive font sizes
  static double getHeading1(BuildContext context) => responsiveFontSize(context, fontSize: 32);
  static double getHeading2(BuildContext context) => responsiveFontSize(context, fontSize: 28);
  static double getHeading3(BuildContext context) => responsiveFontSize(context, fontSize: 24);
  static double getHeading4(BuildContext context) => responsiveFontSize(context, fontSize: 20);
  static double getHeading5(BuildContext context) => responsiveFontSize(context, fontSize: 18);
  static double getHeading6(BuildContext context) => responsiveFontSize(context, fontSize: 16);
  static double getBodyLarge(BuildContext context) => responsiveFontSize(context, fontSize: 16);
  static double getBodyMedium(BuildContext context) => responsiveFontSize(context, fontSize: 14);
  static double getBodySmall(BuildContext context) => responsiveFontSize(context, fontSize: 12);
  static double getCaption(BuildContext context) => responsiveFontSize(context, fontSize: 10);
  static double getOverline(BuildContext context) => responsiveFontSize(context, fontSize: 11);

  // Predefined responsive spacing
  static double getSpacingXS(BuildContext context) => responsiveSpacing(context, spacing: 4);
  static double getSpacingS(BuildContext context) => responsiveSpacing(context, spacing: 8);
  static double getSpacingM(BuildContext context) => responsiveSpacing(context, spacing: 16);
  static double getSpacingL(BuildContext context) => responsiveSpacing(context, spacing: 24);
  static double getSpacingXL(BuildContext context) => responsiveSpacing(context, spacing: 32);
  static double getSpacingXXL(BuildContext context) => responsiveSpacing(context, spacing: 48);
}
