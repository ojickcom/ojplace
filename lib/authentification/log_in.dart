import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ojplace/authentification/authentication_repo.dart';
import 'package:ojplace/authentification/login_view_model.dart';

class LogIn extends ConsumerWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextEditingController idController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final isLoggedIn = ref.watch(loggedInStateProvider);
    // final loginViewModel = ref.read(loginProvider);
    return Scaffold(
      appBar: AppBar(
          title: isLoggedIn.when(
              data: (isLoggedIn) =>
                  isLoggedIn ? const Text("로그인 되었음.") : const Text("로그인"),
              error: (error, _) => Text('Error: $error'),
              loading: () => const CircularProgressIndicator())

          // ? const Text("로그인 되었음.")
          ), // : const Text("로그인")),
      body: Center(
        child: SizedBox(
          width: 500,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: idController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "password"),
                obscureText: true,
              ),
              const SizedBox(height: 40.0),
              ButtonTheme(
                child: ElevatedButton(
                  onPressed: () async {
                    final email = idController.text;
                    final password = passwordController.text;

                    try {
                      await ref
                          .read(loginProvider.notifier)
                          .login(email, password, context);
                      print("로그인 성공");
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text("로그인 성공"),
                          content: const Text("환영합니다!"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text("확인"),
                            ),
                          ],
                        ),
                      );
                    } catch (e) {
                      print("$e");
                    }
                  },
                  child: const Text("로그인"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
