import 'package:get/get.dart';
import '../modules/login/login_view.dart';
import '../modules/login/login_binding.dart';
import '../modules/dashboard/dashboard_view.dart';
import '../modules/dashboard/dashboard_binding.dart';
import '../modules/transactions/transactions_view.dart';
import '../modules/transactions/transactions_binding.dart';
import '../modules/transaction_detail/transaction_detail_view.dart';

abstract class Routes {
  static const login = '/login';
  static const dashboard = '/dashboard';
  static const transactions = '/transactions';
  static const transactionDetail = '/transaction-detail';
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.transactions,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
    GetPage(
      name: Routes.transactionDetail,
      page: () => const TransactionDetailView(),
    ),
  ];
}
