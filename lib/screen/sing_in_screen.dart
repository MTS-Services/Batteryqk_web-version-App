import 'dart:ui';
import 'package:batteryqk_web/screen/widget/background_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/model/logi_in_model.dart';
import '../data/service/api_service.dart';
import '../screen/widget/button_animation.dart';
import '../screen/widget/gradient_border_painter.dart';



class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return BackgroundWidget(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return SizedBox(
                height: h * 0.7,
                width: w * 0.4,
                child: CustomPaint(
                  painter: GradientBorderPainter(
                    animationValue: _controller.value,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white.withAlpha(230),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(26),
                          blurRadius: 20,
                          spreadRadius: 3,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 32,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Sign In",
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                            const SizedBox(height: 30),

                            // Email field
                            TextFormField(
                              controller: emailController,
                              style: const TextStyle(fontSize: 14),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your email';
                                }
                                if (!RegExp(
                                  r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                ).hasMatch(value)) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                labelText: "Email",
                                hintText: "Enter your email",
                                labelStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.email_outlined,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),

                            const SizedBox(height: 20),

                            // Password field
                            TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              style: const TextStyle(fontSize: 14),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[100],
                                labelText: "Password",
                                hintText: "Enter your password",
                                labelStyle: const TextStyle(color: Colors.grey),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(
                                  Icons.lock_outline,
                                  color: Colors.blueGrey,
                                ),
                              ),
                            ),

                            const SizedBox(height: 30),

                            // Sign In Button
                            AnimatedBuilder(
                              animation: _controller,
                              builder: (context, _) {
                                return CustomPaint(
                                  painter: AnimatedButtonBorderPainter(
                                    _controller.value,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.white,
                                        elevation: 0,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 40,
                                          vertical: 14,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          UserLogin userLogin = UserLogin(
                                            email: emailController.text.trim(),
                                            password: passwordController.text,
                                          );
                                          ApiService.userLogIn(userLogin);
                                        }
                                      },
                                      child: const Text(
                                        "Sign In",
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
