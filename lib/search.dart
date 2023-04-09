import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/item_data.dart';
import '../models/shop_data.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    List<Item> items = Provider.of<ShopData>(context).getShopItems();

    //For searching
    List<Item> filteredItems = items
        .where((i) =>
            i.name.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchText = '';
                    });
                  },
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchText = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                Item i = filteredItems[index];
                return ListTile(
                  title: Text(
                    i.name,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0E2433),
                    ),
                  ),
                  subtitle: Text('\$${i.price}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
