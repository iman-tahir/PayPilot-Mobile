# PayPilot 
### A Peer-to-Peer Digital Payment Platform

> **Send money. Instantly.**

PayPilot is a full-stack fintech application built with Flutter for mobile and Laravel + MySQL for the web backend. Conceptually aligned with services like SadaPay, Easypaisa, and Venmo — it gives users a digital wallet, real-time money transfers, and complete transaction history from their smartphone.

---

## 📱 Mobile App — Flutter (Android & iOS)

Built from a single Flutter codebase targeting both Android and iOS. All 20 screens implemented across 6 functional modules.

### Screens & Features

**Onboarding & Authentication**
- Animated splash screen with auto-navigation
- 3-slide onboarding walkthrough with swipeable page dots
- Email + password login with validation and password visibility toggle
- Full signup with name, email, phone, CNIC, and terms acceptance
- Forgot password flow with email reset link and success state

**Dashboard & Navigation**
- Main dashboard with live balance card, quick actions, and recent transactions
- Persistent 4-tab bottom navigation (Home, Transfer, History, Profile)
- Notification center with categorized alerts and read/unread states

**Transfer & Payments**
- Send money by contact, phone, or email with quick-amount chips (500 / 1K / 2K / 5K)
- Transfer confirmation summary (sender, recipient, amount, fee) before finalizing
- Transfer success confirmation screen
- Request money from a contact with optional message

**Wallet & Top Up**
- Digital wallet overview — balance, linked payment methods, wallet activity
- Add funds simulation via JazzCash and Easypaisa

**Transaction History**
- Paginated transaction list with filter by type, date, and status
- Detailed transaction breakdown — ID, parties, amount, timestamp, status

**Profile & Settings**
- User profile with verified badge and transaction stats (total sent/received)
- Edit profile — name, phone, profile photo with form validation
- App settings — notifications, security, logout

---

## 🌐 Web App — Laravel + MySQL (Parallel Coursework)

A RESTful backend API built alongside the mobile app as part of the Web Technologies course.

| Layer | Technology |
|-------|-----------|
| Backend | PHP 8 + Laravel 10 |
| Database | MySQL |
| Frontend | HTML5, CSS3, Bootstrap 5 |

---

## 🛠️ Tech Stack

### Mobile
| Layer | Technology |
|-------|-----------|
| Framework | Flutter (Dart) — Android & iOS |
| Backend | Firebase (Auth + Firestore) |

### Design
| Property | Value |
|----------|-------|
| Primary | `#1A3A8F` — Dark Navy Blue |
| Accent | `#2952F3` — Vivid Blue |
| Background | `#EEF1FA` — Light Blue-Grey |
| Success | `#22C55E` |
| Error | `#EF4444` |

---

## 🚀 Getting Started

**Prerequisites:**
- Flutter SDK installed ([flutter.dev](https://flutter.dev))
- Android Studio or VS Code with Flutter extension
- Run `flutter doctor` to verify setup

```bash
# Clone the repository
git clone https://github.com/iman-tahir/PayPilot-Mobile.git
cd PayPilot-Mobile

# Install dependencies
flutter pub get

# Run the app
flutter run
```

---

## 📂 Project Structure

```
lib/
├── main.dart
├── models/
│   └── dummy_data.dart
├── screens/
│   ├── auth/
│   │   ├── splash_screen.dart
│   │   ├── login_screen.dart
│   │   ├── register_screen.dart
│   │   └── forgot_password_screen.dart
│   ├── dashboard/
│   │   ├── dashboard_screen.dart
│   │   ├── main_shell.dart
│   │   └── notifications_screen.dart
│   ├── transfer/
│   │   ├── send_money_screen.dart
│   │   ├── request_money_screen.dart
│   │   ├── confirm_transfer_screen.dart
│   │   ├── transfer_success_screen.dart
│   │   └── search_user_screen.dart
│   ├── wallet/
│   │   ├── wallet_screen.dart
│   │   └── top_up_screen.dart
│   ├── history/
│   │   ├── history_screen.dart
│   │   └── transaction_detail_screen.dart
│   ├── profile/
│   │   ├── profile_screen.dart
│   │   ├── edit_profile_screen.dart
│   │   └── settings_screen.dart
│   └── onboarding_screen.dart
└── utils/
    └── constants.dart
```

---

## 👥 Contributors

- Eman Tahir
- Huma Ijaz

---

## 🔗 Related

- [PayPilot Web](https://github.com/Huma-Ijaz/PayPilot) — companion web app (HTML, CSS, JS, PHP, MySQL)

---

## 📄 License

Academic project. Built for coursework at COMSATS University Islamabad.
