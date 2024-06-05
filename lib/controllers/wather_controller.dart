import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:weather/weather.dart';

class WeatherController extends GetxController {

  bool isSearching = false;
  final WeatherFactory wf = WeatherFactory("f51d78d050e13381e2b504849a6a5b74");
  Weather? weather;
  bool isLoading=false;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getData("dhaka");
  }
  getData(String cname)async{
    isLoading=true;
    await wf.currentWeatherByCityName(cname).then((w){
      weather = w;
      isLoading=false;
      update();
    });

  }

}
