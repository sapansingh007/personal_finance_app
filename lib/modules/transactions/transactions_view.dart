import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/controllers/theme_controller.dart';
import '../../core/widgets/transaction_tile.dart';
import '../../core/widgets/loading_view.dart';
import '../../core/widgets/empty_state.dart';
import 'transactions_controller.dart';
import 'filter_bottom_sheet.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Transactions'),
            actions: [
              PopupMenuButton<String>(
                icon: const Icon(Icons.filter_list),
                onSelected: (value) {
                  if (value == 'filter') {
                    controller.showFilterBottomSheet();
                  }
                },
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: 'filter',
                    child: Text('Filter'),
                  ),
                ],
              ),
            ],
          ),
      body: Obx((){
        controller.isLoading.value;
        if (controller.isLoading.value) {
          return const LoadingView(message: 'Loading transactions...');
        }
        
        return Column(
          children: [
            // Search and filter section
            _buildSearchAndFilterSection(),
            
            // Statistics section
            _buildStatisticsSection(),
            
            // Transactions list
            Expanded(
              child: RefreshIndicator(
                onRefresh: controller.refreshTransactions,
                child: controller.filteredTransactions.isEmpty
                    ? _buildEmptyState()
                    : _buildTransactionsList(),
              ),
            ),
          ],
        );
      }),
        );
      }
    );
  }

  Widget _buildSearchAndFilterSection() {
    return Obx(() {
      controller.isLoading.value;
      return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Get.theme.colorScheme.surface,
        border: Border(
          bottom: BorderSide(
            color: Get.theme.colorScheme.outline,
            width: 1,
          ),
        ),
      ),
      child: Column(
        children: [
          // Search bar
          TextField(
            onChanged: controller.searchTransactions,
            decoration: InputDecoration(
              hintText: 'Search transactions...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: Obx((){
                controller.searchQuery.value;
                return controller.searchQuery.value.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: controller.clearSearch,
                    )
                  : const SizedBox.shrink();
              }),
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Filter summary and clear button
          Obx((){
            controller.filterSummary;
            return Row(
            children: [
              Expanded(
                child: Text(
                  controller.filterSummary,
                  style: Get.theme.textTheme.bodySmall?.copyWith(
                    color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
              if (controller.hasActiveFilters)
                TextButton(
                  onPressed: controller.clearAllFilters,
                  child: Text(
                    'Clear all',
                    style: AppTextStyles.buttonMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          );
        }),
        ],
      ),
    );
    });
  }

  Widget _buildStatisticsSection() {
    return Obx((){
      controller.transactionStats;
      final stats = controller.transactionStats;
      final income = stats['income'] ?? 0.0;
      final expenses = stats['expenses'] ?? 0.0;
      final total = stats['total'] ?? 0.0;
      
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.surfaceVariant,
          border: Border(
            bottom: BorderSide(
              color: AppColors.outline,
              width: 1,
            ),
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: _buildStatItem(
                'Income',
                '\$${income.toStringAsFixed(2)}',
                AppColors.income,
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: AppColors.outline,
            ),
            Expanded(
              child: _buildStatItem(
                'Expenses',
                '\$${expenses.toStringAsFixed(2)}',
                AppColors.expense,
              ),
            ),
            Container(
              width: 1,
              height: 40,
              color: AppColors.outline,
            ),
            Expanded(
              child: _buildStatItem(
                'Net',
                '\$${total.toStringAsFixed(2)}',
                total >= 0 ? AppColors.income : AppColors.expense,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildStatItem(String label, String amount, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Text(
            label,
            style: Get.theme.textTheme.bodySmall?.copyWith(
              color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            amount,
            style: Get.theme.textTheme.bodyMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: controller.filteredTransactions.length,
      itemBuilder: (context, index) {
        final transaction = controller.filteredTransactions[index];
        final isLast = index == controller.filteredTransactions.length - 1;
        
        return Column(
          children: [
            TransactionTile(
              transaction: transaction,
              onTap: () => controller.onTransactionTap(transaction),
            ),
            if (!isLast)
              const Divider(height: 1),
          ],
        );
      },
    );
  }

  Widget _buildEmptyState() {
    if (controller.hasActiveFilters) {
      return const EmptyFilterResultsState(
        onClearFilters: null, // Will be set in the widget
      );
    } else {
      return const EmptyTransactionsState(
        onAddTransaction: null, // Will be set in the widget
      );
    }
  }
}
