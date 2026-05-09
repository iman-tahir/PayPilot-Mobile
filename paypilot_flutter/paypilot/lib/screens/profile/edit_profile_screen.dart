import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/dummy_data.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameCtrl;
  late final TextEditingController _phoneCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _cnicCtrl;

  @override
  void initState() {
    super.initState();
    _nameCtrl  = TextEditingController(text: currentUser.name);
    _phoneCtrl = TextEditingController(text: currentUser.phone);
    _emailCtrl = TextEditingController(text: currentUser.email);
    _cnicCtrl  = TextEditingController(text: currentUser.cnic);
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile updated successfully!'), backgroundColor: kSuccess));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [TextButton(
          onPressed: _save,
          child: const Text('Save', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: 'Poppins', fontSize: 16)),
        )],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(children: [
            // Avatar
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 52, backgroundColor: kPrimary,
                  child: Text(currentUser.initials,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, fontFamily: 'Poppins')),
                ),
                GestureDetector(
                  onTap: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Photo upload coming soon!'))),
                  child: Container(
                    width: 36, height: 36,
                    decoration: BoxDecoration(color: kPrimary, shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2)),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 18),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),

            // Editable fields
            _fieldLabel('Full Name'),
            TextFormField(
              controller: _nameCtrl,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.person_outline, color: kPrimary)),
              validator: (v) => (v == null || v.isEmpty) ? 'Name is required' : null,
            ),
            const SizedBox(height: 16),

            _fieldLabel('Phone Number'),
            TextFormField(
              controller: _phoneCtrl,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(prefixIcon: Icon(Icons.phone_outlined, color: kPrimary)),
              validator: (v) => (v == null || v.isEmpty) ? 'Phone is required' : null,
            ),
            const SizedBox(height: 16),

            // Disabled fields
            _fieldLabel('Email Address'),
            TextFormField(
              controller: _emailCtrl,
              enabled: false,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined, color: kTextGrey),
                filled: true, fillColor: const Color(0xFFF5F7FA),
                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFDDE3EE))),
              ),
            ),
            const SizedBox(height: 16),

            _fieldLabel('CNIC'),
            TextFormField(
              controller: _cnicCtrl,
              enabled: false,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.credit_card, color: kTextGrey),
                filled: true, fillColor: const Color(0xFFF5F7FA),
                disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Color(0xFFDDE3EE))),
              ),
            ),
            const SizedBox(height: 8),
            const Text('Email and CNIC cannot be changed. Contact support.',
              style: TextStyle(color: kTextGrey, fontSize: 12, fontStyle: FontStyle.italic, fontFamily: 'Poppins')),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: _save, child: const Text('Save Changes')),
            const SizedBox(height: 16),
          ]),
        ),
      ),
    );
  }

  Widget _fieldLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Align(
      alignment: Alignment.centerLeft,
      child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: kText, fontFamily: 'Poppins')),
    ),
  );
}
