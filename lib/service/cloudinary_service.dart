import 'dart:convert';
import 'dart:typed_data';

import 'package:http/http.dart' as http;

class CloudinaryService {
  final String cloudName;
  final String uploadPreset;

  CloudinaryService({required this.cloudName, required this.uploadPreset});

  Future<String> uploadImage({
    required Uint8List imageBytes,
    required String fileName,
  }) async {
    final Uri uploadUrl = Uri.parse(
      'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', uploadUrl);

    request.fields['upload_preset'] = uploadPreset;

    request.files.add(
      http.MultipartFile.fromBytes('file', imageBytes, filename: fileName),
    );

    final response = await request.send();

    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(responseBody);

      final String? imageUrl = data['secure_url'];

      if (imageUrl == null || imageUrl.isEmpty) {
        throw Exception('Upload succeeded but image URL was not returned.');
      }

      return imageUrl;
    }

    try {
      final Map<String, dynamic> errorData = jsonDecode(responseBody);

      final dynamic message = errorData['error']?['message'];

      throw Exception(
        message?.toString() ??
            'Cloudinary upload failed (${response.statusCode})',
      );
    } catch (e) {
      if (e is Exception) {
        rethrow;
      }

      throw Exception('Cloudinary upload failed (${response.statusCode})');
    }
  }
}
