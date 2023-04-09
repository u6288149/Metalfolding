import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:metalfolding/shop.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'home.dart';
import 'mainpage.dart';
import 'models/shop_data.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ShopData()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MainPage(),
      ),
    );
  }
}