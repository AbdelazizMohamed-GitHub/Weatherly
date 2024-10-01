import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/core/utils/app_color.dart';
import 'package:weatherly/cubits/city_weather_cubit/city_weather_cubit.dart';
import 'package:weatherly/view/widget/custom_text_form.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 20, top: 10),
      color: AppColor.pColor,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
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
                      BlocProvider.of<CityWeatherCubit>(context)
                          .getCityWeather(cityName: city);
                      FocusScope.of(context).unfocus();
                    }
                  },
                  icon: const Icon(Icons.search)),
            ),
          ),
        ],
      ),
    );
  }
}
