import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/controllers/theme_controller.dart';
import '../../core/widgets/summary_card.dart';
import '../../core/widgets/transaction_tile.dart';
import '../../core/widgets/loading_view.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/simple_bar_chart.dart';
import '../../models/summary_model.dart' as summary_model;
import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Dashboard'),
            actions: [
              IconButton(
                icon: Icon(
                  themeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: themeController.toggleTheme,
                tooltip: 'Toggle Theme',
              ),
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  // TODO: Implement notifications
                  Get.snackbar('Notifications', 'No new notifications');
                },
              ),
            ],
          ),
          body: Obx((){
            controller.isLoading.value;
            if (controller.isLoading.value) {
              return LoadingView(
                message: 'Loading dashboard...',
                showShimmer: false, // Use progress bar instead
              );
            }
            
            return RefreshIndicator(
              onRefresh: controller.refreshData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Welcome section
                    _buildWelcomeSection(),
                    
                    const SizedBox(height: 24),
                    
                    // Balance card
                    _buildBalanceCard(),
                    
                    const SizedBox(height: 24),
                    
                    // Summary cards
                    _buildSummaryCards(),
                    
                    const SizedBox(height: 24),
                    
                    // Simple chart
                    _buildChart(),
                    
                    const SizedBox(height: 32),
                    
                    // Recent transactions
                    _buildRecentTransactions(),
                  ],
                ),
              ),
            );
          }),
        );
      }
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good morning!',
          style: Get.theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Here\'s your financial overview',
          style: Get.theme.textTheme.bodyMedium?.copyWith(
            color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
          ),
        ),
      ],
    );
  }

  Widget _buildBalanceCard() {
    return Obx((){
      controller.summary.value;
      final summary = controller.summary.value;
      if (summary == null) return const SizedBox.shrink();
      
      return Card(
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.15),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.account_balance_wallet_outlined,
                    color: AppColors.primary,
                    size: 24,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Total Balance',
                    style: Get.theme.textTheme.labelMedium?.copyWith(
                      color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                summary.formattedTotalBalance,
                style: AppTextStyles.amountLarge.copyWith(
                  color: summary.balanceStatus == summary_model.BalanceStatus.low
                      ? AppColors.error
                      : Get.theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildBalanceItem(
                      'Income',
                      summary.formattedMonthlyIncome,
                      Icons.arrow_downward,
                      AppColors.income,
                    ),
                  ),
                  Container(
                    width: 1,
                    height: 40,
                    color: AppColors.outline,
                  ),
                  Expanded(
                    child: _buildBalanceItem(
                      'Expenses',
                      summary.formattedMonthlyExpenses,
                      Icons.arrow_upward,
                      AppColors.expense,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildBalanceItem(String label, String amount, IconData icon, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: AppTextStyles.bodySmall.copyWith(
                  color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: AppTextStyles.bodyMedium.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Overview',
          style: AppTextStyles.h4.copyWith(
            color: Get.theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 16),
        Obx((){
          controller.summary.value;
          final summary = controller.summary.value;
          if (summary == null) return const SizedBox.shrink();
          
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Income card
                CompactSummaryCard(
                  title: 'Monthly Income',
                  amount: summary.formattedMonthlyIncome,
                  icon: Icons.arrow_downward,
                  iconColor: AppColors.income,
                  backgroundColor: AppColors.income,
                  onTap: controller.onIncomeCardTap,
                ),
                const SizedBox(width: 12),
                // Expenses card
                CompactSummaryCard(
                  title: 'Monthly Expenses',
                  amount: summary.formattedMonthlyExpenses,
                  icon: Icons.arrow_upward,
                  iconColor: AppColors.expense,
                  backgroundColor: AppColors.expense,
                  onTap: controller.onExpenseCardTap,
                ),
                const SizedBox(width: 12),
                // Savings card
                CompactSummaryCard(
                  title: 'Savings Rate',
                  amount: '${summary.savingsRate.toStringAsFixed(1)}%',
                  icon: controller.hasPositiveSavings()
                      ? Icons.trending_up
                      : Icons.trending_flat,
                  iconColor: controller.hasPositiveSavings()
                      ? AppColors.success
                      : AppColors.textTertiary,
                  backgroundColor: controller.hasPositiveSavings()
                      ? AppColors.success
                      : AppColors.textTertiary,
                  onTap: controller.onTransactionsTap,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildChart() {
    return SimpleBarChart(
      data: [450, 320, 280, 390, 410, 380, 420],
      labels: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'],
      barColor: Theme.of(Get.context!).colorScheme.primary,
    );
  }

  Widget _buildRecentTransactions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Recent Transactions',
              style: AppTextStyles.h4.copyWith(
                color: Get.theme.colorScheme.onSurface,
              ),
            ),
            TextButton(
              onPressed: controller.onTransactionsTap,
              child: Text(
                'See all',
                style: AppTextStyles.buttonMedium.copyWith(
                  color: AppColors.primary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Obx((){
          controller.recentTransactions;
          final transactions = controller.recentTransactions;
          
          if (transactions.isEmpty) {
            return const EmptyTransactionsState();
          }
          
          return Card(
            child: Column(
              children: [
                ...transactions.map((transaction) => Column(
                  children: [
                    TransactionTile(
                      transaction: transaction,
                      onTap: () => controller.onTransactionTap(transaction),
                    ),
                    if (transaction != transactions.last)
                      const Divider(height: 1),
                  ],
                )),
              ],
            ),
          );
        }),
      ],
    );
  }
}
