import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _submitted ? _successView() : _formView(),
      ),
    );
  }

  Widget _formView() => Form(
    key: _formKey,
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Icon(Icons.lock_reset, size: 80, color: kPrimary),
      const SizedBox(height: 24),
      const Text('Reset Your Password', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: kText, fontFamily: 'Poppins')),
      const SizedBox(height: 12),
      const Text('Enter your email address and we will send you a link to reset your password.',
        textAlign: TextAlign.center, style: TextStyle(color: kTextGrey, fontSize: 14, fontFamily: 'Poppins', height: 1.6)),
      const SizedBox(height: 32),
      TextFormField(
        controller: _emailCtrl,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(labelText: 'Email Address', hintText: 'Enter your email', prefixIcon: Icon(Icons.email_outlined, color: kPrimary)),
        validator: (v) {
          if (v == null || v.isEmpty) return 'Please enter your email';
          if (!v.contains('@')) return 'Enter a valid email address';
          return null;
        },
      ),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: () { if (_formKey.currentState!.validate()) setState(() => _submitted = true); },
        child: const Text('Send Reset Link'),
      ),
    ]),
  );

  Widget _successView() => Column(mainAxisAlignment: MainAxisAlignment.center, children: [
    const Icon(Icons.check_circle, size: 80, color: kPrimary),
    const SizedBox(height: 24),
    const Text('Check Your Email', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: kText, fontFamily: 'Poppins')),
    const SizedBox(height: 12),
    Text('We sent a reset link to ${_emailCtrl.text}',
      textAlign: TextAlign.center, style: const TextStyle(color: kTextGrey, fontFamily: 'Poppins', height: 1.6)),
    const SizedBox(height: 32),
    ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text('Back to Login')),
  ]);
}
