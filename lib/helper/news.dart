import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:newsapp_4/models/article_model.dart';
import 'package:http/http.dart' as http;
class News
{
  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=85f9699e154749bf86b26d3d4b03613d";

    var response = await http.get(Uri.parse(url));

    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        debugPrint(element.toString()); // Log the data for debugging

        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'] ?? '', // Provide default empty string if null
              author: element["author"]?.toString() ?? '', // Convert to string and provide default empty string if null
              description: element["description"] ?? '', // Provide default empty string if null
              url: element["url"] ?? '', // Provide default empty string if null
              urlToImage: element["urlToImage"] ?? '', // Provide default empty string if null
              content: element["content"] ?? '' // Provide default empty string if null
          );

          news.add(articleModel);
        }
      });
    }
  }


}

class CategoryNewsClass
{
  List<ArticleModel> news = [];

  Future<void> getNews(String category) async{
    String url = "https://newsapi.org/v2/top-headlines?country=us&category=$category&apiKey=85f9699e154749bf86b26d3d4b03613d";

    var response = await http.get(Uri.parse(url));
    debugPrint(url);

    var jsonData = jsonDecode(response.body);

    debugPrint(jsonData.toString());
    if(jsonData['status']== "ok")
    {
      jsonData["articles"].forEach((element){

        if(element["urlToImage"] != null && element['description'] != null)
        {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element["author"].toString(),
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"]
          );

          news.add(articleModel);
        }

      });
    }
  }

}