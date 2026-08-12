import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CloudinaryUploadPage extends StatefulWidget {
  const CloudinaryUploadPage({super.key});

  @override
  State<CloudinaryUploadPage> createState() => _CloudinaryUploadPageState();
}

class _CloudinaryUploadPageState extends State<CloudinaryUploadPage> {
  final ImagePicker _picker = ImagePicker();

  XFile? _selectedImage;

  Uint8List? _imageBytes;

  String? _uploadedImageUrl;

  bool _isUploading = false;

  final String cloudName = 'dglxnraim';

  final String uploadPreset = 'flutter_coffee_test';

  Future<void> pickImage() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );
      if (image == null) {
        return;
      }

      // Read image bytes
      final Uint8List bytes = await image.readAsBytes();

      if (!mounted) return;

      setState(() {
        _selectedImage = image;
        _imageBytes = bytes;

        // Remove previous uploaded image
        _uploadedImageUrl = null;
      });

      debugPrint('Selected image: ${image.name}');
      debugPrint('Image size: ${bytes.length} bytes');
    } catch (e) {
      debugPrint('Image picker error: $e');

      showMessage('Error selecting image: $e');
    }
  }

  Future<void> uploadImage() async {
    if (_selectedImage == null) {
      showMessage('Please select an image first');
      return;
    }

    if (_imageBytes == null) {
      showMessage('Image data is not available');
      return;
    }

    if (_isUploading) {
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final Uri uploadUrl = Uri.parse(
        'https://api.cloudinary.com/v1_1/'
        '$cloudName/image/upload',
      );

      debugPrint('Cloudinary URL: $uploadUrl');

      debugPrint('Cloud Name: $cloudName');

      debugPrint('Upload Preset: $uploadPreset');
      final http.MultipartRequest request = http.MultipartRequest(
        'POST',
        uploadUrl,
      );

      request.fields['upload_preset'] = uploadPreset;
      request.files.add(
        http.MultipartFile.fromBytes(
          'file',
          _imageBytes!,
          filename: _selectedImage!.name,
        ),
      );

      debugPrint('Uploading image...');
      final http.StreamedResponse response = await request.send();
      final String responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(responseBody);

        final String? imageUrl = data['secure_url'];

        if (imageUrl == null || imageUrl.isEmpty) {
          showMessage('Upload succeeded but image URL was not returned.');
          return;
        }

        if (!mounted) return;

        setState(() {
          _uploadedImageUrl = imageUrl;
        });

        showMessage('Image uploaded successfully!');

        debugPrint('Uploaded Image URL:');

        debugPrint(imageUrl);
      } else {
        String errorMessage = 'Upload failed (${response.statusCode})';

        try {
          final Map<String, dynamic> errorData = jsonDecode(responseBody);

          final dynamic message = errorData['error']?['message'];

          if (message != null) {
            errorMessage = message.toString();
          }
        } catch (e) {
          debugPrint('Could not parse Cloudinary error: $e');
        }

        debugPrint('Cloudinary Error: $errorMessage');

        showMessage(errorMessage);
      }
    } catch (e) {
      debugPrint('Cloudinary upload exception: $e');

      showMessage('Upload error: $e');
    } finally {
      if (!mounted) return;

      setState(() {
        _isUploading = false;
      });
    }
  }

  void showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message), behavior: SnackBarBehavior.floating),
      );
  }

  void clearImage() {
    setState(() {
      _selectedImage = null;
      _imageBytes = null;
      _uploadedImageUrl = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloudinary Image Upload'),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,

          children: [
            Container(
              height: 300,

              decoration: BoxDecoration(
                color: Colors.grey.shade200,

                borderRadius: BorderRadius.circular(20),

                border: Border.all(color: Colors.grey.shade300),
              ),

              child: _imageBytes != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(20),

                      child: Image.memory(
                        _imageBytes!,

                        width: double.infinity,
                        height: double.infinity,

                        fit: BoxFit.cover,
                      ),
                    )
                  : const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Icon(
                            Icons.cloud_upload_outlined,
                            size: 70,
                            color: Colors.grey,
                          ),

                          SizedBox(height: 10),

                          Text(
                            'No image selected',
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              height: 55,

              child: ElevatedButton.icon(
                onPressed: _isUploading ? null : pickImage,

                icon: const Icon(Icons.photo_library),

                label: const Text(
                  'Select Image',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 12),
            if (_selectedImage != null)
              SizedBox(
                height: 50,

                child: OutlinedButton.icon(
                  onPressed: _isUploading ? null : clearImage,

                  icon: const Icon(Icons.delete_outline),

                  label: const Text('Clear Image'),
                ),
              ),

            if (_selectedImage != null) const SizedBox(height: 12),
            SizedBox(
              height: 55,

              child: ElevatedButton.icon(
                onPressed: _isUploading ? null : uploadImage,

                icon: _isUploading
                    ? const SizedBox(
                        width: 22,
                        height: 22,

                        child: CircularProgressIndicator(
                          strokeWidth: 2,

                          color: Colors.white,
                        ),
                      )
                    : const Icon(Icons.cloud_upload),

                label: Text(
                  _isUploading ? 'Uploading...' : 'Upload to Cloudinary',

                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 30),
            if (_uploadedImageUrl != null) ...[
              const Divider(),

              const SizedBox(height: 20),

              const Text(
                'Uploaded Image',

                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              ClipRRect(
                borderRadius: BorderRadius.circular(20),

                child: Image.network(
                  _uploadedImageUrl!,

                  width: double.infinity,
                  height: 300,

                  fit: BoxFit.cover,

                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 300,

                      color: Colors.grey.shade200,

                      child: const Center(
                        child: Text('Unable to load uploaded image'),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                'Cloudinary URL',

                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: Colors.grey.shade100,

                  borderRadius: BorderRadius.circular(10),
                ),

                child: SelectableText(
                  _uploadedImageUrl!,

                  style: const TextStyle(color: Colors.blue, fontSize: 13),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
