import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/dummy_data.dart';
import '../transfer/send_money_screen.dart';

class TransactionDetailScreen extends StatelessWidget {
  final Transaction tx;
  const TransactionDetailScreen({super.key, required this.tx});

  Color get _amtColor => tx.type == 'Received' ? kSuccess : tx.type == 'Top Up' ? kPrimary : kError;
  String get _amtPrefix => tx.type == 'Received' ? '+' : tx.type == 'Top Up' ? '↑' : '−';
  bool get _isSuccess => tx.status == 'Completed';

  String _fmtAmt(double v) => v.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');

  Widget _row(String label, String value, {Widget? trailing}) => Column(children: [
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
      child: Row(children: [
        Expanded(child: Text(label, style: const TextStyle(color: kTextGrey, fontFamily: 'Poppins', fontSize: 14))),
        trailing ?? Text(value, style: const TextStyle(color: kText, fontFamily: 'Poppins', fontSize: 14, fontWeight: FontWeight.w700)),
      ]),
    ),
    const Divider(height: 0, indent: 20, endIndent: 20),
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction Details')),
      body: Column(children: [
        // Status header
        Container(
          width: double.infinity, padding: const EdgeInsets.symmetric(vertical: 28),
          color: kPrimary,
          child: Column(children: [
            CircleAvatar(
              radius: 32, backgroundColor: Colors.white,
              child: Icon(_isSuccess ? Icons.check : Icons.close,
                color: _isSuccess ? kSuccess : kError, size: 36),
            ),
            const SizedBox(height: 12),
            Text(tx.status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontFamily: 'Poppins', fontSize: 16)),
            const SizedBox(height: 8),
            Text('$_amtPrefix PKR ${_fmtAmt(tx.amount)}',
              style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.w900, fontFamily: 'Poppins')),
          ]),
        ),
        // Details card
        Expanded(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 12)]),
              child: Column(children: [
                _row('Transaction ID', tx.id),
                _row('Type', tx.type),
                _row('From', tx.from),
                _row('To', tx.to),
                _row('Date', tx.date),
                _row('Time', tx.time),
                _row('Status', tx.status, trailing: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _isSuccess ? kSuccessLight : kErrorLight,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(tx.status, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, fontFamily: 'Poppins',
                    color: _isSuccess ? kSuccess : kError)),
                )),
                _row('Note', tx.note ?? 'No note added'),
                const SizedBox(height: 8),
              ]),
            ),
          ),
        ),
        // Buttons
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
          child: Column(children: [
            OutlinedButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Receipt download coming soon!'))),
              child: const Text('Download Receipt'),
            ),
            if (!_isSuccess) ...[
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SendMoneyScreen(prefillRecipient: tx.to))),
                child: const Text('Retry Transfer'),
              ),
            ],
            const SizedBox(height: 8),
          ]),
        ),
      ]),
    );
  }
}
