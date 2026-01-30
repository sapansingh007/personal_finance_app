import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final String? actionText;
  final VoidCallback? onAction;
  final Widget? customIllustration;

  const EmptyState({
    Key? key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.inbox_outlined,
    this.actionText,
    this.onAction,
    this.customIllustration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Illustration or icon
            if (customIllustration != null)
              customIllustration!
            else
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(60),
                ),
                child: Icon(
                  icon,
                  size: 48,
                  color: AppColors.textTertiary,
                ),
              ),
            
            const SizedBox(height: 24),
            
            // Title
            Text(
              title,
              style: AppTextStyles.h4.copyWith(
                color: Get.theme.colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: AppTextStyles.bodyMedium.copyWith(
                color: Get.theme.colorScheme.onSurface.withOpacity(0.7),
              ),
              textAlign: TextAlign.center,
            ),
            
            if (actionText != null && onAction != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onAction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text(
                  actionText!,
                  style: AppTextStyles.buttonMedium,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// Specialized empty states
class EmptyTransactionsState extends StatelessWidget {
  final VoidCallback? onAddTransaction;

  const EmptyTransactionsState({
    Key? key,
    this.onAddTransaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      title: 'No transactions yet',
      subtitle: 'Your transactions will appear here once you start tracking your finances.',
      icon: Icons.receipt_long_outlined,
      actionText: 'Add Transaction',
      onAction: onAddTransaction,
    );
  }
}

class EmptyFilterResultsState extends StatelessWidget {
  final VoidCallback? onClearFilters;

  const EmptyFilterResultsState({
    Key? key,
    this.onClearFilters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      title: 'No transactions found',
      subtitle: 'Try adjusting your filters or check back later.',
      icon: Icons.filter_list_off,
      actionText: 'Clear Filters',
      onAction: onClearFilters,
    );
  }
}

class EmptySearchState extends StatelessWidget {
  final String searchTerm;
  final VoidCallback? onClearSearch;

  const EmptySearchState({
    Key? key,
    required this.searchTerm,
    this.onClearSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      title: 'No results for "$searchTerm"',
      subtitle: 'Try searching with different keywords.',
      icon: Icons.search_off,
      actionText: 'Clear Search',
      onAction: onClearSearch,
    );
  }
}

class NetworkErrorState extends StatelessWidget {
  final VoidCallback? onRetry;

  const NetworkErrorState({
    Key? key,
    this.onRetry,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyState(
      title: 'Something went wrong',
      subtitle: 'Unable to load data. Please check your connection and try again.',
      icon: Icons.wifi_off,
      actionText: 'Retry',
      onAction: onRetry,
    );
  }
}
