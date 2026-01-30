import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/utils/mock_data.dart';
import '../../models/transaction_model.dart';
import '../../routes/app_routes.dart';
import 'filter_bottom_sheet.dart';

enum FilterType {
  all,
  income,
  expense,
}

enum DateRangeType {
  all,
  last7Days,
  last30Days,
  last3Months,
}

class TransactionsController extends GetxController {
  // Reactive variables
  final isLoading = true.obs;
  final isRefreshing = false.obs;
  final allTransactions = <Transaction>[].obs;
  final filteredTransactions = <Transaction>[].obs;
  final searchQuery = ''.obs;
  
  // Filter variables
  final selectedFilterType = FilterType.all.obs;
  final selectedDateRange = DateRangeType.all.obs;
  
  @override
  void onInit() {
    super.onInit();
    loadTransactions();
    
    // Check for initial filter arguments
    final arguments = Get.arguments as Map<String, dynamic>? ?? {};
    if (arguments.containsKey('filter')) {
      final filter = arguments['filter'] as String?;
      if (filter == 'income') {
        selectedFilterType.value = FilterType.income;
      } else if (filter == 'expense') {
        selectedFilterType.value = FilterType.expense;
      }
      applyFilters();
    }
  }
  
  // Load all transactions
  Future<void> loadTransactions() async {
    try {
      isLoading.value = true;
      
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 800));
      
      // Load mock data
      final transactions = MockData.getTransactions();
      allTransactions.assignAll(transactions);
      
      // Apply initial filters
      applyFilters();
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to load transactions',
        backgroundColor: Get.theme.colorScheme.error,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Refresh transactions
  Future<void> refreshTransactions() async {
    isRefreshing.value = true;
    await loadTransactions();
    isRefreshing.value = false;
  }
  
  // Apply all filters
  void applyFilters() {
    filteredTransactions.clear();
    
    var transactions = List<Transaction>.from(allTransactions);
    
    // Apply type filter
    if (selectedFilterType.value == FilterType.income) {
      transactions = transactions.where((t) => t.type == TransactionType.income).toList();
    } else if (selectedFilterType.value == FilterType.expense) {
      transactions = transactions.where((t) => t.type == TransactionType.expense).toList();
    }
    
    // Apply date range filter
    final now = DateTime.now();
    switch (selectedDateRange.value) {
      case DateRangeType.last7Days:
        transactions = transactions.where((t) => 
          t.date.isAfter(now.subtract(const Duration(days: 7)))
        ).toList();
        break;
      case DateRangeType.last30Days:
        transactions = transactions.where((t) => 
          t.date.isAfter(now.subtract(const Duration(days: 30)))
        ).toList();
        break;
      case DateRangeType.last3Months:
        transactions = transactions.where((t) => 
          t.date.isAfter(now.subtract(const Duration(days: 90)))
        ).toList();
        break;
      case DateRangeType.all:
        // No date filter
        break;
    }
    
    // Apply search filter
    if (searchQuery.value.isNotEmpty) {
      transactions = transactions.where((t) => 
        t.title.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        t.categoryDisplayName.toLowerCase().contains(searchQuery.value.toLowerCase()) ||
        t.description?.toLowerCase().contains(searchQuery.value.toLowerCase()) == true
      ).toList();
    }
    
    // Sort by date (most recent first)
    transactions.sort((a, b) => b.date.compareTo(a.date));
    
    filteredTransactions.assignAll(transactions);
  }
  
  // Search transactions
  void searchTransactions(String query) {
    searchQuery.value = query;
    applyFilters();
  }
  
  // Clear search
  void clearSearch() {
    searchQuery.value = '';
    applyFilters();
  }
  
  // Update filter type
  void updateFilterType(FilterType type) {
    selectedFilterType.value = type;
    applyFilters();
  }
  
  // Update date range
  void updateDateRange(DateRangeType range) {
    selectedDateRange.value = range;
    applyFilters();
  }
  
  // Clear all filters
  void clearAllFilters() {
    selectedFilterType.value = FilterType.all;
    selectedDateRange.value = DateRangeType.all;
    searchQuery.value = '';
    applyFilters();
  }
  
  // Navigate to transaction detail
  void onTransactionTap(Transaction transaction) {
    Get.toNamed(
      Routes.transactionDetail,
      arguments: transaction,
    );
  }
  
  // Show filter bottom sheet
  void showFilterBottomSheet() {
    Get.bottomSheet(
      const FilterBottomSheet(),
      isScrollControlled: true,
    );
  }
  
  // Get filter summary text
  String get filterSummary {
    final filters = <String>[];
    
    if (selectedFilterType.value != FilterType.all) {
      filters.add(selectedFilterType.value.name);
    }
    
    if (selectedDateRange.value != DateRangeType.all) {
      switch (selectedDateRange.value) {
        case DateRangeType.last7Days:
          filters.add('Last 7 days');
          break;
        case DateRangeType.last30Days:
          filters.add('Last 30 days');
          break;
        case DateRangeType.last3Months:
          filters.add('Last 3 months');
          break;
        default:
          break;
      }
    }
    
    if (searchQuery.value.isNotEmpty) {
      filters.add('Search: "${searchQuery.value}"');
    }
    
    if (filters.isEmpty) {
      return 'All transactions';
    }
    
    return '${filters.length} filter${filters.length > 1 ? 's' : ''} applied';
  }
  
  // Get transaction statistics
  Map<String, double> get transactionStats {
    final income = filteredTransactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
        
    final expenses = filteredTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
    
    return {
      'income': income,
      'expenses': expenses,
      'total': income - expenses,
    };
  }
  
  // Check if any filters are active
  bool get hasActiveFilters {
    return selectedFilterType.value != FilterType.all ||
           selectedDateRange.value != DateRangeType.all ||
           searchQuery.value.isNotEmpty;
  }
}
