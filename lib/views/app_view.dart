import 'package:flutter/material.dart';
import 'package:flutter_wishlist_app/views/home_view.dart';
import 'package:flutter_wishlist_app/widgets/bottom_navbar_widget.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helpers.dart';
import '../services/wishlist_service.dart';
import 'profile_view.dart';

class AppView extends StatefulHookConsumerWidget {
  const AppView({Key? key}) : super(key: key);
  static String routeName = '/';
  static Route<AppView> route() {
    return MaterialPageRoute<AppView>(
      settings: RouteSettings(name: routeName),
      builder: (BuildContext context) => const AppView(),
    );
  }

  @override
  MenuPageState createState() => MenuPageState();
}

class MenuPageState extends ConsumerState<AppView> {
  int _selectedIndex = 0;

  final List<Widget> tabs = const [
    HomeView(),
    ProfileView(),
  ];

  @override
  void initState() {
    Future.delayed(
        Duration.zero, () => ref.read(wishlistProvider.notifier).loadData());
    super.initState();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_selectedIndex],
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Clear All'),
        backgroundColor: appColor,
        foregroundColor: Colors.white,
        onPressed: () => ref.read(wishlistProvider.notifier).removeAll(),
      ),
      bottomNavigationBar: BottomNavBarWidget(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
