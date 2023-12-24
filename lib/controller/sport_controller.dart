//xx
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/sport_model.dart';

class SportController {
  List<Sport> parseSports(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    print(parsed);
    return parsed.map<Sport>((json) => Sport.fromJson(json)).toList();
  }

  //Get_all
  Future<List<Sport>> fetchSports() async {
    final response =
        await http.get(Uri.parse('http://192.168.1.36:8000/sports'));
    if (response.statusCode == 200) {
      final sports = parseSports(response.body);
      return sports;
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  /*
    getRecordActivities(Sport sport,User user,int time){
        if (sport_types.containsKey(sport.type)) {
            double oran = sport_types[sport.type];
            return sport.calories * user.weight * time * oran;
        } else {
            throw Exception("Hatalı spor tipi: ${sport.type}");
            return 0.0;
         }
    }
    */

  /* getRecordActivities(Sport sport, int time) {
    if (sportTypes.containsKey(sport.type)) {
      double oran = sportTypes[sport.type]!;
      return sport.calories! * 70 * time * oran;
    } else {
      throw Exception("Hatalı spor tipi: ${sport.type}");
    }
  } */
}
