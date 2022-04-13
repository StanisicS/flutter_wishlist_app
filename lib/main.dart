import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:firebase_core/firebase_core.dart';

import 'services/local_storage_service.dart';
import 'widgets/auth_widget.dart';
import 'widgets/error_widget.dart';
import 'widgets/loading_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark));

  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();

  runApp(
    ProviderScope(
      overrides: [
        sharedPrefsProvider.overrideWithValue(sharedPreferences),
      ],
      child: const MyApp(),
    ),
  );
}

final firebaseinitializerProvider = FutureProvider<FirebaseApp>((ref) async {
  return await Firebase.initializeApp();
});

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initialize = ref.watch(firebaseinitializerProvider);
    return MaterialApp(
      title: 'RareList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData().copyWith(
        colorScheme:
            ThemeData().colorScheme.copyWith(primary: Colors.brown.shade800),
        errorColor: const Color.fromARGB(255, 134, 23, 134),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.grey.shade700,
              displayColor: Colors.grey.shade700,
            ),
      ),
      home: initialize.when(
          data: (data) {
            return const AuthWidget();
          },
          loading: () => const LoadingWidget(),
          error: (e, stackTrace) => RareErrorWidget(e, stackTrace)),
    );
  }
}
