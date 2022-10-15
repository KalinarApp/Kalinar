import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../../../utilities/constants.dart';

class ImgurRepository {
  Future<String?> uploadImageToImgur(String base64) async {
    String? imageUrl;
    Uri url = Uri.https(Constants.imgurApiUrl, "/3/image");

    var headers = {'Authorization': 'Client-ID ${Constants.imgurClientId}'};
    var request = http.MultipartRequest('POST', url);
    request.fields.addAll({'image': base64});

    request.headers.addAll(headers);

    final response = await request.send();
    if (response.statusCode == 200) {
      final body = json.decode(await response.stream.bytesToString());
      imageUrl = body["data"]["link"];
    }

    return imageUrl;
  }
}

final imgurRepositoryProvider = Provider<ImgurRepository>((ref) {
  return ImgurRepository();
});
