import 'dart:convert';
import 'package:final_project_tpm_prac/models/news_model.dart';
import 'package:http/http.dart' as http;

class BaseNetwork {
  // String apiKey = 'de17e0f00c9f40cc85b339998d6dbb40';
  String apiKey = '60a2fb5301a448ee88eb6be5d8219886';
  String baseUrl = 'https://newsapi.org/v2/';

  Future getNewsUS() async {
    Uri url = Uri.parse('${baseUrl}top-headlines?country=us&apikey=$apiKey');
    
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['articles'].map((json) => NewsModel.fromJson(json)).toList();
    } 
  }

  Future getNewsSearch(String query) async {
    Uri url = Uri.parse('${baseUrl}everything?q=$query&apiKey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['articles'].map((json) => NewsModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed Load News Search');
    }
  }
}