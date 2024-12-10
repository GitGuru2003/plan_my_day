import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: colorScheme.surface,
          elevation: 0,
          iconTheme: IconThemeData(color: colorScheme.onSurface),
          titleTextStyle: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: colorScheme.surface,
          selectedIconTheme: IconThemeData(
            color: colorScheme.primary,
          ),
          unselectedIconTheme: IconThemeData(
            color: colorScheme.onSurfaceVariant,
          ),
          indicatorColor: colorScheme.primaryContainer,
          selectedLabelTextStyle: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          indicatorColor: colorScheme.secondaryContainer,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                color: colorScheme.onSurface,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              );
            }
            return TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 12,
            );
          }),
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: colorScheme.surface,
        ),
        chipTheme: ChipThemeData(
          selectedColor: colorScheme.primaryContainer,
          labelStyle: TextStyle(color: colorScheme.onSurface),
          side: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.outline.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 2,
            ),
          ),
          labelStyle: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          floatingLabelStyle: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: colorScheme.outlineVariant,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(color: colorScheme.onSurface),
          titleMedium: TextStyle(color: colorScheme.onSurface),
          titleSmall: TextStyle(color: colorScheme.onSurface),
          bodyLarge: TextStyle(color: colorScheme.onSurface),
          bodyMedium: TextStyle(color: colorScheme.onSurface),
          bodySmall: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
      );

  static ThemeData darkTheme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.surface,
        appBarTheme: AppBarTheme(
          centerTitle: false,
          backgroundColor: colorScheme.surface,
          elevation: 0,
          iconTheme: IconThemeData(color: colorScheme.onSurface),
          titleTextStyle: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        navigationRailTheme: NavigationRailThemeData(
          backgroundColor: colorScheme.surface,
          selectedIconTheme: IconThemeData(
            color: colorScheme.primary,
          ),
          unselectedIconTheme: IconThemeData(
            color: colorScheme.onSurfaceVariant,
          ),
          indicatorColor: colorScheme.primaryContainer,
          selectedLabelTextStyle: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          unselectedLabelTextStyle: TextStyle(
            color: colorScheme.onSurfaceVariant,
          ),
        ),
        navigationBarTheme: NavigationBarThemeData(
          backgroundColor: colorScheme.surface,
          elevation: 0,
          indicatorColor: colorScheme.secondaryContainer,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return TextStyle(
                color: colorScheme.onSurface,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              );
            }
            return TextStyle(
              color: colorScheme.onSurfaceVariant,
              fontSize: 12,
            );
          }),
        ),
        cardTheme: CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          color: colorScheme.surface,
        ),
        chipTheme: ChipThemeData(
          selectedColor: colorScheme.primaryContainer,
          labelStyle: TextStyle(color: colorScheme.onSurface),
          side: BorderSide(color: colorScheme.outline.withOpacity(0.5)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: colorScheme.primary,
            foregroundColor: colorScheme.onPrimary,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.outline),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.outline.withOpacity(0.5),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: colorScheme.primary,
              width: 2,
            ),
          ),
          labelStyle: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
          floatingLabelStyle: TextStyle(
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        dividerTheme: DividerThemeData(
          color: colorScheme.outlineVariant,
        ),
        textTheme: TextTheme(
          titleLarge: TextStyle(color: colorScheme.onSurface),
          titleMedium: TextStyle(color: colorScheme.onSurface),
          titleSmall: TextStyle(color: colorScheme.onSurface),
          bodyLarge: TextStyle(color: colorScheme.onSurface),
          bodyMedium: TextStyle(color: colorScheme.onSurface),
          bodySmall: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
      );
}
