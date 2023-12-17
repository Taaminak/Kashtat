import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:kashtat/Features/Account%20Reports/AccountReportsScreen.dart';
import 'package:kashtat/Features/Account%20Summary/AccountSummaryScreen.dart';
import 'package:kashtat/Features/Arrival%20Instructions%20Screen/ArrivalInstructionsScreen.dart';
import 'package:kashtat/Features/Bank%20Account%20Settings/BankAccountSettings.dart';
import 'package:kashtat/Features/Dashboard%20Screen/DashboardScreen.dart';
import 'package:kashtat/Features/Entry%20and%20departure%20time/EntryAndDepartureTimeScreen.dart';
import 'package:kashtat/Features/Financial%20Transactions/FinancialTransactionsScreen.dart';
import 'package:kashtat/Features/Pricing%20Screen/PricingScreen.dart';
import 'package:kashtat/Features/Rate%20Screen/RateScreen.dart';
import 'package:kashtat/Features/Reports%20and%20complaints/ReportsAndComplaintsScreen.dart';
import 'package:kashtat/Features/Reservation%20Requirement/ReservationRequirementScreen.dart';
import 'package:kashtat/Features/Service%20Provider%20Settings/ServiceProviderSettings.dart';
import 'package:kashtat/Features/Usage%20Agreement/UsageAgreementScreen.dart';
import 'package:kashtat/testScreen.dart';
import '../../Features/Account Reports Screen/AccountReportsScreen.dart';
import '../../Features/Cards Screen/CardsScreen.dart';
import '../../Features/Change Language Screen/ChangeLanguageScreen.dart';
import '../../Features/Contact Us Screen/ContactUsScreen.dart';
import '../../Features/Kashta%20Details%20Screen/KashtaDetailsScreen.dart';
import '../../Features/Add Card Screen/AddCardScreen.dart';
import '../../Features/Home Screen/HomeScreen.dart';
import '../../Features/More Screen/MoreScreen.dart';
import '../../Features/My Account Screen/MyAccountScreen.dart';
import '../../Features/My Requests/MyRequestsScreen.dart';
import '../../Features/Notification Screen/NotificationScreen.dart';
import '../../Features/OTP Screen/OTPScreen.dart';
import '../../Features/Login Screen/LoginScreen.dart';
import '../../Features/OnBoarding Screen/OnBoardingScreen.dart';
import '../../Features/Privacy Policy Screen/PrivacyPolicyScreen.dart';
import '../../Features/Register Screen/RegisterScreen.dart';
// import '../../Features/Request Details/RequestDetailsScreen.dart';
import '../../Features/Splash Screen/SplashScreen.dart';
import '../../Features/Wallet Logs Screen/WalletLogsScreen.dart';

class RoutesManager {
  static GoRouter router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: ScreenName.test,
        builder: (BuildContext context, GoRouterState state) {
          return const TestScreen();
        },
      ),
      GoRoute(
        path: ScreenName.splash,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: ScreenName.dashboard,
        builder: (BuildContext context, GoRouterState state) {
          return const DashboardScreen();
        },
      ),
      GoRoute(
        path: ScreenName.notifications,
        builder: (BuildContext context, GoRouterState state) {
          return const NotificationsScreen();
        },
      ),
      GoRoute(
        path: ScreenName.home,
        builder: (BuildContext context, GoRouterState state) {
          // Map<String, String> args = state.extra as Map<String, String>;
          return HomeScreen(title: /*args['title']??*/'');
        },
      ),
      GoRoute(
        path: ScreenName.addCard,
        builder: (BuildContext context, GoRouterState state) {
          return const CreditCardScreen();
        },
      ),
      // GoRoute(
      //   path: ScreenName.kashtaDetails,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const KashtaDetailsScreen();
      //   },
      // ),
      GoRoute(
        path: ScreenName.login,
        builder: (BuildContext context, GoRouterState state) {
          return const LoginScreen();
        },
      ),
      GoRoute(
        path: ScreenName.register,
        builder: (BuildContext context, GoRouterState state) {
          return const RegisterScreen();
        },
      ),
      GoRoute(
        path: ScreenName.more,
        builder: (BuildContext context, GoRouterState state) {
          return const MoreScreen();
        },
      ),
      GoRoute(
        path: ScreenName.myRequests,
        builder: (BuildContext context, GoRouterState state) {
          return const MyRequestsScreen();
        },
      ),
      GoRoute(
        path: ScreenName.myRequests,
        builder: (BuildContext context, GoRouterState state) {
          return const OTPScreen();
        },
      ),
      // GoRoute(
      //   path: ScreenName.requestDetails,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const RequestDetailsScreen();
      //   },
      // ),
      GoRoute(
        path: ScreenName.otp,
        builder: (BuildContext context, GoRouterState state) {
          return const OTPScreen();
        },
      ),
      GoRoute(
        path: ScreenName.cards,
        builder: (BuildContext context, GoRouterState state) {
          return const CardsScreen();
        },
      ),
      GoRoute(
        path: ScreenName.language,
        builder: (BuildContext context, GoRouterState state) {
          return const ChangeLanguageScreen();
        },
      ),
      GoRoute(
        path: ScreenName.privacyPolicy,
        builder: (BuildContext context, GoRouterState state) {
          return const PrivacyPolicyScreen();
        },
      ),
      GoRoute(
        path: ScreenName.contactUs,
        builder: (BuildContext context, GoRouterState state) {
          return const ContactUsScreen();
        },
      ),
      GoRoute(
        path: ScreenName.walletRecords,
        builder: (BuildContext context, GoRouterState state) {
          return const WalletRecordsScreen();
        },
      ),
      // GoRoute(
      //   path: ScreenName.myAccount,
      //   builder: (BuildContext context, GoRouterState state) {
      //     return const MyAccountScreen();
      //   },
      // ),
      GoRoute(
        path: ScreenName.onBoarding,
        builder: (BuildContext context, GoRouterState state) {
          return const OnBoardingScreen();
        },
      ),
      GoRoute(
        path: ScreenName.arrivalInstructions,
        builder: (BuildContext context, GoRouterState state) {
          return const ArrivalInstructionsScreen();
        },
      ),
      GoRoute(
        path: ScreenName.bankAccountSettings,
        builder: (BuildContext context, GoRouterState state) {
          return const BankAccountSettings();
        },
      ),
      GoRoute(
        path: ScreenName.accountSummary,
        builder: (BuildContext context, GoRouterState state) {
          return const AccountSummaryScreen();
        },
      ),
      GoRoute(
        path: ScreenName.rateScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const RateScreen();
        },
      ),
      GoRoute(
        path: ScreenName.financialTransactions,
        builder: (BuildContext context, GoRouterState state) {
          return const FinancialTransactionsScreen();
        },
      ),
      GoRoute(
        path: ScreenName.pricingScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const PricingScreen();
        },
      ),
      GoRoute(
        path: ScreenName.serviceProviderSettings,
        builder: (BuildContext context, GoRouterState state) {
          return const ServiceProviderSettingsScreen();
        },
      ),
      GoRoute(
        path: ScreenName.entryAndDepartureTime,
        builder: (BuildContext context, GoRouterState state) {
          return const EntryAndDepartureTimeScreen();
        },
      ),
      GoRoute(
        path: ScreenName.reservationRequirement,
        builder: (BuildContext context, GoRouterState state) {
          return const ReservationRequirementScreen();
        },
      ),
      GoRoute(
        path: ScreenName.accountReports,
        builder: (BuildContext context, GoRouterState state) {
          return const AccountReportsScreen();
        },
      ),
      GoRoute(
        path: ScreenName.usageAgreement,
        builder: (BuildContext context, GoRouterState state) {
          return const UsageAgreementScreen();
        },
      ),
      GoRoute(
        path: ScreenName.reportsAndComplaints,
        builder: (BuildContext context, GoRouterState state) {
          return const ReportsAndComplaintsScreen();
        },
      ),
    ],
    debugLogDiagnostics: true,
  );
}


abstract class ScreenName {
  static const String splash = '/';
  static const String test = '/test';
  static const String dashboard = '/dashboard';
  static const String notifications = '/notifications';
  static const String addCard = '/addCard';
  static const String coupon = '/coupon';
  static const String home = '/home';
  // static const String kashtaDetails = '/kashtaDetails';
  static const String login = '/login';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String more = '/more';
  static const String myRequests = '/myRequest';
  // static const String requestDetails = '/requestDetails';
  static const String cards = '/cardsScreen';
  static const String language = '/language';
  static const String privacyPolicy = '/privacyPolicy';
  static const String contactUs = '/contactUs';
  static const String walletRecords = '/walletRecords';
  static const String myAccount = '/myAccount';
  static const String onBoarding = '/OnBoarding';
  static const String arrivalInstructions = '/arrivalInstructions';
  static const String bankAccountSettings = '/bankAccountSettings';
  static const String accountSummary= '/accountSummary';
  static const String rateScreen= '/rateScreen';
  static const String financialTransactions= '/financialTransactions';
  static const String pricingScreen= '/PricingScreen';
  static const String serviceProviderSettings= '/ServiceProviderSettingsScreen';
  static const String entryAndDepartureTime= '/EntryAndDepartureTimeScreen';
  static const String reservationRequirement= '/ReservationRequirementScreen';
  static const String accountReports= '/AccountReportsScreen';
  static const String usageAgreement= '/UsageAgreementScreen';
  static const String reportsAndComplaints = '/ReportsAndComplaintsScreen';


  static const List<String> values = [
    splash,
    test,
    addCard,
    dashboard,
    notifications,
    coupon,
    home,
    // kashtaDetails,
    login,
    register,
    otp,
    more,
    myRequests,
    // requestDetails,
    cards,
    language,
    privacyPolicy,
    contactUs,
    walletRecords,
    myAccount,
    onBoarding,
    arrivalInstructions,
    bankAccountSettings,
    accountSummary,
    rateScreen,
    financialTransactions,
    pricingScreen,
    serviceProviderSettings,
    entryAndDepartureTime,
    reservationRequirement,
    accountReports,
    usageAgreement,
    reportsAndComplaints,
  ];
}