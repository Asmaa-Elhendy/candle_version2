import 'dart:convert';


class Candle{
  String result_fo = '0';
  String result_wax = '0';
  double fragranceOil = 0;
  double totalWeight = 0;
  String unitOil='g';
  String unitWax='g';
  int totalcandles=1;

  Candle({required this.fragranceOil,required this.totalWeight,required this.result_fo,required this.unitOil,required this.result_wax,required this.unitWax,required this.totalcandles});

  factory Candle.fromJson(Map<String, dynamic> json) => Candle(
      fragranceOil: json["fragranceOil"],
      totalWeight: json["totalWeight"] ,
      result_fo: json["result_fo"],
      result_wax: json["result_wax"],
      unitOil: json["unitOil"]??'g',
      unitWax: json["unitWax"]??'g',
      totalcandles:json['totalcandles']??1


  );
  static Map<String, dynamic> toJson(Candle candle) => {
    "fragranceOil": candle.fragranceOil,
    "totalWeight": candle.totalWeight ,
    "result_fo": candle.result_fo,
    "unitOil":candle.unitOil,
    "unitWax" : candle.unitWax,
    "result_wax": candle.result_wax,
    "totalcandles":candle.totalcandles

  };
  static String encode(List<Candle> candles) => json.encode(
    candles
        .map<Map<String, dynamic>>((candle) => Candle.toJson(candle))
        .toList(),
  );

  static List<Candle> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<Candle>((item) => Candle.fromJson(item))
          .toList();


}





