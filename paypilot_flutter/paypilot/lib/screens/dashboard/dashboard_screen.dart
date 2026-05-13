import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/constants.dart';
import '../../models/dummy_data.dart';
import '../transfer/send_money_screen.dart';
import '../transfer/request_money_screen.dart';
import '../wallet/top_up_screen.dart';
import '../history/history_screen.dart';
import '../history/transaction_detail_screen.dart';
import '../dashboard/notifications_screen.dart';
import '../auth/login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  String _greeting() {
    final h = DateTime.now().hour;

    if (h < 12) return 'Good morning';
    if (h < 17) return 'Good afternoon';

    return 'Good evening';
  }

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    final userName =
        user?.displayName ??
            user?.email?.split('@').first ??
            'User';

    final initials = userName.isNotEmpty
        ? userName.substring(0, 1).toUpperCase()
        : 'U';

    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            // ── AppBar ──
            SliverAppBar(
              pinned: true,
              backgroundColor: kPrimaryDark,
              automaticallyImplyLeading: false,

              title: RichText(
                text: const TextSpan(
                  text: 'Pay',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Poppins',
                    fontSize: 22,
                  ),
                  children: [
                    TextSpan(
                      text: 'Pilot',
                      style: TextStyle(color: kPrimary),
                    ),
                  ],
                ),
              ),

              actions: [

                // Logout Button
                IconButton(
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                  onPressed: () async {

                    await FirebaseAuth.instance.signOut();

                    if (!context.mounted) return;

                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const LoginScreen(),
                      ),
                          (route) => false,
                    );
                  },
                ),

                // Notifications
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Colors.white,
                        size: 26,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                          const NotificationsScreen(),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: const BoxDecoration(
                          color: kError,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            '3',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Profile Avatar
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white30,
                    child: Text(
                      initials,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
              ],
            ),

            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Greeting
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      20,
                      20,
                      20,
                      0,
                    ),
                    child: Text(
                      '${_greeting()}, $userName 👋',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: kText,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  const Padding(
                    padding: EdgeInsets.fromLTRB(
                      20,
                      4,
                      20,
                      20,
                    ),
                    child: Text(
                      "Here's what's happening with your account today.",
                      style: TextStyle(
                        color: kTextGrey,
                        fontFamily: 'Poppins',
                        fontSize: 13,
                      ),
                    ),
                  ),

                  // Balance Card
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),

                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            kPrimaryDark,
                            kPrimary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),

                        borderRadius: BorderRadius.circular(20),

                        boxShadow: [
                          BoxShadow(
                            color: kPrimaryDark.withOpacity(0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),

                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [

                          const Text(
                            'Available Balance',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontFamily: 'Poppins',
                            ),
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            'PKR 47,850',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'Poppins',
                            ),
                          ),

                          const SizedBox(height: 16),

                          Row(
                            children: const [

                              Expanded(
                                child: _StatChip(
                                  label: 'Sent This Month',
                                  value: 'PKR 10,700',
                                  icon: Icons.arrow_upward,
                                ),
                              ),

                              SizedBox(width: 16),

                              Expanded(
                                child: _StatChip(
                                  label: 'Received',
                                  value: 'PKR 20,500',
                                  icon: Icons.arrow_downward,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Quick Actions
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'QUICK ACTIONS',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: kTextGrey,
                        letterSpacing: 1.2,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),

                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [

                        _QuickAction(
                          icon: Icons.send,
                          label: 'Send',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const SendMoneyScreen(),
                            ),
                          ),
                        ),

                        _QuickAction(
                          icon: Icons.call_received,
                          label: 'Request',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const RequestMoneyScreen(),
                            ),
                          ),
                        ),

                        _QuickAction(
                          icon: Icons.add_circle_outline,
                          label: 'Top Up',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const TopUpScreen(),
                            ),
                          ),
                        ),

                        _QuickAction(
                          icon: Icons.history,
                          label: 'History',
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const HistoryScreen(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Recent Transactions
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),

                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,

                      children: [

                        const Text(
                          'Recent Transactions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: kText,
                            fontFamily: 'Poppins',
                          ),
                        ),

                        TextButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                              const HistoryScreen(),
                            ),
                          ),

                          child: const Text(
                            'See All',
                            style: TextStyle(
                              color: kPrimary,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  ...dummyTransactions.take(4).map(
                        (tx) => _TxRow(
                      tx: tx,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              TransactionDetailScreen(tx: tx),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {

  final String label;
  final String value;
  final IconData icon;

  const _StatChip({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) => Row(
    children: [

      Icon(
        icon,
        size: 14,
        color: Colors.white70,
      ),

      const SizedBox(width: 6),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              label,
              style: const TextStyle(
                color: Colors.white60,
                fontSize: 10,
                fontFamily: 'Poppins',
              ),
            ),

            Text(
              value,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

class _QuickAction extends StatelessWidget {

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,

    child: Column(
      children: [

        Container(
          width: 60,
          height: 60,

          decoration: BoxDecoration(
            color: kPrimary.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
          ),

          child: Icon(
            icon,
            color: kPrimary,
            size: 26,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: kText,
            fontFamily: 'Poppins',
          ),
        ),
      ],
    ),
  );
}

class _TxRow extends StatelessWidget {

  final dynamic tx;
  final VoidCallback onTap;

  const _TxRow({
    required this.tx,
    required this.onTap,
  });

  Color get _amtColor =>
      tx.type == 'Received'
          ? kSuccess
          : tx.type == 'Top Up'
          ? kPrimary
          : kError;

  String get _amtPrefix =>
      tx.type == 'Received'
          ? '+'
          : tx.type == 'Top Up'
          ? '↑'
          : '−';

  Color get _avatarColor =>
      tx.type == 'Received'
          ? kSuccess
          : tx.type == 'Top Up'
          ? kPrimary
          : kError;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,

    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),

      child: Row(
        children: [

          CircleAvatar(
            radius: 22,
            backgroundColor:
            _avatarColor.withOpacity(0.15),

            child: Icon(
              tx.type == 'Received'
                  ? Icons.arrow_downward
                  : tx.type == 'Top Up'
                  ? Icons.add
                  : Icons.arrow_upward,

              color: _avatarColor,
              size: 18,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [

                Text(
                  tx.type == 'Received'
                      ? tx.from
                      : tx.to,

                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    color: kText,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),

                Text(
                  '${tx.date} • ${tx.type}',
                  style: const TextStyle(
                    color: kTextGrey,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),

          Column(
            crossAxisAlignment:
            CrossAxisAlignment.end,

            children: [

              Text(
                '$_amtPrefix PKR ${tx.amount.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',')}',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: _amtColor,
                  fontFamily: 'Poppins',
                  fontSize: 14,
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),

                decoration: BoxDecoration(
                  color: tx.status == 'Completed'
                      ? kSuccessLight
                      : kErrorLight,

                  borderRadius:
                  BorderRadius.circular(20),
                ),

                child: Text(
                  tx.status,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'Poppins',
                    color: tx.status == 'Completed'
                        ? kSuccess
                        : kError,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}