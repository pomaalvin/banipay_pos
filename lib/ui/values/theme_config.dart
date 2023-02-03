import 'package:banipay_pos/ui/widgets/tokens/bp_colors.dart';
import 'package:flutter/material.dart';

import '../widgets/atoms/bp_text.dart';

class ThemeConfig{
  ThemeConfig._();
  static ThemeData config(){

    final ThemeData base = ThemeData(fontFamily: "Arimo");
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.grey;
      }
      return BpColors.primary;
    }
    return ThemeData(
      textTheme: _globalTextTheme(base.textTheme),
      fontFamily: "Arimo",
      hoverColor: Colors.transparent,
      inputDecorationTheme: _globalInputDecorationTheme(base.inputDecorationTheme, _globalTextTheme(base.textTheme)),
      scrollbarTheme: ScrollbarThemeData(
          thumbColor: MaterialStateProperty.all(Colors.blueGrey)),
      primaryColor: BpColors.primary,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith(getColor),
        ),
      ),
      backgroundColor: Colors.grey,
      dividerColor: Colors.transparent,
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(
              color: BpColors.primary
          ),
          elevation: 5,
          backgroundColor: Colors.white,
          titleTextStyle: TextStyle(
              color: BpColors.tertiary
          )

      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: <TargetPlatform, PageTransitionsBuilder>{
          TargetPlatform.android: ZoomPageTransitionsBuilder(),
          TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
        },

      ),
      colorScheme: ColorScheme(
          primary: BpColors.primary,
          secondary: BpColors.secondary,
          surface: Colors.white,
          background: BpColors.tertiary,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: BpColors.secondary,
          onSurface: Colors.grey,
          onBackground: BpColors.tertiary,
          onError: BpColors.tertiary,
          tertiary: BpColors.tertiary,
          brightness: Brightness.light),
    );
  }
}

InputDecorationTheme _globalInputDecorationTheme(InputDecorationTheme base, TextTheme baseText){
  return base.copyWith(
    labelStyle: baseText.bodyText1,
    hintStyle: baseText.bodyText1!.copyWith(color: Colors.grey),
    errorStyle: baseText.bodyText1,
  );
}
TextTheme _globalTextTheme(TextTheme base) {
  return base.copyWith(
    headline1: BpText.title(color: BpColors.tertiary, text: '').style,
    headline2: BpText.title(text: '',color: BpColors.tertiary).style,
    headline3: BpText.title(color: BpColors.tertiary, text: '').style,
    headline4: BpText.title(color: BpColors.tertiary, text: '').style,
    headline5: BpText.subtitle(color: BpColors.tertiary, text: '').style,
    headline6: BpText.subtitle(color: BpColors.tertiary, text: '').style,
    subtitle1: BpText.body(color: BpColors.tertiary, text: '',fontWeight: FontWeight.w500).style,
    subtitle2: BpText.body(color: BpColors.tertiary, text: '',fontWeight: FontWeight.w500).style,
    bodyText1: BpText.body(color: BpColors.tertiary, text: '',fontWeight: FontWeight.w500).style,
    bodyText2: BpText.body(color: BpColors.tertiary, text: '',fontWeight: FontWeight.w400).style,
    button: BpText.body(color: BpColors.tertiary, text: '',fontWeight: FontWeight.w500).style,
    caption: BpText.label(color: BpColors.tertiary, text: '',fontWeight: FontWeight.w500).style,
    overline: BpText.caption(color: BpColors.tertiary, text: '',fontWeight: FontWeight.w400).style,

  );
}