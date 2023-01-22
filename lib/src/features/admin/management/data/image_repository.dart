import 'dart:convert';

import 'package:flutter_flavor/flutter_flavor.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

class ImageRepository {
  Future<String?> uploadImageToImgur(String base64) async {
    String? imageUrl;
    Uri url = Uri.https(FlavorConfig.instance.variables["baseUrl"], "/api/upload");

    final response = await http.post(url, body: jsonEncode({"data": base64}), headers: {"content-type": "application/json"});
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      imageUrl = body["url"];
    }

    return imageUrl;
  }
}

final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  return ImageRepository();
});
