//xx
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/sport_model.dart';

class SportController{
    List<Sport> parseSports(String responseBody){
        final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
        return parsed.map<Sport> ((json)=> Sport.fromJson(json)).toList();
    }


    Future<List<Sport>> fetchSports() async {
        final response = await http.get(Uri.parse('http://192.168.1.34:8000/api/sports'));
    }
    if (response.statusCode == 200) {
      
      final sports = parseSports(response.body);
      return sports;
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
}
