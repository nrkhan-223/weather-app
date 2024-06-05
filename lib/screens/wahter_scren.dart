import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:weather_app/controllers/wather_controller.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  var controllers = Get.put(WeatherController());
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: "Weather".text.make(),
        actions: [
          IconButton(
            icon: Icon(controllers.isSearching ? Icons.clear : Icons.search),
            onPressed: () {
              setState(() {
                controllers.isSearching = !controllers.isSearching;
              });
            },
          ),
          10.widthBox
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Visibility(
            visible: controllers.isSearching,
            child: Container(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 5),
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 1.2)),
                  hintText: "Name of city's",
                  suffixIcon: const Icon(Icons.search_sharp).onTap(() {
                    controllers.getData(textEditingController.text);
                    setState(() {
                      controllers.isSearching = !controllers.isSearching;
                    });
                    textEditingController.clear();
                  }),
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
          ),
          GetBuilder<WeatherController>(
              init: WeatherController(),
              builder: (controller) {
                if (controller.weather != null) {
                  return controller.isLoading
                      ? Padding(
                          padding: EdgeInsets.only(top: context.height / 2.7),
                          child: const CircularProgressIndicator()
                              .box
                              .makeCentered(),
                        )
                      : Column(
                          children: [
                            Text(
                              controller.weather?.areaName ?? "",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Column(
                              children: [
                                Text(
                                  DateFormat("h:mm a")
                                      .format(controller.weather!.date!),
                                  style: const TextStyle(
                                    fontSize: 35,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat("EEEE")
                                          .format(controller.weather!.date!),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "  ${DateFormat.yMMMd().format(controller.weather!.date!)}",
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  height: context.screenHeight * 0.20,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "http://openweathermap.org/img/wn/${controller.weather?.weatherIcon}@4x.png"),
                                    ),
                                  ),
                                ),
                                Text(
                                  controller.weather?.weatherDescription ?? "",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${controller.weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 90,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Container(
                              height: context.screenHeight * 0.15,
                              width: context.screenWidth * 0.80,
                              decoration: BoxDecoration(
                                color: Colors.deepPurpleAccent,
                                borderRadius: BorderRadius.circular(
                                  20,
                                ),
                              ),
                              padding: const EdgeInsets.all(
                                8.0,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Max: ${controller.weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "Min: ${controller.weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Wind: ${controller.weather?.windSpeed?.toStringAsFixed(0)}m/s",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                      Text(
                                        "Humidity: ${controller.weather?.humidity?.toStringAsFixed(0)}%",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                } else {
                  return Padding(
                    padding: EdgeInsets.only(top: context.height / 2.7),
                    child: const CircularProgressIndicator().box.makeCentered(),
                  );
                }
              }),
        ],
      ),
    );
  }
}
