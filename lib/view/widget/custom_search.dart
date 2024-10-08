import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherly/core/utils/app_color.dart';
import 'package:weatherly/cubits/city_weather_cubit/city_weather_cubit.dart';
import 'package:weatherly/view/widget/custom_text_form.dart';

class CustomSearch extends StatefulWidget {
  const CustomSearch({super.key, required this.onChanged});
  final ValueChanged<String> onChanged;
  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {
  String city='';
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
                FocusScope.of(context).unfocus();
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          Expanded(
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: CustomTextForm(
                onFieldSubmitted: (p0) {
                
                  FocusScope.of(context).unfocus();
                
                  if (p0.isNotEmpty) {
                    BlocProvider.of<CityWeatherCubit>(context)
                        .getCityWeather(cityName: p0.trim());
                  }
                },
                onChanged: (value) {
                  widget.onChanged(value);
                  city = value;
                },
                text: 'ابحث عن مدينتك',
             
                textType: TextInputType.text,
                iconButton: IconButton(
                    onPressed: () {
                    
                      if (city.isNotEmpty) {
                        FocusScope.of(context).unfocus();
                        BlocProvider.of<CityWeatherCubit>(context)
                            .getCityWeather(cityName: city.trim());
                      }
                    },
                    icon: const Icon(Icons.search)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
