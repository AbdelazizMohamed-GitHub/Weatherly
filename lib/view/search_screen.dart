import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:weatherly/core/cubits/weather_cubit/weather_cubit.dart';
import 'package:weatherly/core/cubits/weather_cubit/weather_state.dart';
import 'package:weatherly/core/utils/app_color.dart';
import 'package:weatherly/core/utils/app_image.dart';
import 'package:weatherly/model/weather_entity.dart';
import 'package:weatherly/view/widget/custom_degree_item.dart';
import 'package:weatherly/view/widget/custom_text_form.dart';
import 'package:weatherly/view/widget/loading_.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  WeatherEntity? weather;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back)),
              Expanded(
                child: CustomTextForm(
                  onChanged: (value) {},
                  text: 'City',
                  textController: _searchController,
                  textType: TextInputType.text,
                  iconButton: IconButton(
                      onPressed: () {
                        final city = _searchController.text.trim();
                        if (city.isNotEmpty) {
                          BlocProvider.of<WeatherCubit>(context)
                              .getWeather(cityName: city);
                              FocusScope.of(context).unfocus();
                          
                        }
                      },
                      icon: const Icon(Icons.search)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          BlocConsumer<WeatherCubit, WeatherState>(
            listener: (context, state) {
              if (state is CityWeatherSuccess) {
                weather = state.weatherEntity;
              }
            },
            builder: (context, state) {
              return state is CityWeatherLoading
                  ? const Loading()
                  : state is CityWeatherError
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(state.error),
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<WeatherCubit>(context)
                                      .getWeatherForCurrentLocation();
                                },
                                child: const Text('Retry'))
                          ],
                        )
                      : state is CityWeatherSuccess
                          ? Container(
                              width: double.infinity,
                              alignment: Alignment.topCenter,
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromARGB(179, 243, 238,
                                        238), // Lighter blue (sky blue)
                                    AppColor.sColor, // Darker blue (ocean blue)
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                              child: Column(
                                children: [
                                 
                                  Text('${weather!.cityName}',
                                      style: const TextStyle(
                                          fontSize: 24.0)),
                                  Text('${weather!.avgTemp}°C',
                                      style: const TextStyle(
                                          fontSize: 18.0)),
                                 
                                  
                                  SizedBox(
                                    height: 250,
                                    child: Swiper(
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Stack(
                                          alignment: Alignment.topCenter,
                                          children: [
                                            Positioned(
                                              top: 25,
                                              left: 0,
                                              right: 0,
                                              bottom: 0,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    gradient:
                                                        const LinearGradient(
                                                            colors: [
                                                          Colors.white70,
                                                          AppColor.pColor,
                                                        ],
                                                            begin: Alignment
                                                                .topCenter,
                                                            end: Alignment
                                                                .center),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    const SizedBox(height: 10),
                                                    Image.network(
                                                      "${weather!.days![index].icon}",
                                                      width: 150,
                                                      height: 120,
                                                      fit: BoxFit.cover,
                                                    ),
                                                    const SizedBox(
                                                      height: 3,
                                                    ),
                                                    Text(
                                                      '${weather!.days![index].avgTemp}°C',
                                                      style: const TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 24,
                                                          fontWeight:
                                                              FontWeight.w600),
                                                    ),
                                                    Text(
                                                      '${weather!.days![index].status}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  color: Colors.white),
                                              child: Text(
                                                '${weather!.days![index].date}',
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      itemCount: weather!.days!.length,
                                      viewportFraction: 0.7,
                                      scale: 0.8,
                                    ),
                                  ),
                                  Container(
                                    margin: const EdgeInsets.all(20),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          CustomDegreeItem(
                                              image: AppImage.humidity,
                                              number: '${weather!.humidity}%',
                                              title: 'Humidity'),
                                          CustomDegreeItem(
                                              image: AppImage.wind,
                                              number:
                                                  '${weather!.windSpeed} km/h',
                                              title: 'Wind'),
                                          CustomDegreeItem(
                                              image: AppImage.speedometer,
                                              number: '${weather!.airPresure}',
                                              title: 'Air Pressure'),
                                          CustomDegreeItem(
                                              image: AppImage.visibility,
                                              number:
                                                  '${weather!.visibility}km',
                                              title: 'Visibility'),
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: SizedBox(
                                      height: 180,
                                      child: ListView.separated(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: weather!.hours!.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const SizedBox(
                                            width: 10,
                                          );
                                        },
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Container(
                                            padding: const EdgeInsets.all(10),
                                            width: 130,
                                            decoration: ShapeDecoration(
                                              color: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  weather!.hours![index].time!
                                                      .substring(11, 16),
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w600,
                                                    height: 0,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Expanded(
                                                  child: Image.network(
                                                    "https:${weather!.hours![index].icon}",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  '${weather!.hours![index].temp}°C',
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                ],
                              ),
                            )
                          : const Text(
                              'Search Result Not Found',
                              style: TextStyle(color: Colors.black),
                            );
            },
          ),
        ]),
      ),
    );
  }
}
