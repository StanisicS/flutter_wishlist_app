import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../services/auth_service.dart';
import '../views/login_view.dart';
import '../views/app_view.dart';
import 'error_widget.dart';
import 'loading_widget.dart';

class AuthWidget extends HookConsumerWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _authState = ref.watch(authStateProvider);
    return _authState.when(
        data: (data) {
          if (data != null) {
            return const AppView();
          }
          return const LoginView();
        },
        loading: () => const LoadingWidget(),
        error: (e, trace) => RareErrorWidget(e, trace));
  }
}
