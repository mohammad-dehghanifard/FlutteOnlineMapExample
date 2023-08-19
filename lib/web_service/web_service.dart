import 'package:dio/dio.dart';
import 'package:flutter_online_map/model/neshan_model.dart';
import 'package:latlong2/latlong.dart';

class WebService{
  final Dio httpClient = Dio(BaseOptions(baseUrl: "https://api.neshan.org/v4/"));

  Future<dynamic> getDirection(LatLng origin , LatLng destination) async {
    final response  = await httpClient.get(
    "direction/no-traffic?origin=${origin.latitude},${origin.longitude}&destination=3${destination.latitude},${destination.longitude}");
    final points = response.data['routes'][0]['overview_polyline']['points'];
    NeshanModel.fromJson(
        response.data['routes'][0]['legs'][0],
        points);
  }
}