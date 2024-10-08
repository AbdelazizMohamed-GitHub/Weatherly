import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/core/service/weather_service.dart';
import 'package:weatherly/core/utils/funtion.dart';
import 'package:weatherly/cubits/city_weather_cubit/city_weather_cubit.dart';
import 'package:weatherly/view/search_result_screen.dart';
import 'package:weatherly/view/widget/custom_search.dart';

// ignore: must_be_immutable
class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late String city = '';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CityWeatherCubit(weatherService: getIt.get<WeatherService>()),
      child: Scaffold(
        body: BlocBuilder<CityWeatherCubit, CityWeatherState>(
          builder: (context, state) {
            return SafeArea(
              child: Column(
                children: [
                  CustomSearch(
                    onChanged: (value) {
                      city = value;
                      

                      BlocProvider.of<CityWeatherCubit>(context)
                          .getRecommendedPlace(cityName: city);
                    },
                    
                  ),
                  state is FetchRecommendedLocationLoading && city.isNotEmpty
                      ? const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : state is FetchRecommendedLocationSuccess
                          ? state.suggestedPlaces.isNotEmpty
                              ? Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: ListView.builder(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    shrinkWrap: true,
                                    itemCount: state.suggestedPlaces.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return GestureDetector(
                                        onTap: () {
                                          FocusScope.of(context).unfocus();
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchResultScreen(
                                                        city: state
                                                                .suggestedPlaces[
                                                            index]),
                                              ));
                                        },
                                        child: ListTile(
                                          title: Text(
                                              state.suggestedPlaces[index]),
                                        ),
                                      );
                                    },
                                  ),
                                )
                              : const Center(
                                  child: Text('اكمل البحث'),
                                )
                          : const Expanded(
                              child: Center(
                              child: Text("البحث عن مكان"),
                            ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
