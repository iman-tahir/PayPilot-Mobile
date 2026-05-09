import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/dummy_data.dart';
import 'edit_profile_screen.dart';
import 'settings_screen.dart';
import '../auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _infoTile(IconData icon, String label, String value) => Column(children: [
    ListTile(
      leading: CircleAvatar(radius: 18, backgroundColor: kPrimary.withOpacity(0.12),
        child: Icon(icon, color: kPrimary, size: 18)),
      title: Text(label, style: const TextStyle(color: kTextGrey, fontSize: 12, fontFamily: 'Poppins')),
      subtitle: Text(value, style: const TextStyle(color: kText, fontWeight: FontWeight.w700, fontFamily: 'Poppins', fontSize: 14)),
    ),
    const Divider(height: 0, indent: 56),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [IconButton(
          icon: const Icon(Icons.edit_outlined),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
        )],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          // Header
          Container(
            width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 32),
            color: kPrimaryDark,
            child: Column(children: [
              CircleAvatar(
                radius: 44, backgroundColor: Colors.white,
                child: Text(currentUser.initials,
                  style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: kPrimary, fontFamily: 'Poppins')),
              ),
              const SizedBox(height: 14),
              Text(currentUser.name,
                style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800, fontFamily: 'Poppins')),
              const SizedBox(height: 4),
              Text(currentUser.email, style: const TextStyle(color: Colors.white70, fontSize: 13, fontFamily: 'Poppins')),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
                decoration: BoxDecoration(color: kSuccessLight, borderRadius: BorderRadius.circular(20)),
                child: const Text('✓ Verified', style: TextStyle(color: kSuccess, fontWeight: FontWeight.w700, fontSize: 12, fontFamily: 'Poppins')),
              ),
            ]),
          ),

          // Stats row
          Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(children: [
              _stat('Transactions', '8'),
              _divider(),
              _stat('Total Sent', 'PKR 10,700'),
              _divider(),
              _stat('Received', 'PKR 20,500'),
            ]),
          ),

          const SizedBox(height: 12),

          // Info card
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)]),
            child: Column(children: [
              _infoTile(Icons.phone_outlined, 'Phone Number', currentUser.phone),
              _infoTile(Icons.credit_card, 'CNIC', currentUser.cnic),
              _infoTile(Icons.calendar_today_outlined, 'Member Since', 'January 2026'),
              ListTile(
                leading: CircleAvatar(radius: 18, backgroundColor: kPrimary.withOpacity(0.12),
                  child: const Icon(Icons.verified_user_outlined, color: kPrimary, size: 18)),
                title: const Text('Account Level', style: TextStyle(color: kTextGrey, fontSize: 12, fontFamily: 'Poppins')),
                subtitle: const Text('Standard', style: TextStyle(color: kText, fontWeight: FontWeight.w700, fontFamily: 'Poppins', fontSize: 14)),
              ),
            ]),
          ),

          const SizedBox(height: 20),

          // Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(children: [
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const EditProfileScreen())),
                child: const Text('Edit Profile'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
                child: const Text('Settings'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(foregroundColor: kError, side: const BorderSide(color: kError)),
                onPressed: () => showDialog(context: context, builder: (_) => AlertDialog(
                  title: const Text('Log Out?', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w800)),
                  content: const Text('Are you sure you want to log out of PayPilot?', style: TextStyle(fontFamily: 'Poppins')),
                  actions: [
                    TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel', style: TextStyle(fontFamily: 'Poppins'))),
                    TextButton(
                      onPressed: () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (r) => false),
                      child: const Text('Log Out', style: TextStyle(color: kError, fontFamily: 'Poppins', fontWeight: FontWeight.w700)),
                    ),
                  ],
                )),
                child: const Text('Log Out'),
              ),
              const SizedBox(height: 24),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _stat(String label, String value) => Expanded(child: Column(children: [
    Text(value, style: const TextStyle(fontWeight: FontWeight.w800, color: kText, fontFamily: 'Poppins', fontSize: 14)),
    const SizedBox(height: 2),
    Text(label, style: const TextStyle(color: kTextGrey, fontSize: 11, fontFamily: 'Poppins')),
  ]));

  Widget _divider() => Container(width: 1, height: 36, color: const Color(0xFFE4E9F2));
}
