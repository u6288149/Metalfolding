import 'package:flutter/material.dart';
import 'item_data.dart';

class ShopData extends ChangeNotifier {
  // list of items for sale
  final List<Item> _shop = [
    // Scaffolding
    Item(
      name: "Scaffolding",
      imagePath: 'assets/scaffolding.jpg',
      price: "1830",
    ),

    // Scaffolding Ladder
    Item(
      name: "Scaffolding Ladder",
      imagePath: 'assets/scaffolding_ladder.jpg',
      price: "2880",
    ),

    // Metal form
    Item(
      name: "Metal form",
      imagePath: 'assets/metal_form.jpg',
      price: "400",
    ),

    // U-head
    Item(
      name: "U-head",
      imagePath: 'assets/u_head.jpg',
      price: "180",
    ),

    // J-base
    Item(
      name: "J-base",
      imagePath: 'assets/j_base.jpg',
      price: "180",
    ),

    // Metal L shape column formwork
    Item(
      name: "Metal L shape column formwork",
      imagePath: 'assets/metal_l.jpg',
      price: "3150",
    ),
  ];

  // get items for sale
  List<Item> getShopItems() {
    return _shop;
  }

  // list of items in user cart
  final List<Item> _userCart = [];

  // get items in user cart
  List<Item> getUserCart() {
    return _userCart;
  }

  // add item to cart
  void addItemToCart(Item i) {
    _userCart.add(i);
    notifyListeners();
  }

  // delete item from cart
  void removeItemFromCart(Item i) {
    _userCart.remove(i);
    notifyListeners();
  }
}
