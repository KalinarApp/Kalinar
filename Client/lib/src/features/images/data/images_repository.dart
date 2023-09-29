import 'package:kalinar/src/utils/http/kalinar_http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'images_repository.g.dart';

class ImagesRepository {
  final KalinarHttpClient client;
  ImagesRepository(this.client);

  Future<String> uploadImage(String base64) async => client.post("$apiVersionPath/upload/image", {"data": base64}, (response) => response["url"]);
}

@riverpod
ImagesRepository getImagesRepository(GetImagesRepositoryRef ref) {
  return ImagesRepository(ref.watch(httpClientProvider));
}
