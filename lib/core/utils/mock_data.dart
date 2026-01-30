import '../../models/transaction_model.dart';
import '../../models/summary_model.dart';

class MockData {
  // Mock transactions
  static List<Transaction> getTransactions() {
    return [
      Transaction(
        id: '1',
        title: 'Grocery Shopping',
        amount: 125.50,
        category: TransactionCategory.food,
        type: TransactionType.expense,
        date: DateTime.now().subtract(const Duration(days: 1)),
        description: 'Weekly grocery shopping at supermarket',
      ),
      Transaction(
        id: '2',
        title: 'Salary',
        amount: 3500.00,
        category: TransactionCategory.salary,
        type: TransactionType.income,
        date: DateTime.now().subtract(const Duration(days: 2)),
        description: 'Monthly salary deposit',
      ),
      Transaction(
        id: '3',
        title: 'Electric Bill',
        amount: 89.75,
        category: TransactionCategory.utilities,
        type: TransactionType.expense,
        date: DateTime.now().subtract(const Duration(days: 3)),
        description: 'Monthly electricity payment',
      ),
      Transaction(
        id: '4',
        title: 'Freelance Project',
        amount: 750.00,
        category: TransactionCategory.freelance,
        type: TransactionType.income,
        date: DateTime.now().subtract(const Duration(days: 5)),
        description: 'Web design project payment',
      ),
      Transaction(
        id: '5',
        title: 'Restaurant',
        amount: 45.30,
        category: TransactionCategory.food,
        type: TransactionType.expense,
        date: DateTime.now().subtract(const Duration(days: 6)),
        description: 'Dinner with friends',
      ),
      Transaction(
        id: '6',
        title: 'Gas Station',
        amount: 65.00,
        category: TransactionCategory.transport,
        type: TransactionType.expense,
        date: DateTime.now().subtract(const Duration(days: 7)),
        description: 'Car fuel refill',
      ),
      Transaction(
        id: '7',
        title: 'Online Course',
        amount: 199.99,
        category: TransactionCategory.education,
        type: TransactionType.expense,
        date: DateTime.now().subtract(const Duration(days: 8)),
        description: 'Flutter development course',
      ),
      Transaction(
        id: '8',
        title: 'Investment Return',
        amount: 320.50,
        category: TransactionCategory.investment,
        type: TransactionType.income,
        date: DateTime.now().subtract(const Duration(days: 10)),
        description: 'Stock market dividend',
      ),
      Transaction(
        id: '9',
        title: 'Netflix Subscription',
        amount: 15.99,
        category: TransactionCategory.entertainment,
        type: TransactionType.expense,
        date: DateTime.now().subtract(const Duration(days: 12)),
        description: 'Monthly streaming service',
      ),
      Transaction(
        id: '10',
        title: 'Coffee Shop',
        amount: 12.45,
        category: TransactionCategory.food,
        type: TransactionType.expense,
        date: DateTime.now().subtract(const Duration(days: 14)),
        description: 'Morning coffee and pastry',
      ),
      Transaction(
        id: '11',
        title: 'Bonus',
        amount: 500.00,
        category: TransactionCategory.salary,
        type: TransactionType.income,
        date: DateTime.now().subtract(const Duration(days: 15)),
        description: 'Quarterly performance bonus',
      ),
      Transaction(
        id: '12',
        title: 'Gym Membership',
        amount: 49.99,
        category: TransactionCategory.health,
        type: TransactionType.expense,
        date: DateTime.now().subtract(const Duration(days: 20)),
        description: 'Monthly gym membership fee',
      ),
    ];
  }
  
  // Mock summary data
  static Summary getSummary() {
    final transactions = getTransactions();
    final now = DateTime.now();
    final currentMonth = DateTime(now.year, now.month, 1);
    
    final monthlyTransactions = transactions.where((t) => 
      t.date.isAfter(currentMonth.subtract(const Duration(days: 1)))
    ).toList();
    
    final monthlyIncome = monthlyTransactions
        .where((t) => t.type == TransactionType.income)
        .fold(0.0, (sum, t) => sum + t.amount);
        
    final monthlyExpenses = monthlyTransactions
        .where((t) => t.type == TransactionType.expense)
        .fold(0.0, (sum, t) => sum + t.amount);
    
    final totalBalance = transactions
        .fold(0.0, (sum, t) => 
          t.type == TransactionType.income ? sum + t.amount : sum - t.amount);
    
    return Summary(
      totalBalance: totalBalance,
      monthlyIncome: monthlyIncome,
      monthlyExpenses: monthlyExpenses,
      transactionCount: transactions.length,
    );
  }
  
  // Mock user credentials for demo
  static const String demoEmail = 'user@example.com';
  static const String demoPassword = 'password123';
}
