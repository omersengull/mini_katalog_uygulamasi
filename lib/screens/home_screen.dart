import 'package:flutter/material.dart';
import '../models/product.dart';
import 'detail_screen.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> cartItems = [];
  List<Product> filteredProducts = [];
 @override
void initState() {
  super.initState();
  // Uygulama ilk açıldığında her şeyi göster
  filteredProducts = products; 
}

  void filterProducts(String query) {
    setState(() {
      filteredProducts = products
          .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void addToCart(Product product) {
    setState(() {
      cartItems.add(product);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${product.title} sepete eklendi!"),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  final List<Product> products = [
    Product(
      id: 1,
      title: "AirPods Pro (2nd Gen)",
      price: 249.0,
      description: "Adaptive Audio. Now with USB-C.",
      image: "https://picsum.photos/400/400?random=1",
    ),
    Product(
      id: 2,
      title: "AirPods Max",
      price: 549.0,
      description: "Sound focused. High-fidelity audio.",
      image: "https://picsum.photos/400/400?random=2",
    ),
    Product(
      id: 3,
      title: "HomePod",
      price: 299.0,
      description: "Profound sound. Intelligence at home.",
      image: "https://picsum.photos/400/400?random=3",
    ),
    Product(
      id: 4,
      title: "HomePod Mini",
      price: 99.0,
      description: "Color pop. Jam-packed with innovation.",
      image: "https://picsum.photos/400/400?random=4",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            backgroundColor: const Color(0xFFF5F5F7),
            title: const Text(
              "Discover",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(items: cartItems),
                    ),
                  );
                },
                icon: Badge(
                  label: Text(cartItems.length.toString()),
                  isLabelVisible: cartItems.isNotEmpty,
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Find your perfect device.",
                    style: TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child:  TextField(
                      onChanged: (value) => filterProducts(
                        value,
                      ), // Her harf yazıldığında filtreler
                      decoration: InputDecoration(
                        icon: Icon(Icons.search, color: Colors.grey),
                        hintText: "Search products",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio:
                    0.7, 
              ),
              delegate: SliverChildBuilderDelegate((context, index) {
                final product = filteredProducts[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailScreen(
                        product: product,
                        onAddToCart: () => addToCart(product),
                      ),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Hero(
                            tag: product.id,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                              ),
                              child: Image.network(
                                product.image,
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 1,
                              ),
                              Text(
                                product.description,
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 11,
                                ),
                                maxLines: 1,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                "\$${product.price}",
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              ElevatedButton(
                                onPressed: () => addToCart(product),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 32),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                child: const Text(
                                  "Add to Cart",
                                  style: TextStyle(fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }, childCount: filteredProducts.length),
            ),
          ),
        ],
      ),
    );
  }
}
