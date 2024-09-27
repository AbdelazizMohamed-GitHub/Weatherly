import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/core/cubits/weather_cubit/weather_cubit.dart';
import 'package:weatherly/obserer.dart';
import 'package:weatherly/view/home_screen.dart';
import 'package:weatherly/view/search_screen.dart';
import 'package:weatherly/view/widget/loading_.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = Observer();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WeatherCubit()..getWeatherForCurrentLocation(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
