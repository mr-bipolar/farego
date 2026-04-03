import 'package:flutter/material.dart';

/// PADDING
class AppPadding {
  static const xSmall = EdgeInsets.all(4);
  static const small = EdgeInsets.all(8);
  static const medium = EdgeInsets.all(16);
  static const large = EdgeInsets.all(24);
  static const xLarge = EdgeInsets.all(32);
}

/// MARGIN
class AppMargin {
  static const xSmall = EdgeInsets.all(4);
  static const small = EdgeInsets.all(8);
  static const medium = EdgeInsets.all(16);
  static const large = EdgeInsets.all(24);
  static const xLarge = EdgeInsets.all(32);
}

/// RADIUS
class AppRadius {
  static const xSmall = Radius.circular(4);
  static const small = Radius.circular(8);
  static const medium = Radius.circular(12);
  static const large = Radius.circular(16);
  static const xLarge = Radius.circular(24);
}

/// BORDER RADIUS
class AppBorderRadius {
  static const xSmall = BorderRadius.all(Radius.circular(4));
  static const small = BorderRadius.all(Radius.circular(8));
  static const medium = BorderRadius.all(Radius.circular(12));
  static const large = BorderRadius.all(Radius.circular(16));
  static const xLarge = BorderRadius.all(Radius.circular(24));
}

/// SPACING

class AppSpacing {
  // Vertical spacers
  static const v4 = SizedBox(height: 4);
  static const v8 = SizedBox(height: 8);
  static const v12 = SizedBox(height: 12);
  static const v16 = SizedBox(height: 16);
  static const v20 = SizedBox(height: 20);
  static const v24 = SizedBox(height: 24);
  static const v32 = SizedBox(height: 32);

  // Horizontal spacers
  static const h4 = SizedBox(width: 4);
  static const h8 = SizedBox(width: 8);
  static const h12 = SizedBox(width: 12);
  static const h16 = SizedBox(width: 16);
  static const h20 = SizedBox(width: 20);
  static const h24 = SizedBox(width: 24);
  static const h32 = SizedBox(width: 32);
}

/// ICON SIZES
class AppIconSizes {
  static const s16 = 16.0;
  static const s20 = 20.0;
  static const s24 = 24.0;
  static const s32 = 32.0;
  static const s40 = 40.0;
}

/// TEXT SIZES (use with your TextTheme)
class AppTextSizes {
  static const small = 12.0;
  static const body = 14.0;
  static const medium = 16.0;
  static const large = 20.0;
  static const title = 24.0;
  static const headline = 32.0;
}
