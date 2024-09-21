// ignore_for_file: prefer_const_constructors

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weatherly/utils/app_color.dart';
import 'package:weatherly/utils/app_image.dart';
import 'package:weatherly/view/widget/custom_degree_item.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          alignment: Alignment.topCenter,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(179, 243, 238, 238), // Lighter blue (sky blue)
                AppColor.sColor, // Darker blue (ocean blue)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Text('Cairo', style: TextStyle(fontSize: 24.0)),
              Text('23°C', style: TextStyle(fontSize: 18.0)),
              SizedBox(
                height: 250,
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Positioned(
                            top: 25,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                      colors: [
                                        Colors.white70,
                                        AppColor.pColor,
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.center),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AppImage.wind,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.contain,
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Text(
                                    '23°C',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Text(
                                    'Sunny',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white),
                          child: const Text(
                            'Sunday, 8 March 2021',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: 5,
                  viewportFraction: 0.7,
                  scale: 0.8,
                ),
              ),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.symmetric(horizontal: 20),
                height: 120,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      CustomDegreeItem(
                          image: AppImage.humidity,
                          number: '75%',
                          title: 'Humidity'),
                      CustomDegreeItem(
                          image: AppImage.wind,
                          number: '8 km/h',
                          title: 'Wind'),
                      CustomDegreeItem(
                          image: AppImage.speedometer,
                          number: '1101',
                          title: 'Air Pressure'),
                      CustomDegreeItem(
                          image: AppImage.visibility,
                          number: '6km',
                          title: 'Visibility'),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: const [
                    Text(
                      'Today',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                    Text(
                      'See Next 7 Days',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        width: 10,
                      );
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        width: 130,
                        decoration: ShapeDecoration(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '06:00 AM',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            SvgPicture.asset(
                              AppImage.wind,
                              width: 60,
                              height: 60,
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '23°C',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
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
        ),
      ),
    );
  }
}
