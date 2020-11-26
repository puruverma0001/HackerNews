import 'dart:convert';
import 'package:http/http.dart' show Client;
import '../models/item_model.dart';
import 'repository.dart';

final _root = "https://hacker-news.firebaseio.com/v0";

class NewsApiProvider implements Source{
  Client client = Client();
  String topStoriesUrl = "$_root/topstories.json?print=pretty";
  Future<List<int>> fetchTopIds() async{
   final response = await client.get(topStoriesUrl);
   final ids = json.decode(response.body);

   return ids.cast<int>();
  }

  Future<ItemModel> fetchItem(int id) async{
    final response =
        await client.get("$_root/item/$id.json?print=pretty");
    final parsedJson = json.decode(response.body);

    return ItemModel.fromJson(parsedJson);
  }
}