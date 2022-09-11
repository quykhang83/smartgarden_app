//--------------Use to test API - NOT in project ---------------//

import 'package:smartgarden_app/models/post.dart';
import 'package:http/http.dart' as http;

import '../models/observation.dart';

class RemoteService {
  Future<List<Post>?> getPosts() async {
    var client = http.Client();

    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return postFromJson(json);
    }
  }

  Future<List<Observation>?> getObservations() async {
    var client = http.Client();

    var uri = Uri.parse('52.221.234.221/api/get/observations(2)');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      print(json);
      return observationFromJson(json);
    }
  }
}
