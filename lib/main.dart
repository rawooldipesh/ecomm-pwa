import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ECommercePage(),
    );
  }
}

class ECommercePage extends StatefulWidget {
  const ECommercePage({super.key});

  @override
  State<ECommercePage> createState() => _ECommercePageState();
}

class _ECommercePageState extends State<ECommercePage> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Product 1', 'price': 10.0},
    {'name': 'Product 2', 'price': 15.0},
  ];

  final List<Map<String, dynamic>> cart = [];

  void addToCart(Map<String, dynamic> product) {
    setState(() {
      cart.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("E-commerce Store"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Products",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    child: ListTile(
                      title: Text(product['name']),
                      subtitle: Text("\$${product['price']}"),
                      trailing: ElevatedButton(
                        onPressed: () => addToCart(product),
                        child: const Text("Add to Cart"),
                      ),
                    ),
                  );
                },
              ),
            ),
            const Divider(height: 30),
            const Text(
              "Cart",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: cart.isEmpty
                  ? const Text("Cart is empty.")
                  : ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];
                        return ListTile(
                          title: Text(item['name']),
                          trailing: Text("\$${item['price']}"),
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}
