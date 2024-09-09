import 'package:flutter/material.dart';
import 'package:updish_test/presentation/components/product_card.dart';
import 'package:updish_test/presentation/model/product.dart';

class ProductCatalogue extends StatefulWidget {
  const ProductCatalogue({
    super.key,
  });

  @override
  State<ProductCatalogue> createState() => _ProductCatalogueState();
}

class _ProductCatalogueState extends State<ProductCatalogue> {
  final _scrollController = ScrollController();
  List<Product> products = [];
  bool isLoading = false;
  bool noMoreToFetch = false;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    products.addAll(myProducts.take(6));
    _scrollController.addListener(_fetchMoreProducts);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Column(
        children: [
          GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width < 600 ? 2 : 4,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.6),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              }),
          const SizedBox(
            height: 20,
          ),
          if (isLoading && !noMoreToFetch) const CircularProgressIndicator(),
          if (noMoreToFetch)
            const Text("No More to data to fetch",
                maxLines: 1,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                )),
          const SizedBox(
            height: 50,
          )
        ],
      ),
    );
  }

  Future<void> _fetchMoreProducts() async {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      if (products.length != myProducts.length) {
        setState(() {
          isLoading = true;
        });
        final nextProducts = myProducts.skip(currentIndex).take(6);
        await Future.delayed(const Duration(seconds: 2));
        setState(() {
          products.addAll(nextProducts);
          currentIndex += 6;
          isLoading = false;
        });
      } else {
        setState(() {
          noMoreToFetch = true;
        });
      }
    }
  }
}
