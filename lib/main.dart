import 'package:flutter/material.dart';
import 'package:weatherly/core/service/appsettingservise.dart';
import 'package:weatherly/core/utils/funtion.dart';
import 'package:weatherly/view/home_screen.dart';
import 'package:weatherly/view/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final settings = getIt<AppSettingsService>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: settings.isFirstTime ? const SplashScreen() : const HomeScreen(),
    );
  }
}
