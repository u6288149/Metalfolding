import 'package:flutter/material.dart';

import '../models/item_data.dart';

class ItemsTile extends StatelessWidget {
  final Item i;
  final Function()? onPressed;
  const ItemsTile({
    super.key,
    required this.i,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 48),
      decoration: BoxDecoration(
        color: Color(0xFFB4CFEC),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // image of ice cream
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Image.asset(
              i.imagePath,
              height: 280,
            ),
          ),

          const SizedBox(height: 24),

          Column(
            children: [
              // name
              Text(
                i.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: const Color(0xFF0E2433),
                ),
              ),

              const SizedBox(height: 10),

              // price
              Text(
                '฿${i.price}',
                style: const TextStyle(
                  color: Color(0xFF0E2433),
                  fontSize: 16,
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // add button
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: const Color(0xFF528AAE),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: onPressed,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
