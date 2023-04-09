import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'components/item_tile.dart';
import 'models/item_data.dart';
import 'models/shop_data.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  //Page controller
  final _controller = PageController();

  //Add to cart
  void addToCart(Item i) {
    //Call add method
    Provider.of<ShopData>(context, listen: false).addItemToCart(i);

    // let user know it has been added
    Fluttertoast.showToast(msg: "Added to cart");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopData>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 25),

            // smooth dots
            Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: value.getShopItems().length,
                effect: ExpandingDotsEffect(
                  dotColor: const Color(0xFFB4CFEC),
                  activeDotColor: const Color(0xFF528AAE),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ice cream list
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: value.getShopItems().length,
                itemBuilder: (context, index) {
                  // get each ice cream
                  Item i = value.getShopItems()[index];
                  return ItemsTile(
                    i: i,
                    onPressed: () => addToCart(i),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}