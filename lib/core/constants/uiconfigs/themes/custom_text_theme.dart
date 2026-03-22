import 'package:flutter/material.dart';

class CustomTextTheme extends ThemeExtension<CustomTextTheme> {
  // Tab TextStyles
  final TextStyle display1BoldLarge;
  final TextStyle display1RegularLarge;
  final TextStyle display2BoldLarge;
  final TextStyle display2RegularLarge;

  // Mobile Heading TextStyles
  final TextStyle heading1BoldLarge;
  final TextStyle heading1RegularLarge;
  final TextStyle heading2BoldMedium;
  final TextStyle heading2RegularMedium;
  final TextStyle heading3BoldSmall;
  final TextStyle heading3RegularSmall;
  final TextStyle heading4BoldExtraSmall;
  final TextStyle heading4RegularExtraSmall;

  // Mobile Body TextStyles
  final TextStyle body1BoldLarge;
  final TextStyle body1MediumLarge;
  final TextStyle body1RegularLarge;
  final TextStyle body2BoldSmall;
  final TextStyle body2MediumSmall;
  final TextStyle body2RegularSmall;

  // Caption TextStyles
  final TextStyle caption1Bold;
  final TextStyle caption1Regular;
  final TextStyle caption2Bold;
  final TextStyle caption2Regular;

  CustomTextTheme({
    required this.display1BoldLarge,
    required this.display1RegularLarge,
    required this.display2BoldLarge,
    required this.display2RegularLarge,
    required this.heading1BoldLarge,
    required this.heading1RegularLarge,
    required this.heading2BoldMedium,
    required this.heading2RegularMedium,
    required this.heading3BoldSmall,
    required this.heading3RegularSmall,
    required this.heading4BoldExtraSmall,
    required this.heading4RegularExtraSmall,
    required this.body1BoldLarge,
    required this.body1MediumLarge,
    required this.body1RegularLarge,
    required this.body2BoldSmall,
    required this.body2MediumSmall,
    required this.body2RegularSmall,
    required this.caption1Bold,
    required this.caption1Regular,
    required this.caption2Bold,
    required this.caption2Regular,
  });

  @override
  CustomTextTheme copyWith({
    TextStyle? display1BoldLarge,
    TextStyle? display1RegularLarge,
    TextStyle? display2BoldLarge,
    TextStyle? display2RegularLarge,
    TextStyle? heading1BoldLarge,
    TextStyle? heading1RegularLarge,
    TextStyle? heading2BoldMedium,
    TextStyle? heading2RegularMedium,
    TextStyle? heading3BoldSmall,
    TextStyle? heading3RegularSmall,
    TextStyle? heading4BoldExtraSmall,
    TextStyle? heading4RegularExtraSmall,
    TextStyle? body1BoldLarge,
    TextStyle? body1MediumLarge,
    TextStyle? body1RegularLarge,
    TextStyle? body2BoldSmall,
    TextStyle? body2MediumSmall,
    TextStyle? body2RegularSmall,
    TextStyle? caption1Bold,
    TextStyle? caption1Regular,
    TextStyle? caption2Bold,
    TextStyle? caption2Regular,
  }) {
    return CustomTextTheme(
      display1BoldLarge: display1BoldLarge ?? this.display1BoldLarge,
      display1RegularLarge: display1RegularLarge ?? this.display1RegularLarge,
      display2BoldLarge: display2BoldLarge ?? this.display2BoldLarge,
      display2RegularLarge: display2RegularLarge ?? this.display2RegularLarge,
      heading1BoldLarge: heading1BoldLarge ?? this.heading1BoldLarge,
      heading1RegularLarge: heading1RegularLarge ?? this.heading1RegularLarge,
      heading2BoldMedium: heading2BoldMedium ?? this.heading2BoldMedium,
      heading2RegularMedium:
          heading2RegularMedium ?? this.heading2RegularMedium,
      heading3BoldSmall: heading3BoldSmall ?? this.heading3BoldSmall,
      heading3RegularSmall: heading3RegularSmall ?? this.heading3RegularSmall,
      heading4BoldExtraSmall:
          heading4BoldExtraSmall ?? this.heading4BoldExtraSmall,
      heading4RegularExtraSmall:
          heading4RegularExtraSmall ?? this.heading4RegularExtraSmall,
      body1BoldLarge: body1BoldLarge ?? this.body1BoldLarge,
      body1MediumLarge: body1MediumLarge ?? this.body1MediumLarge,
      body1RegularLarge: body1RegularLarge ?? this.body1RegularLarge,
      body2BoldSmall: body2BoldSmall ?? this.body2BoldSmall,
      body2MediumSmall: body2MediumSmall ?? this.body2MediumSmall,
      body2RegularSmall: body2RegularSmall ?? this.body2RegularSmall,
      caption1Bold: caption1Bold ?? this.caption1Bold,
      caption1Regular: caption1Regular ?? this.caption1Regular,
      caption2Bold: caption2Bold ?? this.caption2Bold,
      caption2Regular: caption2Regular ?? this.caption2Regular,
    );
  }

  @override
  CustomTextTheme lerp(ThemeExtension<CustomTextTheme>? other, double t) {
    if (other is! CustomTextTheme) return this;
    return CustomTextTheme(
      display1BoldLarge:
          TextStyle.lerp(display1BoldLarge, other.display1BoldLarge, t)!,
      display1RegularLarge:
          TextStyle.lerp(display1RegularLarge, other.display1RegularLarge, t)!,
      display2BoldLarge:
          TextStyle.lerp(display2BoldLarge, other.display2BoldLarge, t)!,
      display2RegularLarge:
          TextStyle.lerp(display2RegularLarge, other.display2RegularLarge, t)!,
      heading1BoldLarge:
          TextStyle.lerp(heading1BoldLarge, other.heading1BoldLarge, t)!,
      heading1RegularLarge:
          TextStyle.lerp(heading1RegularLarge, other.heading1RegularLarge, t)!,
      heading2BoldMedium:
          TextStyle.lerp(heading2BoldMedium, other.heading2BoldMedium, t)!,
      heading2RegularMedium:
          TextStyle.lerp(
            heading2RegularMedium,
            other.heading2RegularMedium,
            t,
          )!,
      heading3BoldSmall:
          TextStyle.lerp(heading3BoldSmall, other.heading3BoldSmall, t)!,
      heading3RegularSmall:
          TextStyle.lerp(heading3RegularSmall, other.heading3RegularSmall, t)!,
      heading4BoldExtraSmall:
          TextStyle.lerp(
            heading4BoldExtraSmall,
            other.heading4BoldExtraSmall,
            t,
          )!,
      heading4RegularExtraSmall:
          TextStyle.lerp(
            heading4RegularExtraSmall,
            other.heading4RegularExtraSmall,
            t,
          )!,
      body1BoldLarge: TextStyle.lerp(body1BoldLarge, other.body1BoldLarge, t)!,
      body1MediumLarge:
          TextStyle.lerp(body1MediumLarge, other.body1MediumLarge, t)!,
      body1RegularLarge:
          TextStyle.lerp(body1RegularLarge, other.body1RegularLarge, t)!,
      body2BoldSmall: TextStyle.lerp(body2BoldSmall, other.body2BoldSmall, t)!,
      body2MediumSmall:
          TextStyle.lerp(body2MediumSmall, other.body2MediumSmall, t)!,
      body2RegularSmall:
          TextStyle.lerp(body2RegularSmall, other.body2RegularSmall, t)!,
      caption1Bold: TextStyle.lerp(caption1Bold, other.caption1Bold, t)!,
      caption1Regular:
          TextStyle.lerp(caption1Regular, other.caption1Regular, t)!,
      caption2Bold: TextStyle.lerp(caption2Bold, other.caption2Bold, t)!,
      caption2Regular:
          TextStyle.lerp(caption2Regular, other.caption2Regular, t)!,
    );
  }
}

extension CustomTextThemeExtension on BuildContext {
  CustomTextTheme get _customTextTheme =>
      Theme.of(this).extension<CustomTextTheme>()!;

  // Tab TextStyles
  TextStyle get display1BoldLarge => _customTextTheme.display1BoldLarge;
  TextStyle get display1RegularLarge => _customTextTheme.display1RegularLarge;
  TextStyle get display2BoldLarge => _customTextTheme.display2BoldLarge;
  TextStyle get display2RegularLarge => _customTextTheme.display2RegularLarge;

  // Mobile Heading TextStyles
  TextStyle get heading1BoldLarge => _customTextTheme.heading1BoldLarge;
  TextStyle get heading1RegularLarge => _customTextTheme.heading1RegularLarge;
  TextStyle get heading2BoldMedium => _customTextTheme.heading2BoldMedium;
  TextStyle get heading2RegularMedium => _customTextTheme.heading2RegularMedium;
  TextStyle get heading3BoldSmall => _customTextTheme.heading3BoldSmall;
  TextStyle get heading3RegularSmall => _customTextTheme.heading3RegularSmall;
  TextStyle get heading4BoldExtraSmall => _customTextTheme.heading4BoldExtraSmall;
  TextStyle get heading4RegularExtraSmall =>
      _customTextTheme.heading4RegularExtraSmall;

  // Mobile Body TextStyles
  TextStyle get body1BoldLarge => _customTextTheme.body1BoldLarge;
  TextStyle get body1MediumLarge => _customTextTheme.body1MediumLarge;
  TextStyle get body1RegularLarge => _customTextTheme.body1RegularLarge;
  TextStyle get body2BoldSmall => _customTextTheme.body2BoldSmall;
  TextStyle get body2MediumSmall => _customTextTheme.body2MediumSmall;
  TextStyle get body2RegularSmall => _customTextTheme.body2RegularSmall;

  // Caption TextStyles
  TextStyle get caption1Bold => _customTextTheme.caption1Bold;
  TextStyle get caption1Regular => _customTextTheme.caption1Regular;
  TextStyle get caption2Bold => _customTextTheme.caption2Bold;
  TextStyle get caption2Regular => _customTextTheme.caption2Regular;
}
