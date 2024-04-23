import 'package:flutter/material.dart';
import 'color_theme.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'Aileron',
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 18),
            backgroundColor: AppColor.primaryColor,
            foregroundColor: Colors.black,
            elevation: 0),
        unselectedWidgetColor: Colors.black54,
        bottomNavigationBarTheme:
            const BottomNavigationBarThemeData(selectedItemColor: Colors.black),
        fontFamily: 'Aileron',
        textTheme: ThemeData.light().textTheme,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(primary: AppColor.primaryColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.black))),
        cardTheme: ThemeData.light().cardTheme,
        iconTheme: ThemeData.light().iconTheme,
        buttonBarTheme: ThemeData.light().buttonBarTheme,
        inputDecorationTheme: ThemeData.light().inputDecorationTheme,
        popupMenuTheme: ThemeData.light().popupMenuTheme,
        switchTheme: ThemeData.light().switchTheme,
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all(AppColor.primaryColor))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                foregroundColor:
                    MaterialStateProperty.all<Color>(AppColor.secondaryColor),
                textStyle: MaterialStateProperty.all(
                    const TextStyle(color: Colors.black)))),
        hintColor: Colors.grey,
        canvasColor: Colors.white,
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            buttonColor: AppColor.primaryColor));
  }

  static ThemeData get darkTheme {
    return ThemeData(
        datePickerTheme: const DatePickerThemeData(
          backgroundColor: Color(0xFF1F4247),
          headerBackgroundColor: Color(0xFF0D1D23),
        ),
        primaryColor: AppColor.primaryColor,
        scaffoldBackgroundColor: AppColor.backgroundColorDark,
        bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: AppColor.bottomSheetColorDark),
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20),
            backgroundColor: AppColor.appbarColorDark,
            elevation: 0.0),
        unselectedWidgetColor: Colors.grey.shade500,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            selectedItemColor: Colors.white,
            backgroundColor: AppColor.tabbarColorDark),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(primary: Colors.grey.shade900),
        elevatedButtonTheme: ThemeData.dark().elevatedButtonTheme,
        textTheme: ThemeData.dark()
            .textTheme
            .apply(
              bodyColor: Colors.grey,
            )
            .copyWith(
                titleMedium: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                titleLarge: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
        cardTheme: ThemeData.dark().cardTheme,
        iconTheme: ThemeData.dark().iconTheme,
        buttonBarTheme: ThemeData.dark().buttonBarTheme,
        hintColor: Colors.grey,
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Colors.black,
          selectionHandleColor: Colors.white
        ),
        inputDecorationTheme: InputDecorationTheme(
          fillColor: const Color(0xFD9D9D9),
          filled: true,
          labelStyle: const TextStyle(color: Colors.white),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0x38FFFFFF)),
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color(0x38FFFFFF)),
            borderRadius: BorderRadius.circular(20),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Color(0x38FFFFFF)),
          ),
        ),
        popupMenuTheme: ThemeData.dark().popupMenuTheme,
        switchTheme: ThemeData.dark().switchTheme,
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(Colors.white))),
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
                backgroundColor: Colors.grey.shade900,
                foregroundColor: Colors.white)),
        cardColor: Colors.grey.shade900,
        canvasColor: Colors.black,
        buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0)),
            buttonColor: Colors.grey.shade700),
        dialogBackgroundColor: Colors.grey.shade900);
  }
}
