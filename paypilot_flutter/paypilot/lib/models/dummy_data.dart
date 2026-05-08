// ── User Model ────────────────────────────────────────────────────────────────
class UserModel {
  final String name, email, phone, cnic, initials;
  final double balance;
  UserModel({required this.name, required this.email, required this.phone, required this.cnic, required this.initials, required this.balance});
}

// ── Transaction Model ─────────────────────────────────────────────────────────
class Transaction {
  final String id, from, to, date, time, type, status;
  final double amount;
  final String? note;
  Transaction({required this.id, required this.from, required this.to, required this.date, required this.time, required this.type, required this.status, required this.amount, this.note});
}

// ── Dummy Data ────────────────────────────────────────────────────────────────
final currentUser = UserModel(name: 'Ali Hassan', email: 'ali.hassan@gmail.com', phone: '0312-4521890', cnic: '3520X-*****-*01', initials: 'AH', balance: 47850);

final dummyUsers = [
  UserModel(name: 'Fatima Malik',  email: 'fatima.malik@gmail.com',  phone: '0300-9871234', cnic: '3740*******22', initials: 'FM', balance: 12300),
  UserModel(name: 'Usman Tariq',   email: 'usman.tariq@yahoo.com',   phone: '0321-5678901', cnic: '3510*******45', initials: 'UT', balance: 89200),
  UserModel(name: 'Ayesha Raza',   email: 'ayesha.raza@gmail.com',   phone: '0333-1234567', cnic: '3630*******67', initials: 'AR', balance: 5450),
  UserModel(name: 'Bilal Ahmed',   email: 'bilal.ahmed@hotmail.com', phone: '0345-7890123', cnic: '3520*******89', initials: 'BA', balance: 31000),
];

final dummyTransactions = [
  Transaction(id: '#PP001', from: 'Ali Hassan', to: 'Fatima Malik', date: '12 Mar 2026', time: '10:32 AM', type: 'Sent',     status: 'Completed', amount: 5000,  note: 'Rent split'),
  Transaction(id: '#PP002', from: 'Usman Tariq', to: 'Ali Hassan',  date: '11 Mar 2026', time: '3:15 PM',  type: 'Received', status: 'Completed', amount: 12500),
  Transaction(id: '#PP003', from: 'Ali Hassan', to: 'Ayesha Raza',  date: '10 Mar 2026', time: '9:00 AM',  type: 'Sent',     status: 'Completed', amount: 2200,  note: 'Dinner bill'),
  Transaction(id: '#PP004', from: 'JazzCash',   to: 'Ali Hassan',   date: '9 Mar 2026',  time: '6:44 PM',  type: 'Top Up',   status: 'Completed', amount: 10000),
  Transaction(id: '#PP005', from: 'Ali Hassan', to: 'Bilal Ahmed',  date: '8 Mar 2026',  time: '2:20 PM',  type: 'Sent',     status: 'Failed',    amount: 3500),
  Transaction(id: '#PP006', from: 'Fatima Malik', to: 'Ali Hassan', date: '7 Mar 2026',  time: '11:05 AM', type: 'Received', status: 'Completed', amount: 8000),
  Transaction(id: '#PP007', from: 'Ali Hassan', to: 'Usman Tariq',  date: '5 Mar 2026',  time: '7:30 PM',  type: 'Sent',     status: 'Completed', amount: 1800),
  Transaction(id: '#PP008', from: 'JazzCash',   to: 'Ali Hassan',   date: '1 Mar 2026',  time: '12:00 PM', type: 'Top Up',   status: 'Completed', amount: 20000),
];

final notifications = [
  {'icon': 'money',   'title': 'Money Received',     'body': 'Usman Tariq sent you PKR 12,500',                         'time': '2 hours ago',   'read': false},
  {'icon': 'success', 'title': 'Transfer Successful', 'body': 'Your transfer of PKR 5,000 to Fatima Malik was successful','time': 'Yesterday 3:15 PM','read': true},
  {'icon': 'alert',   'title': 'Login Alert',         'body': 'New login detected on your account from Lahore, Pakistan', 'time': 'Yesterday 9:00 AM','read': false},
  {'icon': 'info',    'title': 'Account Verified',    'body': 'Your account has been successfully verified',              'time': '2 days ago',    'read': true},
  {'icon': 'topup',   'title': 'Top Up Successful',   'body': 'PKR 10,000 has been added to your wallet',                'time': '3 days ago',    'read': true},
  {'icon': 'warning', 'title': 'Low Balance Alert',   'body': 'Your balance is below PKR 1,000. Top up to continue.',    'time': '5 days ago',    'read': true},
];
