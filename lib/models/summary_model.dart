class Summary {
  final double totalBalance;
  final double monthlyIncome;
  final double monthlyExpenses;
  final int transactionCount;

  Summary({
    required this.totalBalance,
    required this.monthlyIncome,
    required this.monthlyExpenses,
    required this.transactionCount,
  });

  // Copy with method for immutability
  Summary copyWith({
    double? totalBalance,
    double? monthlyIncome,
    double? monthlyExpenses,
    int? transactionCount,
  }) {
    return Summary(
      totalBalance: totalBalance ?? this.totalBalance,
      monthlyIncome: monthlyIncome ?? this.monthlyIncome,
      monthlyExpenses: monthlyExpenses ?? this.monthlyExpenses,
      transactionCount: transactionCount ?? this.transactionCount,
    );
  }

  // From JSON
  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      totalBalance: (json['totalBalance'] as num).toDouble(),
      monthlyIncome: (json['monthlyIncome'] as num).toDouble(),
      monthlyExpenses: (json['monthlyExpenses'] as num).toDouble(),
      transactionCount: json['transactionCount'] as int,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'totalBalance': totalBalance,
      'monthlyIncome': monthlyIncome,
      'monthlyExpenses': monthlyExpenses,
      'transactionCount': transactionCount,
    };
  }

  // Get monthly savings (income - expenses)
  double get monthlySavings => monthlyIncome - monthlyExpenses;

  // Get formatted currency strings
  String get formattedTotalBalance => '\$${totalBalance.toStringAsFixed(2)}';
  String get formattedMonthlyIncome => '\$${monthlyIncome.toStringAsFixed(2)}';
  String get formattedMonthlyExpenses => '\$${monthlyExpenses.toStringAsFixed(2)}';
  String get formattedMonthlySavings => '\$${monthlySavings.toStringAsFixed(2)}';

  // Get balance status
  BalanceStatus get balanceStatus {
    if (totalBalance >= 1000) return BalanceStatus.good;
    if (totalBalance >= 0) return BalanceStatus.neutral;
    return BalanceStatus.low;
  }

  // Get savings rate percentage
  double get savingsRate {
    if (monthlyIncome == 0) return 0.0;
    return (monthlySavings / monthlyIncome) * 100;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Summary &&
        other.totalBalance == totalBalance &&
        other.monthlyIncome == monthlyIncome &&
        other.monthlyExpenses == monthlyExpenses &&
        other.transactionCount == transactionCount;
  }

  @override
  int get hashCode {
    return totalBalance.hashCode ^
        monthlyIncome.hashCode ^
        monthlyExpenses.hashCode ^
        transactionCount.hashCode;
  }

  @override
  String toString() {
    return 'Summary(totalBalance: $totalBalance, monthlyIncome: $monthlyIncome, monthlyExpenses: $monthlyExpenses)';
  }
}

enum BalanceStatus {
  good,
  neutral,
  low,
}
