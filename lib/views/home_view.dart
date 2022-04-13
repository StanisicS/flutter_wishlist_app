import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../helpers.dart';
import '../services/wishlist_service.dart';
import '../widgets/title_widget.dart';
import '../widgets/wishlist_item_widget.dart';

class HomeView extends StatefulHookConsumerWidget {
  static const routeName = '/home';
  const HomeView({Key? key}) : super(key: key);
  static Route<HomeView> route() {
    return MaterialPageRoute<HomeView>(
      settings: const RouteSettings(name: routeName),
      builder: (BuildContext context) => const HomeView(),
    );
  }

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomeView> {
  @override
  Widget build(BuildContext context) {
    final items = ref.watch(wishlistProvider).data;
    final newItemController = useTextEditingController();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            const TitleWidget(),
            const SizedBox(height: 10),
            TextField(
              key: addItemKey,
              controller: newItemController,
              decoration: InputDecoration(
                labelText: 'Need something rare to remember?',
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                      style: BorderStyle.solid, color: Colors.brown.shade800),
                ),
              ),
              onSubmitted: (value) {
                ref.read(wishlistProvider.notifier).add(value);
                newItemController.clear();
              },
            ),
            const SizedBox(height: 34),
            if (items.isNotEmpty) const Divider(height: 0),
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              Dismissible(
                key: ValueKey(items[i].id),
                onDismissed: (_) {
                  ref.read(wishlistProvider.notifier).remove(items[i]);
                },
                child: ProviderScope(
                  overrides: [
                    itemProvider.overrideWithValue(items[i]),
                  ],
                  child: const WishlistItemWidget(),
                ),
              )
            ],
          ],
        ),
      ),
    );
  }
}
