import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'providers/task_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Request notification permissions
  await _requestNotificationPermissions();

  // Initialize the local notifications
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> _requestNotificationPermissions() async {
  final status = await Permission.notification.request();
  if (status.isGranted) {
    print("Notification permission granted");
  } else {
    print("Notification permission denied");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
        return Consumer<ThemeProvider>(
          builder: (context, themeProvider, child) {
            final lightScheme = lightDynamic?.harmonized() ??
                ColorScheme.fromSeed(
                  seedColor: themeProvider.seedColor,
                  brightness: Brightness.light,
                );

            final darkScheme = darkDynamic?.harmonized() ??
                ColorScheme.fromSeed(
                  seedColor: themeProvider.seedColor,
                  brightness: Brightness.dark,
                );

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Plan my day',
              theme: AppTheme.lightTheme(lightScheme),
              darkTheme: AppTheme.darkTheme(darkScheme),
              themeMode:
                  themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
              home: const HomeScreen(),
            );
          },
        );
      },
    );
  }
}
