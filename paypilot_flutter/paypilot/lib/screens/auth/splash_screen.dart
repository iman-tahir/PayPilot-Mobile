import 'dart:async';
import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000));
    _opacity = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeIn));
    _ctrl.forward();
    Timer(const Duration(milliseconds: 5500), () {
      if (mounted) Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OnboardingScreen()));
    });
  }

  @override
  void dispose() { _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: kPrimaryDark),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 3),
              FadeTransition(
                opacity: _opacity,
                child: Column(
                  children: [
                    Container(
                      width: 120, height: 120,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
                      child: const Center(
                        child: Text('P', style: TextStyle(fontSize: 64, fontWeight: FontWeight.w900, color: kPrimary, fontFamily: 'Poppins')),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const Text('PayPilot', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800, color: Colors.white, fontFamily: 'Poppins')),
                    const SizedBox(height: 8),
                    const Text('Send money. Instantly.', style: TextStyle(fontSize: 16, color: Colors.white70, fontStyle: FontStyle.italic, fontFamily: 'Poppins')),
                  ],
                ),
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    backgroundColor: Colors.white30,
                    color: Colors.white,
                    minHeight: 3,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text('v1.0.0', style: TextStyle(color: Colors.white54, fontSize: 12, fontFamily: 'Poppins')),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
