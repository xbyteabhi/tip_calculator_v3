import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(TipCalcV3());
}

class TipCalcV3 extends StatelessWidget {
  const TipCalcV3({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Tip Calc V3",
      home: HomeScreen(),
    );
  }
}
