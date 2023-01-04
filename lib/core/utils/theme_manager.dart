import 'font_manager.dart';
import 'values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'color_manager.dart';
import 'styles_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: ColorManager.black,

    // cardView theme
    cardTheme: const CardTheme(
      color: ColorManager.grey,
      shadowColor: ColorManager.black,
      elevation: AppSize.s4,
    ),

    // appBar Theme
    appBarTheme: AppBarTheme(
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.black,
        statusBarBrightness: Brightness.light,
      ),
      color: ColorManager.black,
      elevation: AppSize.s0,
      shadowColor: ColorManager.black,
      titleTextStyle: getRegularStyle(
        fontSize: FontSize.s16,
        color: ColorManager.white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      elevation: AppSize.s2,
      backgroundColor: ColorManager.black,
      selectedItemColor: ColorManager.primary,
      unselectedItemColor: ColorManager.grey,
    ),
    // button Theme
    buttonTheme: const ButtonThemeData(
      shape: StadiumBorder(),
      disabledColor: ColorManager.grey1,
      buttonColor: ColorManager.primary,
      splashColor: ColorManager.lightPrimary,
    ),

    // elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: getRegularStyle(
          color: ColorManager.white,
          fontSize: FontSize.s12,
        ),
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s12),
        ),
      ),
    ),

    // text Theme
    textTheme: TextTheme(
      displayLarge:
          getSemBoldStyle(color: ColorManager.grey, fontSize: FontSize.s16),
      headlineLarge:
          getSemBoldStyle(color: ColorManager.grey, fontSize: FontSize.s16),
      headlineMedium:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      titleMedium:
          getMediumStyle(color: ColorManager.white, fontSize: FontSize.s16),
      bodySmall: getRegularStyle(color: ColorManager.grey),
      bodyLarge: getRegularStyle(color: ColorManager.grey1),
      labelMedium:
          getBoldStyle(color: ColorManager.grey, fontSize: FontSize.s16),
    ),

    // input decoration theme (text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle:
          getRegularStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      labelStyle:
          getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s14),
      errorStyle: getRegularStyle(color: ColorManager.error),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.error, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
      focusedErrorBorder: const OutlineInputBorder(
        borderSide:
            BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
        borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
      ),
    ),
  );
}
