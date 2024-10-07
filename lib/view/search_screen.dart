import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/core/utils/funtion.dart';
import 'package:weatherly/cubits/city_weather_cubit/city_weather_cubit.dart';
import 'package:weatherly/view/widget/custom_error_widget.dart';
import 'package:weatherly/view/widget/custom_sccess_body.dart';
import 'package:weatherly/view/widget/custom_search.dart';
import 'package:weatherly/view/widget/custom_loading.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String city = '';
    return BlocProvider(
      create: (context) =>
          CityWeatherCubit(weatherService: getIt.get<WeatherService>()),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              BlocConsumer<CityWeatherCubit, CityWeatherState>(
                listener: (context, state) {
                  // TODO: implement listener
                },
                builder: (context, state) {
                  return CustomSearch(
                    onChanged: (String value) async {
                      city = value;
                      print("111111111111111111${value}");
                      await BlocProvider.of<CityWeatherCubit>(context)
                          .getRecommendedPlace(
                        cityName: value,
                      );
                      print("222222222222222222${value}");
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              Expanded(
                child: BlocBuilder<CityWeatherCubit, CityWeatherState>(
                  builder: (context, state) {
                    return state is CityWeatherLoading
                        ? const Expanded(child: CustomLoading())
                        : state is CityWeatherError
                            ? CustomError(
                                onPressed: () {
                                  if (city.isNotEmpty) {
                                    BlocProvider.of<CityWeatherCubit>(context)
                                        .getCityWeather(cityName: city);
                                  }
                                },
                                text: state.error)
                            : state is CityWeatherSuccess
                                ? SingleChildScrollView(
                                    child: Expanded(
                                      child: CustomSccessBody(
                                        weather: state.weatherEntity,
                                        isHome: false,
                                      ),
                                    ),
                                  )
                                : state is FetchRecommendedLocationLoading
                                    ? const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                    : state is FetchRecommendedLocationSuccess
                                        ? SizedBox(
                                            height: 200,
                                            child: ListView.builder(
                                              itemCount:
                                                  state.suggestedPlaces.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    FocusScope.of(context)
                                                        .unfocus();
                                                    BlocProvider.of<
                                                                CityWeatherCubit>(
                                                            context)
                                                        .getCityWeather(
                                                            cityName: state
                                                                    .suggestedPlaces[
                                                                index]);
                                                  },
                                                  child: ListTile(
                                                    title: Text(
                                                        state.suggestedPlaces[
                                                            index]),
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : const Text("Search");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
