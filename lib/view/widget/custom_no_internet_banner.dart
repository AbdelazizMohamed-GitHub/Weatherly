import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/cubits/current_weather_cubit/current_weather_cubit.dart';

class CustomNoInternetBanner extends StatelessWidget {
  const CustomNoInternetBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream:
          context.read<CurrentWeatherCubit>().internetService.connectionChanges,
      builder: (context, snapshot) {
        if (snapshot.data != false) {
          return const SizedBox.shrink();
        }

        return Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          color: const Color(0xFFB3261E),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.wifi_off, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text(
                'لا يوجد اتصال بالإنترنت',
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        );
      },
    );
  }
}
