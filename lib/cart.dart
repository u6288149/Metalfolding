import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item_data.dart';
import '../models/shop_data.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // remove from cart
  void removeFromCart(Item i) {
    Provider.of<ShopData>(context, listen: false).removeItemFromCart(i);
  }

  // pay now button tapped
  void payNow() {}

  @override
  Widget build(BuildContext context) {
    return Consumer<ShopData>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            // title
            Text(
              "My Cart",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0E2433),
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 50),

            // list of cart items

            value.getUserCart().isEmpty
                ? const Expanded(
                    child: Center(
                      child: Text(
                        'Cart is empty..',
                        style: TextStyle(color: Color(0xFF0E2433)),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemCount: value.getUserCart().length,
                      itemBuilder: (context, index) {
                        // get each ice cream in cart
                        Item i = value.getUserCart()[index];

                        // return list tile
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFB4CFEC),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          margin: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            leading: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Image.asset(i.imagePath),
                            ),
                            title: Text(
                              i.name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF0E2433),
                              ),
                            ),
                            subtitle: Text(
                              '\$${i.price}',
                              style: TextStyle(
                                color: Colors.grey.shade800,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => removeFromCart(i),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

            // pay button

            GestureDetector(
              onTap: payNow,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF528AAE),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(20),
                child: const Center(
                  child: Text(
                    "Pay Now",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
