import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../../core/widgets/primary_button.dart';
import '../../models/transaction_model.dart';

class TransactionDetailView extends GetView {
  const TransactionDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get transaction from arguments
    final transaction = Get.arguments as Transaction;
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {
              // TODO: Implement edit functionality
              Get.snackbar('Edit', 'Edit functionality not implemented');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount and type card
            _buildAmountCard(transaction),
            
            const SizedBox(height: 24),
            
            // Transaction details
            _buildTransactionDetails(transaction),
            
            const SizedBox(height: 24),
            
            // Additional information
            if (transaction.description != null && transaction.description!.isNotEmpty)
              _buildDescriptionSection(transaction),
            
            const SizedBox(height: 32),
            
            // Action buttons
            _buildActionButtons(transaction),
          ],
        ),
      ),
    );
  }

  Widget _buildAmountCard(Transaction transaction) {
    final isIncome = transaction.type == TransactionType.income;
    final amountColor = isIncome ? AppColors.income : AppColors.expense;
    
    return Card(
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.15),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Transaction type icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: _getCategoryColor(transaction).withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                _getCategoryIcon(transaction),
                size: 32,
                color: _getCategoryColor(transaction),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Amount
            Text(
              transaction.formattedAmount,
              style: AppTextStyles.amountLarge.copyWith(
                color: amountColor,
              ),
            ),
            
            const SizedBox(height: 8),
            
            // Transaction type
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: amountColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                isIncome ? 'Income' : 'Expense',
                style: AppTextStyles.label.copyWith(
                  color: amountColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionDetails(Transaction transaction) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transaction Details',
              style: Get.theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            
            _buildDetailRow(
              'Title',
              transaction.title,
              Icons.title,
            ),
            
            _buildDetailRow(
              'Amount',
              transaction.formattedAmount,
              Icons.attach_money,
            ),
            
            _buildDetailRow(
              'Category',
              transaction.category.displayName,
              Icons.category,
            ),
            
            _buildDetailRow(
              'Date',
              transaction.formattedDate,
              Icons.calendar_today,
            ),
            
            _buildDetailRow(
              'Type',
              transaction.type.displayName,
              transaction.type == TransactionType.income 
                  ? Icons.arrow_upward 
                  : Icons.arrow_downward,
            ),
            
            const SizedBox(height: 16),
            
            _buildDetailRow(
              'Time',
              _formatTime(transaction.date),
              Icons.access_time,
            ),
            
            const SizedBox(height: 16),
            
            _buildDetailRow(
              'Transaction ID',
              transaction.id,
              Icons.tag,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, IconData icon, {Color? iconColor}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.surfaceVariant,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: iconColor ?? Get.theme.colorScheme.onSurfaceVariant,
          ),
        ),
        
        const SizedBox(width: 16),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Get.theme.textTheme.bodySmall?.copyWith(
                  color: Get.theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Get.theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionSection(Transaction transaction) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Notes',
              style: Get.theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              transaction.description!,
              style: Get.theme.textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(Transaction transaction) {
    return Column(
      children: [
        // Edit button
        SizedBox(
          width: double.infinity,
          child: PrimaryButton(
            text: 'Edit Transaction',
            onPressed: () {
              // TODO: Implement edit functionality
              Get.snackbar('Edit', 'Edit functionality not implemented');
            },
            icon: const Icon(Icons.edit_outlined, size: 20),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Delete button
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              _showDeleteConfirmation(transaction);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.error,
              side: const BorderSide(color: AppColors.error),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.delete_outline, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Delete Transaction',
                  style: AppTextStyles.buttonLarge.copyWith(
                    color: AppColors.error,
                  ),
                ),
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 12),
        
        // Share button
        SizedBox(
          width: double.infinity,
          child: SecondaryButton(
            text: 'Share',
            onPressed: () {
              // TODO: Implement share functionality
              Get.snackbar('Share', 'Share functionality not implemented');
            },
            icon: const Icon(Icons.share_outlined, size: 20),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(Transaction transaction) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Transaction'),
        content: Text(
          'Are you sure you want to delete "${transaction.title}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
              Get.back(); // Go back to transactions list
              Get.snackbar(
                'Deleted',
                'Transaction deleted successfully',
                backgroundColor: AppColors.success,
                colorText: Colors.white,
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(Transaction transaction) {
    switch (transaction.category) {
      case TransactionCategory.salary:
        return Icons.work;
      case TransactionCategory.freelance:
        return Icons.laptop;
      case TransactionCategory.investment:
        return Icons.trending_up;
      case TransactionCategory.food:
        return Icons.restaurant;
      case TransactionCategory.transport:
        return Icons.directions_car;
      case TransactionCategory.utilities:
        return Icons.power;
      case TransactionCategory.entertainment:
        return Icons.movie;
      case TransactionCategory.health:
        return Icons.fitness_center;
      case TransactionCategory.education:
        return Icons.school;
      case TransactionCategory.shopping:
        return Icons.shopping_bag;
      case TransactionCategory.other:
        return Icons.more_horiz;
    }
  }

  Color _getCategoryColor(Transaction transaction) {
    final colorIndex = transaction.category.index % AppColors.categoryColors.length;
    return AppColors.categoryColors[colorIndex];
  }

  String _formatFullDate(DateTime date) {
    final months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour.toString().padLeft(2, '0');
    final minute = date.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
