class ExpenseModel {
  final String id;
  final String title;
  final double amount;
  final String currency;
  final String paidBy;
  final Map<String, double> splitAmong;
  final bool isSettled;
  final DateTime createdAt;

  ExpenseModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.currency,
    required this.paidBy,
    required this.splitAmong,
    required this.isSettled,
    required this.createdAt,
  });

  factory ExpenseModel.fromMap(Map<String, dynamic> map, String id) {
    return ExpenseModel(
      id: id,
      title: map['title'] ?? '',
      amount: (map['amount'] ?? 0).toDouble(),
      currency: map['currency'] ?? 'USD',
      paidBy: map['paidBy'] ?? '',
      splitAmong: Map<String, double>.from(
        (map['splitAmong'] as Map<String, dynamic>? ?? {}).map(
          (k, v) => MapEntry(k, (v as num).toDouble()),
        ),
      ),
      isSettled: map['isSettled'] ?? false,
      createdAt: (map['createdAt'] as dynamic)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'amount': amount,
      'currency': currency,
      'paidBy': paidBy,
      'splitAmong': splitAmong,
      'isSettled': isSettled,
      'createdAt': createdAt,
    };
  }
}
