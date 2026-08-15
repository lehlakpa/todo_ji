import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_ji/upload_cloudinary/products_provider.dart';

class ProductData extends StatelessWidget {
  const ProductData({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("data")),
      body: StreamBuilder(
        stream: context.read<ProductProvider>().getProductsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          }
          final products = snapshot.data!;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return ListTile(
                leading: Image.network(product.imageUrl),
                title: Text(product.title),
                subtitle: Text(product.description),
                trailing: Text("\$${product.price.toStringAsFixed(2)}"),
              );
            },
          );
        },
      ),
    );
  }
}
