import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_details_model.dart';
import '../models/posts_model.dart';
import '../utils/api_endpoints.dart';

class ApiServices {

  static Future<List<PostModel>?> fetchData() async {
    final response = await http.get(ApiEndPoints.allPosts);
    if (response.statusCode == 200) {
      print('API is working fine');

      final jsonData = jsonDecode(response.body);
      final postList = (jsonData['products'] as List);

      return postList.map((postJson) => PostModel.fromJson(postJson)).toList();
    } else {
      print('Failed to fetch data');
      return null;
    }
  }

  static Future<PostDetailsModel?> getSinglePost(String id) async {
    final response = await http.get(Uri.parse('${ApiEndPoints.singlePost}/$id'));
    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      return PostDetailsModel.fromJson(decoded);
    } else {
      print('Error is ${response.body}');
      return null;
    }
  }
}
