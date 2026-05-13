import 'package:flutter/material.dart';
import '../../utils/constants.dart';
import '../../models/dummy_data.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});
  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  late List<Map<String, dynamic>> _items;
  @override
  void initState() { super.initState(); _items = List.from(notifications); }

  IconData _icon(String type) {
    switch (type) {
      case 'money':   return Icons.account_balance_wallet;
      case 'success': return Icons.check_circle;
      case 'alert':   return Icons.warning_amber;
      case 'info':    return Icons.info_outline;
      case 'topup':   return Icons.add_card;
      case 'warning': return Icons.notification_important;
      default: return Icons.notifications;
    }
  }
  Color _color(String type) {
    switch (type) {
      case 'money':   return kPrimary;
      case 'success': return kSuccess;
      case 'alert':   return kError;
      case 'info':    return Colors.blue;
      case 'topup':   return kPrimary;
      case 'warning': return Colors.orange;
      default: return kTextGrey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [TextButton(
          onPressed: () => setState(() { for (var n in _items) n['read'] = true; }),
          child: const Text('Mark all read', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 13)),
        )],
      ),
      body: ListView.separated(
        itemCount: _items.length,
        separatorBuilder: (_, __) => const Divider(height: 0),
        itemBuilder: (_, i) {
          final n = _items[i];
          final read = n['read'] as bool;
          return InkWell(
            onTap: () => setState(() => _items[i] = {...n, 'read': true}),
            child: Container(
              color: read ? Colors.white : kUnread,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                CircleAvatar(radius: 22, backgroundColor: _color(n['icon']!).withOpacity(0.15),
                  child: Icon(_icon(n['icon']!), color: _color(n['icon']!), size: 20)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Expanded(child: Text(n['title']!, style: TextStyle(fontWeight: FontWeight.w700, fontFamily: 'Poppins', fontSize: 14, color: read ? kText : kPrimary))),
                    if (!read) Container(width: 8, height: 8, decoration: const BoxDecoration(color: kPrimary, shape: BoxShape.circle)),
                  ]),
                  const SizedBox(height: 4),
                  Text(n['body']!, style: const TextStyle(color: kTextGrey, fontFamily: 'Poppins', fontSize: 13, height: 1.4)),
                  const SizedBox(height: 6),
                  Text(n['time']!, style: const TextStyle(color: kTextGrey, fontFamily: 'Poppins', fontSize: 11)),
                ])),
              ]),
            ),
          );
        },
      ),
    );
  }
}
