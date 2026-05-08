import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _ctrl = PageController();
  int _currentPage = 0;

  final _slides = [
    {'icon': Icons.phone_android, 'emoji': '📱',
     'title': 'Welcome to PayPilot',
     'body': "Pakistan's fastest peer-to-peer payment platform. Move money in seconds."},
    {'icon': Icons.swap_horiz,    'emoji': '💸',
     'title': 'Send Money Instantly',
     'body': 'Transfer funds to any PayPilot user using just their phone number or email.'},
    {'icon': Icons.security,      'emoji': '🔒',
     'title': 'Bank-Level Security',
     'body': 'Your money is protected with end-to-end encryption and two-factor authentication.'},
  ];

  void _goNext() {
    if (_currentPage < 2) {
      _ctrl.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.ease);
    } else {
      _goToLogin();
    }
  }

  void _goToLogin() => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _goToLogin,
                child: const Text('Skip', style: TextStyle(color: kTextGrey, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _ctrl,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: 3,
                itemBuilder: (_, i) => _SlideWidget(slide: _slides[i]),
              ),
            ),
            // Dots
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _currentPage == i ? 24 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _currentPage == i ? kPrimary : const Color(0xFFCDD5E0),
                  borderRadius: BorderRadius.circular(4),
                ),
              )),
            ),
            const SizedBox(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: ElevatedButton(
                onPressed: _goNext,
                child: Text(_currentPage == 2 ? 'Get Started' : 'Next →'),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _SlideWidget extends StatelessWidget {
  final Map<String, dynamic> slide;
  const _SlideWidget({required this.slide});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160, height: 160,
            decoration: BoxDecoration(color: kPrimary.withOpacity(0.1), shape: BoxShape.circle),
            child: Center(child: Icon(slide['icon'] as IconData, size: 80, color: kPrimary)),
          ),
          const SizedBox(height: 48),
          Text(slide['title']!, textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: kText, fontFamily: 'Poppins')),
          const SizedBox(height: 16),
          Text(slide['body']!, textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: kTextGrey, fontFamily: 'Poppins', height: 1.6)),
        ],
      ),
    );
  }
}
