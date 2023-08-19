class NeshanModel{
  late String duration;
  late String distance;
  late String summery;
  late String points;

  NeshanModel.fromJson(Map<String,dynamic>json,this.points){
    duration = json['duration']['text'];
    distance = json['distance']['text'];
    summery = json["summery"];
  }
}