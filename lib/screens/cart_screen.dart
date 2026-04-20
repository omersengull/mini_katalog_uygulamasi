import 'package:flutter/material.dart';
import '../models/product.dart';

class CartScreen extends StatelessWidget {
  final List<Product> items;
  const CartScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cart")),
      body: items.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text("Your cart is empty", style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network(items[index].image, width: 50, fit: BoxFit.cover),
                  title: Text(items[index].title),
                  subtitle: Text("\$${items[index].price}"),
                  trailing: const Icon(Icons.remove_circle_outline),
                );
              },
            ),
      bottomNavigationBar: items.isEmpty 
        ? null 
        : Container(
            padding: const EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black, padding: const EdgeInsets.all(15)),
              child: const Text("Checkout", style: TextStyle(color: Colors.white)),
            ),
          ),
    );
  }
}