import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../transfer/transfer_success_screen.dart';

class TopUpScreen extends StatefulWidget {
  const TopUpScreen({super.key});
  @override
  State<TopUpScreen> createState() => _TopUpScreenState();
}

class _TopUpScreenState extends State<TopUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  int? _selectedChip;
  int _selectedMethod = 0;

  final _quickAmts = [500, 1000, 2000, 5000, 10000];
  final _methods = ['JazzCash', 'EasyPaisa', 'Debit / Credit Card', 'Bank Transfer'];
  final _methodIcons = [Icons.phone_android, Icons.account_balance_wallet, Icons.credit_card, Icons.account_balance];

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(context, MaterialPageRoute(builder: (_) =>
        TransferSuccessScreen(recipient: 'My Wallet (Top Up)', amount: double.tryParse(_amountCtrl.text) ?? 0)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Top Up Wallet')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // Current balance
            Container(
              width: double.infinity, padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: kPrimary.withOpacity(0.1), borderRadius: BorderRadius.circular(12),
                border: Border.all(color: kPrimary.withOpacity(0.3)),
              ),
              child: Row(children: [
                const Icon(Icons.account_balance_wallet, color: kPrimary),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [
                  Text('Current Balance', style: TextStyle(color: kTextGrey, fontFamily: 'Poppins', fontSize: 12)),
                  Text('PKR 47,850', style: TextStyle(color: kPrimary, fontFamily: 'Poppins', fontSize: 18, fontWeight: FontWeight.w800)),
                ]),
              ]),
            ),
            const SizedBox(height: 24),
            const Text('ENTER AMOUNT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: kTextGrey, fontFamily: 'Poppins', letterSpacing: 1.2)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _amountCtrl,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: kText, fontFamily: 'Poppins'),
              decoration: const InputDecoration(hintText: '0.00', prefixText: 'PKR  ',
                prefixStyle: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 18, color: kPrimary)),
              validator: (v) {
                final n = double.tryParse(v ?? '');
                if (n == null || n <= 0) return 'Please enter a valid amount';
                return null;
              },
            ),
            const SizedBox(height: 16),
            // Quick select chips
            Wrap(
              spacing: 8, runSpacing: 8,
              children: List.generate(_quickAmts.length, (i) {
                final selected = _selectedChip == i;
                return GestureDetector(
                  onTap: () => setState(() {
                    _selectedChip = i;
                    _amountCtrl.text = _quickAmts[i].toString();
                  }),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                    decoration: BoxDecoration(
                      color: selected ? kPrimary : Colors.white,
                      border: Border.all(color: selected ? kPrimary : const Color(0xFFDDE3EE), width: 1.5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text('PKR ${_quickAmts[i]}',
                      style: TextStyle(color: selected ? Colors.white : kText, fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700, fontSize: 13)),
                  ),
                );
              }),
            ),
            const SizedBox(height: 28),
            const Text('PAYMENT METHOD', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: kTextGrey, fontFamily: 'Poppins', letterSpacing: 1.2)),
            const SizedBox(height: 12),
            ...List.generate(_methods.length, (i) => RadioListTile<int>(
              value: i,
              groupValue: _selectedMethod,
              activeColor: kPrimary,
              contentPadding: const EdgeInsets.symmetric(horizontal: 0),
              onChanged: (v) => setState(() => _selectedMethod = v!),
              title: Row(children: [
                CircleAvatar(radius: 16, backgroundColor: kPrimary.withOpacity(0.12),
                  child: Icon(_methodIcons[i], size: 16, color: kPrimary)),
                const SizedBox(width: 12),
                Text(_methods[i], style: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600, fontSize: 14, color: kText)),
              ]),
            )),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: _submit, child: const Text('Proceed to Payment →')),
            const SizedBox(height: 24),
          ]),
        ),
      ),
    );
  }
}
