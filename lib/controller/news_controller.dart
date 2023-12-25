import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news_model.dart';

class NewsController {
  List<News> parseNews(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<News>((json) => News.fromJson(json)).toList();
  }

  //Get_all
  Future<List<News>> fetchNews() async {
    final response =await http.get(Uri.parse('http://192.168.141.229:8000/news'));
    if (response.statusCode == 200) {
      final news = parseNews(response.body);
      // ignore: avoid_print
      print(response.body);
      return news;
    } else {
      throw Exception('API request failed: ${response.statusCode}');
    }
  }

  Future<List<News>> fetchNewsByDate() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.1.34:8000/api/news/date'));

      if (response.statusCode == 200) {
        final news = parseNews(response.body);
        return news;
      } else {
        throw Exception('API request failed: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }
}
