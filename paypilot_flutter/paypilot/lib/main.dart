import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'utils/constants.dart';
import 'screens/auth/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const PayPilotApp());
}

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