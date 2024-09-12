import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/app/features/login/data/login_service.dart';
import 'package:weatherapp/app/features/login/data/params/login_params.dart';
import 'package:weatherapp/app/shared/constants/app_colors.dart';

import '../../../shared/widgets/custom_form_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final authService = AuthService();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      authService.getAuthStatus();

      authService.isAuthenticated.addListener(() {
        if (authService.isAuthenticated.value) {
          if (context.mounted) {
            context.go("/home");
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final sizer = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.sunny,
      body: SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                CustomFormField(
                  controller: userNameController,
                  label: "User",
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomFormField(
                  controller: passwordController,
                  label: "Password",
                  hideText: true,
                ),
                const SizedBox(
                  height: 80,
                ),
                SizedBox(
                  width: sizer.width * 0.7,
                  child: ElevatedButton(
                    onPressed: () async {
                      await authService.logInUser(
                        LoginParams(
                            userName: userNameController.text,
                            password: passwordController.text),
                      );
                      await authService.getAuthStatus();
                      if (authService.isAuthenticated.value) {
                        if (context.mounted) {
                          context.go("/home");
                        }
                      }
                    },
                    child: const Text("Log In"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
