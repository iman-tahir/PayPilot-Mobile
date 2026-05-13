import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../dashboard/main_shell.dart';
import 'login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameCtrl  = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _cnicCtrl  = TextEditingController();
  final _passCtrl  = TextEditingController();
  final _confCtrl  = TextEditingController();
  bool _obscurePass = true,
      _obscureConf = true,
      _termsChecked = false,
      _termsError = false,
      _isLoading = false;
  Future<void> _submit() async {

    setState(() => _termsError = !_termsChecked);

    if (!_formKey.currentState!.validate() || !_termsChecked) return;

    setState(() => _isLoading = true);

    try {

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailCtrl.text.trim(),
        password: _passCtrl.text.trim(),
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MainShell()),
      );

    } on FirebaseAuthException catch (e) {

      String message = 'Signup failed';

      if (e.code == 'email-already-in-use') {
        message = 'Email already in use';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email';
      } else if (e.code == 'weak-password') {
        message = 'Weak password';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );

    } finally {

      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _field(String label, TextEditingController ctrl, {bool obscure = false, VoidCallback? toggleObscure, bool? showObscure, TextInputType? keyboard, String? Function(String?)? validator, Widget? prefix}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(label, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: kText, fontFamily: 'Poppins')),
      const SizedBox(height: 6),
      TextFormField(controller: ctrl, obscureText: obscure, keyboardType: keyboard,
        decoration: InputDecoration(
          prefixIcon: prefix,
          suffixIcon: toggleObscure != null ? IconButton(icon: Icon(showObscure! ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: kTextGrey), onPressed: toggleObscure) : null,
        ),
        validator: validator,
      ),
      const SizedBox(height: 16),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('Personal Information', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: kTextGrey, fontFamily: 'Poppins', letterSpacing: 1)),
            const SizedBox(height: 12),
            _field('Full Name', _nameCtrl, prefix: const Icon(Icons.person_outline, color: kPrimary),
              validator: (v) => (v == null || v.isEmpty) ? 'Full name is required' : null),
            _field('Email Address', _emailCtrl, keyboard: TextInputType.emailAddress, prefix: const Icon(Icons.email_outlined, color: kPrimary),
              validator: (v) { if (v == null || v.isEmpty) return 'Email is required'; if (!v.contains('@')) return 'Enter a valid email'; return null; }),
            _field('Phone Number', _phoneCtrl, keyboard: TextInputType.phone, prefix: const Icon(Icons.phone_outlined, color: kPrimary),
              validator: (v) {
                if (v == null || v.isEmpty) return 'Phone is required';
                if (!RegExp(r'^03[0-9]{9}$').hasMatch(v.replaceAll('-', ''))) return 'Enter a valid Pakistani phone number (03XX-XXXXXXX)';
                return null;
              }),
            _field('CNIC', _cnicCtrl, keyboard: TextInputType.number, prefix: const Icon(Icons.credit_card, color: kPrimary),
              validator: (v) {
                if (v == null || v.isEmpty) return 'CNIC is required';
                if (!RegExp(r'^[0-9]{13}$').hasMatch(v.replaceAll('-', ''))) return 'CNIC must be 13 digits';
                return null;
              }),
            const SizedBox(height: 8),
            const Text('Security', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: kTextGrey, fontFamily: 'Poppins', letterSpacing: 1)),
            const SizedBox(height: 12),
            _field('Password', _passCtrl, obscure: _obscurePass, showObscure: _obscurePass,
              toggleObscure: () => setState(() => _obscurePass = !_obscurePass),
              prefix: const Icon(Icons.lock_outline, color: kPrimary),
              validator: (v) => (v == null || v.length < 6) ? 'Password must be at least 6 characters' : null),
            _field('Confirm Password', _confCtrl, obscure: _obscureConf, showObscure: _obscureConf,
              toggleObscure: () => setState(() => _obscureConf = !_obscureConf),
              prefix: const Icon(Icons.lock_outline, color: kPrimary),
              validator: (v) => (v != _passCtrl.text) ? 'Passwords do not match' : null),
            CheckboxListTile(
              value: _termsChecked,
              activeColor: kPrimary,
              contentPadding: EdgeInsets.zero,
              title: const Text.rich(TextSpan(
                text: 'I agree to the ',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 13, color: kText),
                children: [TextSpan(text: 'Terms and Conditions', style: TextStyle(color: kPrimary, fontWeight: FontWeight.w700))],
              )),
              onChanged: (v) => setState(() { _termsChecked = v!; _termsError = false; }),
            ),
            if (_termsError) const Text('You must accept the terms to continue', style: TextStyle(color: kError, fontSize: 12, fontFamily: 'Poppins')),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
                  : const Text('Create Account'),
            ),
            const SizedBox(height: 16),
            Center(child: GestureDetector(
              onTap: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen())),
              child: const Text.rich(TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(color: kTextGrey, fontFamily: 'Poppins'),
                children: [TextSpan(text: 'Log In', style: TextStyle(color: kPrimary, fontWeight: FontWeight.w700))],
              )),
            )),
            const SizedBox(height: 24),
          ]),
        ),
      ),
    );
  }
}
