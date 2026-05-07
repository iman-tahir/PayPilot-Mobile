import 'package:flutter/material.dart';
import 'utils/constants.dart';
import 'screens/auth/splash_screen.dart';

void main() => runApp(const PayPilotApp());

class PayPilotApp extends StatelessWidget {
  const PayPilotApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'PayPilot',
    debugShowCheckedModeBanner: false,
    theme: appTheme(),
    home: const SplashScreen(),
  );
}
