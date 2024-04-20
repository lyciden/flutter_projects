import 'dart:convert';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/secrets.dart';
import './Addition_information_card.dart';
import './Hourly_Forecast_Card.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic >> weather;

  // late double temp = -273.15;

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async{
    try{
      String cityname = 'Prague,cz';
    final res = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityname&APPID=$openApiWeatherKey'),
    );
    final data = jsonDecode(res.body);
    if(data['cod'] != '200'){
      throw "Unexpected error occured";
    }
    return data;
    } catch(e){
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Weather App',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions:[
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: (){
              setState(() {
                weather = getCurrentWeather();
              });
            },
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder:(context, snapshot) {
          
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(
              child: CircularProgressIndicator.adaptive()
            );
          }

          if(snapshot.hasError){ 
            return  Center(
              child: Text(snapshot.error.toString()
              )
            );
          }

          final data = snapshot.data!;

          final currentWeatherData = data['list'][0];
          final double currentTemp = currentWeatherData['main']['temp'] - 273.15;
          final currentWeatherDescription = currentWeatherData['weather'][0]['main'];
          final currentPressure = currentWeatherData['main']['pressure'];
          final currentHumidity = currentWeatherData['main']['humidity'];
          final double currentWindSpeed =currentWeatherData['wind']['speed'] ;
          
          return Padding(
          padding: const EdgeInsets.all(16.0),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start ,
            children: [
              SizedBox(
                width: double.infinity,
                height: 250,
                child:  Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child:  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child:  Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Text('${currentTemp.toStringAsFixed(2)}˚C', style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 32,
                            )),
                            const SizedBox(height: 10,),
                            Icon(
                              currentWeatherDescription == 'Rain' || currentWeatherDescription == 'Cloud'? Icons.cloud : Icons.sunny,
                               size: 100,
                            ),
                            const SizedBox(height: 10,),
                            Text(currentWeatherDescription, style: const TextStyle(
                              fontSize: 25,
                            )),
                          ],
                        ),
                      ),
                    ),
                  )
                ),
              ),
              const SizedBox(height: 10,),
              const Text(
                'Hourly forecast',
               style: TextStyle(
                 fontWeight: FontWeight.bold,
                  fontSize: 24
                  ),
                ),

              SizedBox(
                height: 150,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5,
                  itemBuilder: (context, index){
                    final hourlyForecastdata = data['list'][index + 1];
                    final hourlySky = hourlyForecastdata['weather'][0]['main'];
                    final time = DateTime.parse(hourlyForecastdata['dt_txt']);
                    return HourlyForecastCard(
                          time: DateFormat.j().format(time),
                          icon: hourlySky == 'Rain' || hourlySky == 'Cloud' ? Icons.cloud : Icons.sunny,
                          value : (hourlyForecastdata['main']['temp']- 273.15).toStringAsFixed(2),
                        );
                  },
                ),
              ),
              const SizedBox(height: 20,),
              const Text(
                'Additional information',
                style : TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  AdditionalInformationCard(
                    icon: Icons.water_drop,
                    label: 'Humidity',
                    value: currentHumidity.toString(),
                  ),
                  AdditionalInformationCard(
                    icon: Icons.air,
                    label: 'WindSpeed',
                    value:  currentWindSpeed.toStringAsFixed(2),
                  ),
                  AdditionalInformationCard(
                    icon: Icons.beach_access,
                    label: 'Pressure',
                    value: currentPressure.toString() ,
                  ),
                ],
              ),
            ],
          ),
        );
        },
      ),
    );
  }
}

