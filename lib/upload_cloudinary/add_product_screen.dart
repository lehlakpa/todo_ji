import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/upload_cloudinary/products_provider.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final priceController = TextEditingController();

  XFile? selectedImage;
  Uint8List? selectedImageBytes;

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (image == null) return;

    final Uint8List bytes = await image.readAsBytes();

    setState(() {
      selectedImage = image;
      selectedImageBytes = bytes;
    });
  }

  Future<void> addProduct() async {
    if (selectedImage == null) {
      showMessage('Please select an image');
      return;
    }

    if (titleController.text.trim().isEmpty) {
      showMessage('Please enter title');
      return;
    }

    if (descriptionController.text.trim().isEmpty) {
      showMessage('Please enter description');
      return;
    }

    if (priceController.text.trim().isEmpty) {
      showMessage('Please enter price');
      return;
    }

    final double? price = double.tryParse(priceController.text.trim());

    if (price == null) {
      showMessage('Please enter a valid price');
      return;
    }

    final provider = context.read<ProductProvider>();

    final success = await provider.addProduct(
      image: selectedImage!,
      title: titleController.text.trim(),
      description: descriptionController.text.trim(),
      price: price,
    );

    if (!mounted) return;

    if (success) {
      showMessage('Product added successfully');

      titleController.clear();
      descriptionController.clear();
      priceController.clear();

      setState(() {
        selectedImage = null;
        selectedImageBytes = null;
      });
    } else {
      showMessage(provider.error ?? 'Something went wrong');
    }
  }

  // ============================================================
  // SNACKBAR
  // ============================================================

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    priceController.dispose();

    super.dispose();
  }

  // ============================================================
  // UI
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Product')),

      body: Consumer<ProductProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                // ==================================================
                // IMAGE
                // ==================================================
                GestureDetector(
                  onTap: provider.isLoading ? null : pickImage,

                  child: Container(
                    height: 220,

                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),

                      border: Border.all(color: Colors.grey),
                    ),

                    child: selectedImageBytes == null
                        // EMPTY IMAGE
                        ? const Column(
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              Icon(Icons.cloud_upload_outlined, size: 50),

                              SizedBox(height: 10),

                              Text('Select Product Image'),
                            ],
                          )
                        // SELECTED IMAGE
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(16),

                            child: Image.memory(
                              selectedImageBytes!,

                              width: double.infinity,

                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),

                // ==================================================
                // TITLE
                // ==================================================
                TextField(
                  controller: titleController,

                  decoration: const InputDecoration(
                    labelText: 'Title',

                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // ==================================================
                // DESCRIPTION
                // ==================================================
                TextField(
                  controller: descriptionController,

                  maxLines: 4,

                  decoration: const InputDecoration(
                    labelText: 'Description',

                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 15),

                // ==================================================
                // PRICE
                // ==================================================
                TextField(
                  controller: priceController,

                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),

                  decoration: const InputDecoration(
                    labelText: 'Price',

                    prefixText: 'Rs. ',

                    border: OutlineInputBorder(),
                  ),
                ),

                const SizedBox(height: 25),

                // ==================================================
                // ADD PRODUCT BUTTON
                // ==================================================
                SizedBox(
                  height: 55,

                  child: ElevatedButton(
                    onPressed: provider.isLoading ? null : addProduct,

                    child: provider.isLoading
                        ? const SizedBox(
                            height: 25,
                            width: 25,

                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Upload & Add Product'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
