import 'package:flutter/material.dart';
import 'package:new_bloc_clean_app/core/theme/app_pallete.dart';
import 'package:new_bloc_clean_app/features/auth/presentation/pages/signup_page.dart';
import 'package:new_bloc_clean_app/features/auth/presentation/widgets/auth_field.dart';
import 'package:new_bloc_clean_app/features/auth/presentation/widgets/auth_gradient_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    emailController.dispose();

    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Login",
              style: TextStyle(fontSize: 38),
            ),
            const SizedBox(
              height: 30,
            ),
            AuthField(
              controller: emailController,
              hintText: "Email...",
            ),
            const SizedBox(
              height: 15,
            ),
            AuthField(
              controller: passwordController,
              hintText: "Password...",
              isObscureText: true,
            ),
            const SizedBox(
              height: 15,
            ),
            const AuthGradientButton(
              buttonString: "Login",
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignupPage()));
              },
              child: RichText(
                text: TextSpan(
                    children: [
                      TextSpan(
                          text: "Sign up",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(
                                  color: AppPallete.gradient1,
                                  fontWeight: FontWeight.bold))
                    ],
                    text: "Du hast noch keinen Account?  ",
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
