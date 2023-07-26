import 'package:flutter/material.dart';
import 'package:food_delivary/view/pages/cart/cart_page.dart';
import 'package:food_delivary/view/pages/cart/history_page.dart';
import 'package:food_delivary/view/pages/home/main_food_page.dart';
import 'package:food_delivary/utils/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedPage = 0;
  List pages = [const MainFoodPage(), const HistoryPage(), const CartPage()];

  void onTapPressed(int index) {
    setState(() {
      _selectedPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedPage],
      bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: AppCourse.yelowColor,
          selectedItemColor: AppCourse.mainColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedFontSize: 0.0,
          unselectedFontSize: 0.0,
          onTap: onTapPressed,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_filled), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive), label: "history"),
            BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart), label: "cart"),
            // BottomNavigationBarItem(icon: Icon(Icons.person), label: "me"),
          ]),
    );
  }
}
