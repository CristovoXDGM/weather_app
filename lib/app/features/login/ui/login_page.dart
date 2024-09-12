import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:weatherapp/app/features/login/data/auth_service.dart';
import 'package:weatherapp/app/features/login/data/params/login_params.dart';
import 'package:weatherapp/app/shared/assets/assets_svgs.dart';
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
  final _formKey = GlobalKey<FormState>();
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
  void dispose() {
    authService.isAuthenticated.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sizer = MediaQuery.of(context).size;

    double responsiveWidth = 0;

    if (sizer.width < 600) {
      responsiveWidth = sizer.width;
    }
    if (sizer.width >= 600) {
      responsiveWidth = 600;
    }

    return Scaffold(
      backgroundColor: AppColors.dayLight,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
          PointerDeviceKind.touch,
          PointerDeviceKind.mouse,
        }),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    SvgPicture.asset(
                      AssetsSvgs.loginCloudsSvg,
                      height: 100,
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    SizedBox(
                      width: responsiveWidth,
                      child: CustomFormField(
                        controller: userNameController,
                        label: "User",
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: responsiveWidth,
                      child: CustomFormField(
                        controller: passwordController,
                        label: "Password",
                        hideText: true,
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    SizedBox(
                      width: responsiveWidth * 0.7,
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () async {
                          final validForm = _formKey.currentState?.validate() ?? false;

                          if (!validForm) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Something went wrong"),
                                  content: const Text(
                                    "Please check if User/Password is correct and not empty.",
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        context.pop();
                                      },
                                      child: const Text("Ok"),
                                    )
                                  ],
                                );
                              },
                            );

                            return;
                          }

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
                          } else if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text("Auth fail"),
                                  content: const Text(
                                    "Invalid User/Password",
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        context.pop();
                                        userNameController.clear();
                                        passwordController.clear();
                                      },
                                      child: const Text("Ok"),
                                    )
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: const Text("Log In"),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
