import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppSpacing {
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;


  // Edge instes tepian 
  static const EdgeInsets paddingXs = EdgeInsets.all(xs);
  static const EdgeInsets paddingSm = EdgeInsets.all(sm);
  static const EdgeInsets paddingMd = EdgeInsets.all(md);
  static const EdgeInsets paddingLg = EdgeInsets.all(lg);
  static const EdgeInsets paddingXl = EdgeInsets.all(xl);
  static const EdgeInsets paddingXxl = EdgeInsets.all(xxl);

  // horizonatall edge
  static const EdgeInsets horizontalXs = EdgeInsets.symmetric(horizontal:xs);
  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal:sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal:md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal:lg);
  static const EdgeInsets horizontalXl = EdgeInsets.symmetric(horizontal:xl);  

  // vertical edge
  static const EdgeInsets verticalXs = EdgeInsets.symmetric(vertical:xs);
  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical:sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical:md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical:lg);
  static const EdgeInsets verticalXl = EdgeInsets.symmetric(vertical:xl);
}

// border
 class AppRadius {
  static const double sm = 8.0;
  static const double md = 12.0;
  static const double lg = 16.0;
  static const double xl = 24.0;
 }


 // text styles 
 // acces through context.via styles

 extension TextStyleContent on BuildContext {
    TextTheme get TextStyles => Theme.of(this).textTheme;
 } 

 extension TextStyleExtensions on TextStyle {
   TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  /// Make text semi-bold
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  /// Make text medium weight
  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  /// Make text normal weight
  TextStyle get normal => copyWith(fontWeight: FontWeight.w400);

  /// Make text light
  TextStyle get light => copyWith(fontWeight: FontWeight.w300);

  /// Add custom color
  TextStyle withColor(Color color) => copyWith(color: color);

  /// Add custom size
  TextStyle withSize(double size) => copyWith(fontSize: size);
}


 // color 

 class LightModeColors {
  static const lightPrimary = Color(0xFF6B9FDB);
  static const lightOnPrimary = Color(0xFF1A1A1A);
  static const lightPrimaryContainer = Color(0xFFD4E7F8);
  static const lightOnPrimaryContainer = Color(0xFF1A1A1A);

  // Secondary: Warm beige
  static const lightSecondary = Color(0xFFE8D5B7);
  static const lightOnSecondary = Color(0xFF1A1A1A);

  // Tertiary: Soft mint green
  static const lightTertiary = Color(0xFFB8E6C9);
  static const lightOnTertiary = Color(0xFF1A1A1A);

  // Error colors
  static const lightError = Color(0xFFE57373);
  static const lightOnError = Color(0xFFFFFFFF);
  static const lightErrorContainer = Color(0xFFFFDAD6);
  static const lightOnErrorContainer = Color(0xFF410002);

  // Surface and background: Clean white
  static const lightSurface = Color(0xFFFFFFFF);
  static const lightOnSurface = Color(0xFF1A1A1A);
  static const lightBackground = Color(0xFFFAFAFA);
  static const lightSurfaceVariant = Color(0xFFF5F5F5);
  static const lightOnSurfaceVariant = Color(0xFF4A4A4A);

  // Accent colors for chat modes
  static const accentBlue = Color(0xFFD4E7F8);
  static const accentBeige = Color(0xFFF5EFE7);
  static const accentGreen = Color(0xFFE8F5E9);
  static const accentYellow = Color(0xFFFFF9E6);

  // Outline and shadow
  static const lightOutline = Color(0xFFE0E0E0);
  static const lightShadow = Color(0xFF000000);
  static const lightInversePrimary = Color(0xFF6B9FDB);


 }
 class darkModeColors {
   static const darkPrimary = Color(0xFF6B9FDB);
  static const darkOnPrimary = Color(0xFF1A1A1A);
  static const darkPrimaryContainer = Color(0xFF2A3F5A);
  static const darkOnPrimaryContainer = Color(0xFFD4E7F8);

  // Secondary
  static const darkSecondary = Color(0xFFE8D5B7);
  static const darkOnSecondary = Color(0xFF1A1A1A);

  // Tertiary
  static const darkTertiary = Color(0xFFB8E6C9);
  static const darkOnTertiary = Color(0xFF1A1A1A);

  // Error colors
  static const darkError = Color(0xFFE57373);
  static const darkOnError = Color(0xFF1A1A1A);
  static const darkErrorContainer = Color(0xFF93000A);
  static const darkOnErrorContainer = Color(0xFFFFDAD6);

  // Surface and background: Deep dark
  static const darkSurface = Color(0xFF1A1A1A);
  static const darkOnSurface = Color(0xFFE8E8E8);
  static const darkSurfaceVariant = Color(0xFF2A2A2A);
  static const darkOnSurfaceVariant = Color(0xFFC4C4C4);

  // Accent colors for chat modes (darker variants)
  static const accentBlue = Color(0xFF2A3F5A);
  static const accentBeige = Color(0xFF3A342E);
  static const accentGreen = Color(0xFF2A3F2E);
  static const accentYellow = Color(0xFF3F3A2A);

  // Outline and shadow
  static const darkOutline = Color(0xFF3A3A3A);
  static const darkShadow = Color(0xFF000000);
  static const darkInversePrimary = Color(0xFF6B9FDB);

 }


/// Font size constants
class FontSizes {
  static const double displayLarge = 57.0;
  static const double displayMedium = 45.0;
  static const double displaySmall = 36.0;
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 28.0;
  static const double headlineSmall = 24.0;
  static const double titleLarge = 22.0;
  static const double titleMedium = 16.0;
  static const double titleSmall = 14.0;
  static const double labelLarge = 14.0;
  static const double labelMedium = 12.0;
  static const double labelSmall = 11.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
}


// lgiht theme data 
ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: LightModeColors.lightPrimary,
    onPrimary: LightModeColors.lightOnPrimary,
    primaryContainer: LightModeColors.lightPrimaryContainer,
    onPrimaryContainer: LightModeColors.lightOnPrimaryContainer,
    secondary: LightModeColors.lightSecondary,
    onSecondary: LightModeColors.lightOnSecondary,
    tertiary: LightModeColors.lightTertiary,
    onTertiary: LightModeColors.lightOnTertiary,
    error: LightModeColors.lightError,
    onError: LightModeColors.lightOnError,
    errorContainer: LightModeColors.lightErrorContainer,
    onErrorContainer: LightModeColors.lightOnErrorContainer,
    surface: LightModeColors.lightSurface,
    onSurface: LightModeColors.lightOnSurface,
    surfaceContainerHighest: LightModeColors.lightSurfaceVariant,
    onSurfaceVariant: LightModeColors.lightOnSurfaceVariant,
    outline: LightModeColors.lightOutline,
    shadow: LightModeColors.lightShadow,
    inversePrimary: LightModeColors.lightInversePrimary,
  ),
  brightness: Brightness.light,
  scaffoldBackgroundColor: LightModeColors.lightBackground,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    foregroundColor: LightModeColors.lightOnSurface,
    elevation: 0,
    scrolledUnderElevation: 0,
  ),

cardTheme: CardThemeData(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: BorderSide(
        color: LightModeColors.lightOutline.withValues(alpha: 0.2),
        width: 1,
      ),
    ),
  ),
  textTheme: _buildTextTheme(Brightness.light),
);

TextTheme _buildTextTheme(Brightness brightness) {
  return TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: FontSizes.displayLarge,
      fontWeight: FontWeight.w400,
      letterSpacing: -0.25,
    ),
    displayMedium: GoogleFonts.inter(
      fontSize: FontSizes.displayMedium,
      fontWeight: FontWeight.w400,
    ),
    displaySmall: GoogleFonts.inter(
      fontSize: FontSizes.displaySmall,
      fontWeight: FontWeight.w400,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: FontSizes.headlineLarge,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.5,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: FontSizes.headlineMedium,
      fontWeight: FontWeight.w600,
    ),
    headlineSmall: GoogleFonts.inter(
      fontSize: FontSizes.headlineSmall,
      fontWeight: FontWeight.w600,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: FontSizes.titleLarge,
      fontWeight: FontWeight.w600,
    ),
    titleMedium: GoogleFonts.inter(
      fontSize: FontSizes.titleMedium,
      fontWeight: FontWeight.w500,
    ),
    titleSmall: GoogleFonts.inter(
      fontSize: FontSizes.titleSmall,
      fontWeight: FontWeight.w500,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: FontSizes.labelLarge,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
    ),
    labelMedium: GoogleFonts.inter(
      fontSize: FontSizes.labelMedium,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: FontSizes.labelSmall,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.5,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: FontSizes.bodyLarge,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: FontSizes.bodyMedium,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: FontSizes.bodySmall,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
    ),
  );
}


