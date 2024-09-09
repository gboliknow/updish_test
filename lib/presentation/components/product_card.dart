import 'package:flutter/material.dart';
import 'package:updish_test/presentation/model/product.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Image.network(
            product.imgUrl,
            height: 170,
            width: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.title,
                    maxLines: 1,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    )),
                const SizedBox(height: 4),
                Text(
                  "₦${product.price}",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green),
                ),
                Row(
                  children: [
                    Text(
                      "₦${product.oldPrice}",
                      style: const TextStyle(fontSize: 12, decoration: TextDecoration.lineThrough),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "-${calculatePercentageDecrease(product.oldPrice, product.price).toStringAsFixed(2)}%",
                      style: const TextStyle(fontSize: 14, color: Colors.orange),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                    ),
                    onPressed: () {},
                    child: const Text('ADD TO CART', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

double calculatePercentageDecrease(double oldPrice, double newPrice) {
  return ((oldPrice - newPrice) / oldPrice) * 100;
}
