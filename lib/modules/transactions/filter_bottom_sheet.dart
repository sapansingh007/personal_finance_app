import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import 'transactions_controller.dart';

class FilterBottomSheet extends GetView<TransactionsController> {
  const FilterBottomSheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.textTertiary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Transactions',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: controller.clearAllFilters,
                  child: Text(
                    'Reset',
                    style: AppTextStyles.buttonMedium.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Transaction type filter
          _buildTransactionTypeFilter(),
          
          const SizedBox(height: 32),
          
          // Date range filter
          _buildDateRangeFilter(),
          
          const SizedBox(height: 32),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: SecondaryButton(
                    text: 'Cancel',
                    onPressed: () => Get.back(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    text: 'Apply Filters',
                    onPressed: () {
                      controller.applyFilters();
                      Get.back();
                    },
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTransactionTypeFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaction Type',
            style: Get.theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Obx((){
            controller.selectedFilterType.value;
            return Row(
            children: [
              Expanded(
                child: _buildFilterChip(
                  'All',
                  controller.selectedFilterType.value == FilterType.all,
                  () => controller.updateFilterType(FilterType.all),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilterChip(
                  'Income',
                  controller.selectedFilterType.value == FilterType.income,
                  () => controller.updateFilterType(FilterType.income),
                  AppColors.income,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilterChip(
                  'Expense',
                  controller.selectedFilterType.value == FilterType.expense,
                  () => controller.updateFilterType(FilterType.expense),
                  AppColors.expense,
                ),
              ),
            ],
          );
        }),
        ],
      ),
    );
  }

  Widget _buildDateRangeFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date Range',
            style: Get.theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Obx((){
            controller.selectedDateRange.value;
            return Column(
            children: [
              _buildDateRangeOption(
                'All time',
                controller.selectedDateRange.value == DateRangeType.all,
                () => controller.updateDateRange(DateRangeType.all),
              ),
              const SizedBox(height: 8),
              _buildDateRangeOption(
                'Last 7 days',
                controller.selectedDateRange.value == DateRangeType.last7Days,
                () => controller.updateDateRange(DateRangeType.last7Days),
              ),
              const SizedBox(width: 8),
              _buildDateRangeOption(
                'Last 30 days',
                controller.selectedDateRange.value == DateRangeType.last30Days,
                () => controller.updateDateRange(DateRangeType.last30Days),
              ),
              const SizedBox(width: 8),
              _buildDateRangeOption(
                'Last 3 months',
                controller.selectedDateRange.value == DateRangeType.last3Months,
                () => controller.updateDateRange(DateRangeType.last3Months),
              ),
            ],
          );
        }),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected, VoidCallback onTap, [Color? color]) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected 
              ? (color ?? AppColors.primary).withOpacity(0.1)
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected 
                ? (color ?? AppColors.primary)
                : AppColors.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: Get.theme.textTheme.bodyMedium?.copyWith(
            color: isSelected 
                ? (color ?? Get.theme.colorScheme.primary)
                : Get.theme.colorScheme.onSurface.withOpacity(0.7),
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangeOption(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected 
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.outline,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? AppColors.primary : AppColors.textTertiary,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: Get.theme.textTheme.bodyMedium?.copyWith(
                color: isSelected 
                    ? Get.theme.colorScheme.primary
                    : Get.theme.colorScheme.onSurface.withOpacity(0.7),
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
