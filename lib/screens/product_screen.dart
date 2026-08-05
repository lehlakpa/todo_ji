import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/models/product_model.dart';
import 'package:todo_ji/providers/product_service.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<ProductService>().fetchProducts();
    });
  }

  void _showProductDialog({ProductModel? product}) {
    final titleController = TextEditingController(text: product?.title ?? "");

    final priceController = TextEditingController(
      text: product?.price.toString() ?? "",
    );

    showDialog(
      context: context,
      builder: (_) {
        return Consumer<ProductService>(
          builder: (context, provider, child) {
            return AlertDialog(
              title: Text(product == null ? "Add Product" : "Update Product"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: "Product Name",
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: "Price"),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("Cancel"),
                ),
                ElevatedButton(
                  onPressed: provider.isLoading
                      ? null
                      : () async {
                          final newProduct = ProductModel(
                            id: product?.id ?? "",
                            title: titleController.text.trim(),
                            price: double.parse(priceController.text.trim()),
                          );

                          if (product == null) {
                            await provider.addProduct(newProduct);
                          } else {
                            await provider.updateProduct(newProduct);
                          }

                          if (mounted) Navigator.pop(context);
                        },
                  child: provider.isLoading
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(product == null ? "Add" : "Update"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Products")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showProductDialog();
        },
        child: const Icon(Icons.add),
      ),
      body: Consumer<ProductService>(
        builder: (context, provider, child) {
          if (provider.products.isEmpty) {
            return const Center(child: Text("No Products"));
          }

          return ListView.builder(
            itemCount: provider.products.length,
            itemBuilder: (context, index) {
              final product = provider.products[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: ListTile(
                  title: Text(product.title),
                  subtitle: Text("Rs. ${product.price}"),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          _showProductDialog(product: product);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await provider.DeleteProduct(product.id);
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
