import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/mock_data.dart';
import '../../models/summary_model.dart';
import '../../models/transaction_model.dart';
import '../../routes/app_routes.dart';

// Import BalanceStatus enum
import '../../models/summary_model.dart' as summary_model;

class DashboardController extends GetxController {
  // Reactive variables
  final isLoading = true.obs;
  final isRefreshing = false.obs;
  final summary = Rx<Summary?>(null);
  final recentTransactions = <Transaction>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }
  
  // Load dashboard data
  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;
      
      // Simulate network delay
      await Future.delayed(const Duration(seconds: 1));
      
      // Load mock data
      final summaryData = MockData.getSummary();
      final allTransactions = MockData.getTransactions();
      
      // Get recent transactions (last 5)
      final recent = allTransactions
          .where((t) => t.type == TransactionType.expense)
          .take(5)
          .toList();
      
      summary.value = summaryData;
      recentTransactions.assignAll(recent);
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load dashboard data',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Refresh dashboard data
  Future<void> refreshData() async {
    isRefreshing.value = true;
    await loadDashboardData();
    isRefreshing.value = false;
  }
  
  // Navigate to transactions screen
  void onTransactionsTap() {
    Get.toNamed(Routes.transactions);
  }
  
  // Navigate to transaction detail
  void onTransactionTap(Transaction transaction) {
    Get.toNamed(
      Routes.transactionDetail,
      arguments: transaction,
    );
  }
  
  // Navigate to income transactions
  void onIncomeCardTap() {
    Get.toNamed(
      Routes.transactions,
      arguments: {'filter': 'income'},
    );
  }
  
  // Navigate to expense transactions
  void onExpenseCardTap() {
    Get.toNamed(
      Routes.transactions,
      arguments: {'filter': 'expense'},
    );
  }
  
  // Get balance status color
  String getBalanceStatusColor() {
    if (summary.value == null) return 'neutral';
    
    switch (summary.value!.balanceStatus) {
      case summary_model.BalanceStatus.good:
        return 'good';
      case summary_model.BalanceStatus.neutral:
        return 'neutral';
      case summary_model.BalanceStatus.low:
        return 'low';
    }
  }
  
  // Get formatted balance with color
  String getFormattedBalance() {
    if (summary.value == null) return '\$0.00';
    return summary.value!.formattedTotalBalance;
  }
  
  // Get savings rate
  double getSavingsRate() {
    if (summary.value == null) return 0.0;
    return summary.value!.savingsRate;
  }
  
  // Check if user has positive savings
  bool hasPositiveSavings() {
    if (summary.value == null) return false;
    return summary.value!.monthlySavings > 0;
  }
}
