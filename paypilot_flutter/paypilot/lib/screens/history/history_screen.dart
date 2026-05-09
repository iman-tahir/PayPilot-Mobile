import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/dummy_data.dart';
import 'transaction_detail_screen.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final _tabs = ['All', 'Sent', 'Received', 'Top Up'];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() { _tabCtrl.dispose(); super.dispose(); }

  List<Transaction> _filter(String type) {
    if (type == 'All') return dummyTransactions;
    return dummyTransactions.where((t) => t.type == type).toList();
  }

  Color _amtColor(String type) => type == 'Received' ? kSuccess : type == 'Top Up' ? kPrimary : kError;
  String _amtPrefix(String type) => type == 'Received' ? '+' : type == 'Top Up' ? '↑' : '−';
  Color _avatarColor(String type) => type == 'Received' ? kSuccess : type == 'Top Up' ? kPrimary : kError;
  IconData _avatarIcon(String type) => type == 'Received' ? Icons.arrow_downward : type == 'Top Up' ? Icons.add : Icons.arrow_upward;

  String _fmtAmt(double v) => v.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');

  Widget _txList(String filter) {
    final list = _filter(filter);
    if (list.isEmpty) return const Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.receipt_long, size: 60, color: kTextGrey),
        SizedBox(height: 12),
        Text('No transactions here.', style: TextStyle(color: kTextGrey, fontFamily: 'Poppins')),
      ]),
    );
    return ListView.separated(
      itemCount: list.length,
      separatorBuilder: (_, __) => const Divider(height: 0, indent: 72),
      itemBuilder: (_, i) {
        final tx = list[i];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          leading: CircleAvatar(
            radius: 22, backgroundColor: _avatarColor(tx.type).withOpacity(0.15),
            child: Icon(_avatarIcon(tx.type), color: _avatarColor(tx.type), size: 18),
          ),
          title: Text(tx.type == 'Received' ? tx.from : tx.to,
            style: const TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Poppins', fontSize: 14, color: kText)),
          subtitle: Text('${tx.date} • ${tx.time}', style: const TextStyle(color: kTextGrey, fontFamily: 'Poppins', fontSize: 12)),
          trailing: Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text('${_amtPrefix(tx.type)} PKR ${_fmtAmt(tx.amount)}',
              style: TextStyle(fontWeight: FontWeight.w800, color: _amtColor(tx.type), fontFamily: 'Poppins', fontSize: 13)),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: tx.status == 'Completed' ? kSuccessLight : kErrorLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(tx.status, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, fontFamily: 'Poppins',
                color: tx.status == 'Completed' ? kSuccess : kError)),
            ),
          ]),
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => TransactionDetailScreen(tx: tx))),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        actions: [IconButton(icon: const Icon(Icons.filter_list), onPressed: () {
          showModalBottomSheet(context: context, builder: (_) => Container(
            padding: const EdgeInsets.all(24),
            child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Filter by Date Range', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 18, fontFamily: 'Poppins')),
              const SizedBox(height: 16),
              const Text('Last 7 days', style: TextStyle(fontFamily: 'Poppins', color: kPrimary, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              const Text('Last 30 days', style: TextStyle(fontFamily: 'Poppins')),
              const SizedBox(height: 8),
              const Text('Last 3 months', style: TextStyle(fontFamily: 'Poppins')),
              const SizedBox(height: 24),
            ]),
          ));
        })],
        bottom: TabBar(
          controller: _tabCtrl,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700, fontSize: 13),
          tabs: _tabs.map((t) => Tab(text: t)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabCtrl,
        children: _tabs.map((t) => _txList(t)).toList(),
      ),
    );
  }
}
