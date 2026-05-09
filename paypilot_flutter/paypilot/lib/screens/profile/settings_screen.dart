import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../auth/login_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pushNotif = true;
  bool _emailAlerts = true;
  bool _smsAlerts = false;
  bool _biometric = false;
  bool _twoFA = false;
  bool _darkMode = false;

  void _snack(String msg) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));

  Widget _sectionHeader(String title) => Padding(
    padding: const EdgeInsets.fromLTRB(16, 20, 16, 4),
    child: Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: kTextGrey, letterSpacing: 1.2, fontFamily: 'Poppins')),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        children: [
          // ── Notifications ──
          _sectionHeader('NOTIFICATIONS'),
          _switchTile(Icons.notifications_outlined, 'Push Notifications', 'Get alerted on transfers and activity', _pushNotif, (v) => setState(() => _pushNotif = v)),
          _switchTile(Icons.email_outlined, 'Email Alerts', 'Receive emails for important events', _emailAlerts, (v) => setState(() => _emailAlerts = v)),
          _switchTile(Icons.sms_outlined, 'SMS Alerts', 'Receive SMS for transactions', _smsAlerts, (v) => setState(() => _smsAlerts = v)),

          // ── Security ──
          _sectionHeader('SECURITY'),
          _switchTile(Icons.fingerprint, 'Biometric Login', 'Use fingerprint or face to log in', _biometric, (v) => setState(() => _biometric = v)),
          _switchTile(Icons.verified_user_outlined, 'Two-Factor Authentication', 'Extra layer of security for your account', _twoFA, (v) => setState(() => _twoFA = v)),
          _navTile(Icons.lock_outline, 'Change Password', () => _snack('Coming soon!')),
          _navTile(Icons.devices_outlined, 'Active Sessions', () => _snack('Coming soon!')),

          // ── Appearance ──
          _sectionHeader('APPEARANCE'),
          _switchTile(Icons.dark_mode_outlined, 'Dark Mode', 'Switch to dark theme (visual only)', _darkMode, (v) => setState(() => _darkMode = v)),

          // ── About ──
          _sectionHeader('ABOUT'),
          _navTile(Icons.privacy_tip_outlined, 'Privacy Policy', () => _snack('Privacy Policy coming soon!')),
          _navTile(Icons.description_outlined, 'Terms of Service', () => _snack('Terms of Service coming soon!')),
          ListTile(
            leading: CircleAvatar(radius: 18, backgroundColor: kPrimary.withOpacity(0.12),
              child: const Icon(Icons.info_outline, color: kPrimary, size: 18)),
            title: const Text('App Version', style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: kText, fontSize: 14)),
            trailing: const Text('1.0.0 (Build 1)', style: TextStyle(color: kTextGrey, fontFamily: 'Poppins', fontSize: 13)),
          ),

          // ── Account ──
          _sectionHeader('ACCOUNT'),
          ListTile(
            leading: CircleAvatar(radius: 18, backgroundColor: kErrorLight,
              child: const Icon(Icons.logout, color: kError, size: 18)),
            title: const Text('Log Out', style: TextStyle(color: kError, fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 14)),
            onTap: () => showDialog(context: context, builder: (_) => AlertDialog(
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
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _switchTile(IconData icon, String title, String sub, bool value, ValueChanged<bool> onChanged) => SwitchListTile(
    activeColor: kPrimary,
    secondary: CircleAvatar(radius: 18, backgroundColor: kPrimary.withOpacity(0.12),
      child: Icon(icon, color: kPrimary, size: 18)),
    title: Text(title, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: kText, fontSize: 14)),
    subtitle: Text(sub, style: const TextStyle(fontFamily: 'Poppins', color: kTextGrey, fontSize: 12)),
    value: value,
    onChanged: onChanged,
  );

  Widget _navTile(IconData icon, String title, VoidCallback onTap) => ListTile(
    leading: CircleAvatar(radius: 18, backgroundColor: kPrimary.withOpacity(0.12),
      child: Icon(icon, color: kPrimary, size: 18)),
    title: Text(title, style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, color: kText, fontSize: 14)),
    trailing: const Icon(Icons.chevron_right, color: kTextGrey),
    onTap: onTap,
  );
}
