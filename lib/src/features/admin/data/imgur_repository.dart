import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../utilities/constants.dart';

class ImgurRepository {
  Future<String?> uploadImageToImgur(String base64) async {
    String? imageUrl;
    Uri url = Uri.http(Constants.imgurApiUrl, "/3/upload");

    Map<String, String> headers = {
      "Accept": "*/*",
      "Authorization": "Client-ID ${Constants.imgurClientId}",
    };

    Map<String, String> body = {
      "type": "base64",
      "image": base64,
    };

    final response = await http.post(url, headers: headers, body: body);
    if (response.statusCode < 400) {
      final body = json.decode(response.body);
      imageUrl = body["url"];
    }

    return imageUrl;
  }
}

final imgurRepositoryProvider = Provider<ImgurRepository>((ref) {
  return ImgurRepository();
});
