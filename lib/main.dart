import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:organics_salary/logo_start.dart';
import 'package:organics_salary/pages/16personality/16personality_page.dart';
import 'package:organics_salary/pages/assessment/assessment_page.dart';
import 'package:organics_salary/pages/assessment/confirm_assessment_page.dart';
import 'package:organics_salary/pages/assessment/detail_assessment_page.dart';
import 'package:organics_salary/pages/assessment/history_assessment_page.dart';
import 'package:organics_salary/pages/assessment/recomment_assessment_page.dart';
import 'package:organics_salary/pages/assessment/section_assessment_page.dart';
import 'package:organics_salary/pages/auth/change_pass_page/change_pass_page.dart';
import 'package:organics_salary/pages/auth/change_pass_page/confirm_change_pass_page.dart';
import 'package:organics_salary/pages/auth/change_pass_page/status_change_pass_page.dart';
import 'package:organics_salary/pages/auth/login_page/login_page.dart';
import 'package:organics_salary/pages/auth/pin_page/check_pin_to_change_page.dart';
import 'package:organics_salary/pages/auth/pin_page/confirm_pin_auth_page.dart';
import 'package:organics_salary/pages/auth/register_page/register_page.dart';
import 'package:organics_salary/pages/auth/reset_pass_page/confirm_reset_pass_page.dart';
import 'package:organics_salary/pages/auth/reset_pass_page/reset_pass_page.dart';
import 'package:organics_salary/pages/auth/reset_pass_page/status_reset_pass_page.dart';
import 'package:organics_salary/pages/car/request_car_status_send_page.dart';
import 'package:organics_salary/pages/coin_hero/coin_status_send_page.dart';
import 'package:organics_salary/pages/coin_hero/confirm_redeem_page.dart';
import 'package:organics_salary/pages/coin_hero/detail_redeem_page.dart';
import 'package:organics_salary/pages/leave/section_leave_page.dart';
import 'package:organics_salary/pages/leave_approve/cause_not_approve_page.dart';
import 'package:organics_salary/pages/leave_approve/confirm_approve_page.dart';
import 'package:organics_salary/pages/leave_approve/section_leave_approve_page.dart';
import 'package:organics_salary/pages/leave_approve/leave_approve_page.dart';
import 'package:organics_salary/pages/request_doc/request_doc_page.dart';
import 'package:organics_salary/pages/request_doc/screen/history_view_screen.dart';
import 'package:organics_salary/pages/wallet/calculate_exchange_page.dart';
import 'package:organics_salary/pages/wallet/confirm_exchange_page.dart';
import 'package:organics_salary/pages/wallet/detail_exchange_page.dart';
import 'package:organics_salary/pages/wallet/exchange_coin_page.dart';
import 'package:organics_salary/pages/wallet/history_coin_hero_page.dart';
import 'package:organics_salary/pages/document_contract/contract_status_send_page.dart';
import 'package:organics_salary/pages/document_contract/document_contract_section_page.dart';
import 'package:organics_salary/pages/equipment/equipment_status_send_page.dart';
import 'package:organics_salary/pages/equipment/screen/detail_maintenance_return_page.dart';
import 'package:organics_salary/pages/equipment/screen/report_maintenance_repair_page.dart';
import 'package:organics_salary/pages/equipment/screen/report_maintenance_return_page.dart';
import 'package:organics_salary/pages/honor/honor_page.dart';
import 'package:organics_salary/pages/honor/request_add_honor_page.dart';
import 'package:organics_salary/pages/car/add_car_page.dart';
import 'package:organics_salary/pages/car/car_page.dart';
import 'package:organics_salary/pages/car/edit_car_page.dart';
import 'package:organics_salary/pages/car/section_car_page.dart';
import 'package:organics_salary/pages/coin_hero/coin_page.dart';
import 'package:organics_salary/pages/comment/comment_page.dart';
import 'package:organics_salary/pages/comment/report_comment_page.dart';
import 'package:organics_salary/pages/document_contract/document_contract_page.dart';
import 'package:organics_salary/pages/document_contract/request_document_contract_page.dart';
import 'package:organics_salary/pages/equipment/add_equipment_page.dart';
import 'package:organics_salary/pages/equipment/equipment_page.dart';
import 'package:organics_salary/pages/equipment/screen/history_maintenance_equpment_page.dart';
import 'package:organics_salary/pages/group_security/group_security_page.dart';
import 'package:organics_salary/pages/home/failed_token_page.dart';
import 'package:organics_salary/pages/honor/request_honor_status_send_page.dart';
import 'package:organics_salary/pages/leave/leave_page.dart';
import 'package:organics_salary/pages/leave/step_request/status_send.dart';
import 'package:organics_salary/pages/maintenance/detail_maintenance_page.dart';
import 'package:organics_salary/pages/maintenance/maintenance_status_send_page.dart';
import 'package:organics_salary/pages/provident_fund/provident_fund_status_send_page.dart';
import 'package:organics_salary/pages/savings/savings_status_send_page.dart';
import 'package:organics_salary/pages/social_security/social_security_status_send_page.dart';
import 'package:organics_salary/pages/status_result/status_cancel.dart';
import 'package:organics_salary/pages/status_result/status_success.dart';
import 'package:organics_salary/pages/transection/transection_page.dart';
import 'package:organics_salary/pages/maintenance/maintenance_page.dart';
import 'package:organics_salary/pages/maintenance/report_maintenance_page.dart';
import 'package:organics_salary/pages/news/news_page.dart';
import 'package:organics_salary/pages/news/news_section_page.dart';
import 'package:organics_salary/pages/notification/notification_page.dart';
import 'package:organics_salary/pages/privacy_policy/privacy_policy_page.dart';
import 'package:organics_salary/pages/profile/profile_page.dart';
import 'package:organics_salary/pages/provident_fund/provident_fund_page.dart';
import 'package:organics_salary/pages/provident_fund/report_provident_fund_page.dart';
import 'package:organics_salary/pages/record_work_time/locator.dart';
import 'package:organics_salary/pages/record_work_time/record_work_time_page.dart';
import 'package:organics_salary/pages/salary/salary_page.dart';
import 'package:organics_salary/pages/salary/screen/slip_section_page.dart';
import 'package:organics_salary/pages/salary/step_request/status_request.dart';
import 'package:organics_salary/pages/savings/savings_page.dart';
import 'package:organics_salary/pages/savings/withdraw_savings_page.dart';
// import 'package:organics_salary/pages/scan/scan_page.dart';
import 'package:organics_salary/pages/auth/pin_page/check_pin_page.dart';
import 'package:organics_salary/pages/home/home_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:organics_salary/pages/auth/pin_page/pin_auth_page.dart';
import 'package:organics_salary/pages/social_security/request_social_security_page.dart';
import 'package:organics_salary/pages/social_security/social_security_page.dart';
import 'package:organics_salary/pages/time_history/time_history_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:organics_salary/pages/user_demo/user_demo_page.dart';
import 'package:organics_salary/pages/wallet/organics_wallet_page.dart';
import 'package:organics_salary/section_start.dart';
import 'package:organics_salary/service/firebase_messaging_handler.dart';
import 'package:organics_salary/service/firebase_options.dart';
import 'package:organics_salary/theme.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:upgrader/upgrader.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void requestNotificationPermission() async {
  if (await Permission.notification.isDenied) {
    await Permission.notification.request();
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  const InitializationSettings initializationSettings = InitializationSettings(
    android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    iOS: DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    ),
  );

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  requestNotificationPermission();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await setupNotificationChannel();

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');
    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details); // แสดง log แบบเต็ม
    if (kDebugMode) {
      print(details.stack); // แสดง stack trace ใน debug mode
    }
  };

  dotenv.load();
  setupLocator();
  await GetStorage.init();
  await Upgrader.clearSavedSettings();
  FirebaseMessagingHandler.initialize();
  FirebaseMessagingHandler.initializeNotifications();
  Get.put(GetConnect());
  Intl.defaultLocale = 'th';
  initializeDateFormatting();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // AnnotatedRegion<SystemUiOverlayStyle>(
    //   value: SystemUiOverlayStyle(
    //     statusBarColor: Colors.transparent,
    //     systemNavigationBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.dark,
    //     systemNavigationBarIconBrightness: Brightness.dark,
    //   ),
    return GetMaterialApp(
      title: 'Organics Salary',
      // initialBinding: MyBinding(),
      scrollBehavior: const MaterialScrollBehavior()
          .copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      localizationsDelegates: const [
        // AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
        // CupertinoLocalizationsDelegate()
      ],
      supportedLocales: const [
        Locale('th'),
        // const Locale('en'),
        // const Locale('us'),
      ],
      locale: const Locale('th'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color.fromARGB(255, 250, 250, 250),
        dividerColor: Colors.grey[400],
        colorScheme: ColorScheme.fromSeed(
            primary: AppTheme.ognMdGreen, seedColor: Colors.white),
        useMaterial3: true,
        // textTheme: GoogleFonts.anuphanTextTheme(),
        textTheme: GoogleFonts.kanitTextTheme(),
        // textTheme: GoogleFonts.promptTextTheme(),
      ),
      // home: Stack(
      //   children: [
      //     Align(
      //       alignment: Alignment.bottomCenter,
      //       child: SafeArea(
      //         minimum: const EdgeInsets.only(bottom: 16),
      //         child: LogoStart(),
      //       ),
      //     ),
      //   ],
      // ),
      initialRoute: '/logo-start',
      // initialRoute: '/login',
      defaultTransition: Transition.cupertino,
      getPages: [
        // Auth
        GetPage(name: '/logo-start', page: () => const LogoStart()),
        GetPage(name: '/section-start', page: () => const SectionStart()),
        GetPage(
          name: '/pin',
          page: () => const CheckPinPage(),
          transition: Transition.noTransition,
        ),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),

        GetPage(name: '/', page: () => const HomePage()),
        GetPage(name: '/user-demo', page: () => const UserDemoPage()),

        // Pin
        GetPage(name: '/pinauth', page: () => const PinAuthPage()),
        GetPage(
            name: '/pinauth-tochange',
            page: () => const CheckPinToChangePage()),
        GetPage(
            name: '/confirm-pinauth', page: () => const ConfirmPinAuthpage()),
        GetPage(name: '/failed-token', page: () => FailedTokenPage()),

        // Change password
        GetPage(name: '/changepass', page: () => ChangePassPage()),
        GetPage(
            name: '/confirm-changepass',
            page: () => const ConfirmChangePassPage()),
        GetPage(
            name: '/status-changepass',
            page: () => const StatusChangePasswordPage()),

        // Reset password
        GetPage(name: '/resetpass', page: () => ResetPasswordPage()),
        GetPage(
            name: '/confirm-resetpass',
            page: () => const ConfirmResetPasswordPage()),
        GetPage(
            name: '/status-resetpass',
            page: () => const StatusResetPasswordPage()),

        // Salary
        GetPage(name: '/salary', page: () => const SalaryPage()),
        GetPage(name: '/slip-section', page: () => const SlipViewSection()),
        GetPage(name: '/salary-step-request', page: () => const StepRequest()),

        // Leave
        GetPage(name: '/leave', page: () => const LeavePage()),
        GetPage(name: '/leave-section', page: () => const SectionLeavePage()),
        GetPage(name: '/leave-step-request', page: () => const StepSend()),

        // Profile
        GetPage(name: '/profile', page: () => const ProfilePage()),

        // News
        GetPage(name: '/news', page: () => const NewsPage()),
        GetPage(name: '/news-section', page: () => const NewsSectionPage()),

        // Coin
        GetPage(name: '/coin', page: () => const CoinPage()),
        GetPage(
            name: '/coin-status-send', page: () => const CoinStatusSendPage()),
        GetPage(name: '/detail-redeem', page: () => const DetailRedeemPage()),
        GetPage(name: '/confirm-redeem', page: () => const ConfirmRedeemPage()),

        // Scan and Other scan function
        // GetPage(name: '/scan', page: () => const ScanPage()),

        // Notification
        GetPage(name: '/notification', page: () => const NotificationPage()),

        // Time History (Work)
        GetPage(name: '/time-history', page: () => const TimeHistoryPage()),

        // Honor
        GetPage(name: '/honor', page: () => const HonorPage()),
        GetPage(
            name: '/honor-request', page: () => const RequestAddHonorPage()),
        GetPage(
            name: '/honor-request-status',
            page: () => const RequestHonorStatusSendPage()),

        // Car
        GetPage(name: '/car', page: () => const CarPage()),
        GetPage(name: '/car-add', page: () => const AddCarPage()),
        GetPage(name: '/car-edit', page: () => const EditCarPage()),
        GetPage(name: '/car-section', page: () => const SectionCarPage()),
        GetPage(
            name: '/car-request-status',
            page: () => const RequestCarStatusSendPage()),

        // Document and Contract
        GetPage(
            name: '/document-contract',
            page: () => const DocumentContractPage()),
        GetPage(
            name: '/document-contract-section',
            page: () => const DocumentContractSectionPage()),
        GetPage(
            name: '/request-document-contract',
            page: () => const RequestDocumentContractPage()),
        GetPage(
            name: '/contract-status-send',
            page: () => const ContractStatusSendPage()),

        // List History
        GetPage(name: '/transection', page: () => const TransectionPage()),


        GetPage(name: '/request_doc', page: () => const RequestDocPage()),


        // Equipment
        GetPage(name: '/equipment', page: () => const EquipmentPage()),
        GetPage(name: '/equipment-add', page: () => const AddEquipmentPage()),
        GetPage(
            name: '/history-maintenance-equipment',
            page: () => const HistoryMaintenanceEqupmentPage()),
        GetPage(
            name: '/equipment-status-send',
            page: () => const EquipmentStatusSendPage()),
        GetPage(
            name: '/detail-maintenance-return',
            page: () => const DetailMaintenanceReturnPage()),
        GetPage(
            name: '/report-maintenance-return',
            page: () => const ReportMaintenanceReturnPage()),
        GetPage(
            name: '/report-maintenance-repair',
            page: () => const ReportMaintenanceRepairPage()),

        // Social Security
        GetPage(
            name: '/social-security', page: () => const SocialSecurityPage()),
        GetPage(
            name: '/request-social-security',
            page: () => const RequestSocialSecurityPage()),
        GetPage(
            name: '/social-security-status-send',
            page: () => const SocialSecurityStatusSendPage()),

        // Savings
        GetPage(name: '/savings', page: () => const SavingsPage()),
        GetPage(
            name: '/withdraw-savings', page: () => const WithdrawSavingsPage()),
        GetPage(
            name: '/savings-status-send',
            page: () => const SavingsStatusSendPage()),

        // Provident Fund
        GetPage(name: '/provident-fund', page: () => const ProvidentFundPage()),
        GetPage(
            name: '/report-provident-fund',
            page: () => ReportProvidentFundPage()),
        GetPage(
            name: '/provident-fund-status-send',
            page: () => const ProvidentFundStatusSendPage()),

        // Group Security
        GetPage(name: '/group-security', page: () => GroupSecurityPage()),

        // Maintenance
        GetPage(name: '/maintenance', page: () => const MaintenancePage()),
        GetPage(
            name: '/report-maintenance',
            page: () => const ReportMaintenancePage()),
        GetPage(
            name: '/detail-maintenance',
            page: () => const DetailMaintenancePage()),
        GetPage(
            name: '/maintenance-status-send',
            page: () => const MaintenanceStatusSendPage()),

        // Comment
        GetPage(name: '/comment', page: () => const CommentPage()),
        GetPage(name: '/report-comment', page: () => const ReportCommentPage()),

        // Status
        GetPage(name: '/status-success', page: () => const StatusSuccess()),
        GetPage(name: '/status-cancel', page: () => const StatusCancel()),
        GetPage(name: '/history-view', page: () => const HistoryView()),

        // Wallet
        GetPage(name: '/wallet', page: () => const OrganicsWalletPage()),
        GetPage(
            name: '/history-coin-hero',
            page: () => const HistoryCoinHeroPage()),
        GetPage(name: '/exchange-coin', page: () => const ExchangeCoinPage()),
        GetPage(
            name: '/detail-exchange', page: () => const DetailExchangePage()),
        GetPage(
            name: '/calculate-exchange',
            page: () => const CalculateExchangePage()),
        GetPage(
            name: '/confirm-exchange', page: () => const ConfirmExchangePage()),

        // Leave Approve
        GetPage(name: '/leave-approve', page: () => LeaveApprovePage()),
        GetPage(
            name: '/leave-section-approve',
            page: () => SectionLeaveApprovePage()),
        GetPage(
            name: '/cause-leave-not-approve',
            page: () => CauseNotApprovePage()),
        GetPage(
            name: '/confirm-leave-approve', page: () => ConfirmApprovePage()),

        // Assessment
        GetPage(name: '/assessment', page: () => AssessmentPage()),
        GetPage(
            name: '/section-assessment', page: () => SectionAssessmentPage()),
        GetPage(
            name: '/recomment-assessment',
            page: () => RecommentAssessmentPage()),
        GetPage(
            name: '/confirm-assessment',
            page: () => const ConfirmAssessmentPage()),
        GetPage(
            name: '/history-assessment',
            page: () => const HistoryAssessmentPage()),
        GetPage(
            name: '/detail-assessment',
            page: () => const DetailAssessmentPage()),

        // 16Personality
        GetPage(name: '/personality', page: () => const PersonalityPage()),
        // ===================== not use =========================

        GetPage(
          name: '/record-work-time',
          page: () =>
              RecordWorkTimePage(parameter: getCurrentTimeInThaiLocale()),
        ),
        GetPage(name: '/privacy-policy', page: () => const PrivacuPolicyPage()),

        // ===================== not use =========================
      ],
    );
  }

  String getCurrentTimeInThaiLocale() {
    var formatter = DateFormat('HH:mm:ss', 'th');
    var now = DateTime.now();
    String formattedTime = formatter.format(now);

    return formattedTime;
  }
}

class MyBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(GetConnect());
  }
}
