import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo_ji/service/cloudinary_service.dart';

class CloudinaryProvider extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();

  late final CloudinaryService _cloudinaryService;

  CloudinaryProvider() {
    _cloudinaryService = CloudinaryService(
      cloudName: 'dglxnraim',
      uploadPreset: 'flutter_coffee_test',
    );
  }

  XFile? _selectedImage;

  Uint8List? _imageBytes;

  String? _uploadedImageUrl;

  bool _isUploading = false;

  String? _errorMessage;

  String? _successMessage;

  XFile? get selectedImage => _selectedImage;

  Uint8List? get imageBytes => _imageBytes;

  String? get uploadedImageUrl => _uploadedImageUrl;

  bool get isUploading => _isUploading;

  String? get errorMessage => _errorMessage;

  String? get successMessage => _successMessage;

  bool get hasImage => _selectedImage != null;

  Future<void> pickImage() async {
    try {
      _clearMessages();

      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (image == null) {
        return;
      }

      final Uint8List bytes = await image.readAsBytes();

      _selectedImage = image;
      _imageBytes = bytes;
      _uploadedImageUrl = null;

      notifyListeners();

      debugPrint('Selected image: ${image.name}');
      debugPrint('Image size: ${bytes.length} bytes');
    } catch (e) {
      _errorMessage = 'Error selecting image: $e';

      notifyListeners();

      debugPrint('Image picker error: $e');
    }
  }

  Future<void> uploadImage() async {
    if (_selectedImage == null) {
      _errorMessage = 'Please select an image first';
      notifyListeners();
      return;
    }

    if (_imageBytes == null) {
      _errorMessage = 'Image data is not available';
      notifyListeners();
      return;
    }

    if (_isUploading) {
      return;
    }

    _isUploading = true;
    _clearMessages();

    notifyListeners();

    try {
      debugPrint('Uploading image...');

      final String imageUrl = await _cloudinaryService.uploadImage(
        imageBytes: _imageBytes!,
        fileName: _selectedImage!.name,
      );

      _uploadedImageUrl = imageUrl;

      _successMessage = 'Image uploaded successfully!';

      debugPrint('Uploaded Image URL:');
      debugPrint(imageUrl);
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');

      debugPrint('Cloudinary upload exception: $e');
    } finally {
      _isUploading = false;

      notifyListeners();
    }
  }

  // -----------------------------
  // Clear Image
  // -----------------------------

  void clearImage() {
    _selectedImage = null;
    _imageBytes = null;
    _uploadedImageUrl = null;

    _clearMessages();

    notifyListeners();
  }

  // -----------------------------
  // Clear Messages
  // -----------------------------

  void _clearMessages() {
    _errorMessage = null;
    _successMessage = null;
  }

  void clearMessage() {
    _clearMessages();
    notifyListeners();
  }
}
