import 'package:flutter/material.dart';
import 'package:flutter_wishlist_app/helpers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/auth_service.dart';

class ProfileView extends StatefulHookConsumerWidget {
  static const routeName = '/profile';
  const ProfileView({Key? key}) : super(key: key);
  static Route<ProfileView> route() {
    return MaterialPageRoute<ProfileView>(
      settings: const RouteSettings(name: routeName),
      builder: (BuildContext context) => const ProfileView(),
    );
  }

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends ConsumerState<ProfileView> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(fireBaseAuthProvider);
    final auth = ref.watch(authenticationProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: CircleAvatar(
                minRadius: 24,
                backgroundColor: appColor,
                child: const Icon(
                  Icons.person,
                  size: 24,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(data.currentUser!.email ?? 'You are logged In'),
            ),
            Container(
              padding: const EdgeInsets.only(top: 40),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              child: MaterialButton(
                onPressed: () => auth.signOut(),
                child: const Text(
                  'Log Out',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                textColor: appColor,
                textTheme: ButtonTextTheme.primary,
                color: Colors.white,
                minWidth: 100,
                padding: const EdgeInsets.all(18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                  side: BorderSide(color: appColor),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            )
          ],
        ),
      ),
    );
  }
}
