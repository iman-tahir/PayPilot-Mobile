import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../dashboard/main_shell.dart';
import 'register_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passCtrl = TextEditingController();
  bool _obscure = true;

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const MainShell()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // ── Top navy header — matches HTML #0d2b6e panel ──
          Container(
            height: MediaQuery.of(context).size.height * 0.32,
            width: double.infinity,
            decoration: const BoxDecoration(color: kPrimaryDark),
            child: SafeArea(
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                // Logo pill
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: Colors.white24),
                  ),
                  child: const Text('🏦', style: TextStyle(fontSize: 36)),
                ),
                const SizedBox(height: 14),
                RichText(text: const TextSpan(
                  text: 'Pay',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: Colors.white, fontFamily: 'Poppins'),
                  children: [TextSpan(text: 'Pilot', style: TextStyle(color: kPrimary))],
                )),
                const SizedBox(height: 6),
                const Text('DIGITAL PAYMENTS FOR EVERYONE',
                  style: TextStyle(fontSize: 10, color: Colors.white54, letterSpacing: 1.5, fontFamily: 'Poppins')),
                const SizedBox(height: 16),
                // Stats row — mirrors HTML #box
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  _StatPill(label: 'Uptime', value: '99.9%'),
                  const SizedBox(width: 16),
                  _StatPill(label: 'Encrypted', value: '256-Bit'),
                  const SizedBox(width: 16),
                  _StatPill(label: 'Available', value: '24/7'),
                ]),
              ]),
            ),
          ),
          // ── White form card ──
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(28),
                child: Form(
                  key: _formKey,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    // Secure Login badge — matches HTML .launching pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                      decoration: BoxDecoration(
                        color: kUnread,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: kPrimary.withOpacity(0.18)),
                      ),
                      child: const Text('🔒 Secure Login',
                        style: TextStyle(color: kPrimary, fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 1, fontFamily: 'Poppins')),
                    ),
                    const SizedBox(height: 12),
                    const Text('Welcome Back', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: kText, fontFamily: 'Poppins')),
                    const SizedBox(height: 4),
                    const Text('Log into your PayPilot account', style: TextStyle(color: kTextGrey, fontFamily: 'Poppins')),
                    const SizedBox(height: 28),
                    TextFormField(
                      controller: _emailCtrl,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(labelText: 'Email Address', hintText: 'ali.hassan@gmail.com', prefixIcon: Icon(Icons.email_outlined, color: kPrimary)),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please enter your email address';
                        if (!v.contains('@')) return 'Please enter a valid email address';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _passCtrl,
                      obscureText: _obscure,
                      decoration: InputDecoration(
                        labelText: 'Password', hintText: '••••••••',
                        prefixIcon: const Icon(Icons.lock_outline, color: kPrimary),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: kTextGrey),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Please enter your password';
                        if (v.length < 6) return 'Password must be at least 6 characters';
                        return null;
                      },
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordScreen())),
                        child: const Text('Forgot Password?', style: TextStyle(color: kPrimary, fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton(onPressed: _submit, child: const Text('Log In to PayPilot →')),
                    const SizedBox(height: 24),
                    Row(children: const [
                      Expanded(child: Divider()),
                      Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Text('OR', style: TextStyle(color: kTextGrey, fontFamily: 'Poppins', fontSize: 12))),
                      Expanded(child: Divider()),
                    ]),
                    const SizedBox(height: 16),
                    Center(child: GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())),
                      child: const Text.rich(TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(color: kTextGrey, fontFamily: 'Poppins'),
                        children: [TextSpan(text: 'Sign Up', style: TextStyle(color: kPrimary, fontWeight: FontWeight.w700))],
                      )),
                    )),
                  ]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _StatPill extends StatelessWidget {
  final String label, value;
  const _StatPill({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: const TextStyle(color: Color(0xFFFF6B4A), fontWeight: FontWeight.w800, fontSize: 16, fontFamily: 'Poppins')),
    Text(label, style: const TextStyle(color: Colors.white60, fontSize: 10, fontFamily: 'Poppins')),
  ]);
}
