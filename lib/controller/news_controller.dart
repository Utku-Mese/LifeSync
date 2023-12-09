import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsController{
    List<News> parseNews(String responseBody){
        final parsed = json.decode(responseBody).cast<Map<String,dynamic>>();
        return parsed.map<News>((json)=> News.fromJson(json)).toList();
    }

    Future<List<News>> fetchNews() async{
        final response = await http.get(Uri.parse('http://192.168.1.34:8000/api/news'));
        if (response.statusCode ==200 ){
            final news = parseNews(response.body);
            return news;
        }else {
            thros Exception('API request failed: ${response.statusCode}');
        }
    }


}