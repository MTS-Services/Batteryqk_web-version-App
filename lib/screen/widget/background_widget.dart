import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Widget child; // <- child parameter

  const BackgroundWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Container(
              height: 500,
              width: 500,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(5),
                image: const DecorationImage(
                  image: AssetImage("asset/images/background.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
