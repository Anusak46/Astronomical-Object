import 'package:account/databases/transaction_db.dart';
import 'package:flutter/foundation.dart';
import 'package:account/models/transactions.dart';

class TransactionProvider with ChangeNotifier {
  List<Transactions> transactions = [];
  List<Transactions> transactionHistory = [];

  List<Transactions> getTransaction() {
    return transactions;
  }

  List<Transactions> getTransactionHistory() {
    return transactionHistory;
  }

  void initData() async {
    var db = await TransactionDB(dbName: 'transactions.db');
    this.transactions = await db.loadAllData();
    print(this.transactions);
    notifyListeners();
  }

  void addTransaction(Transactions transaction) async {
    var db = await TransactionDB(dbName: 'transactions.db');
    var keyID = await db.insertDatabase(transaction);
    this.transactions = await db.loadAllData();

    transactionHistory.add(transaction);
    print('Added transaction: $transaction');
    print(this.transactions);
    notifyListeners();
  }

  void deleteTransaction(int? index) async {
    if (index == null) return;

    var db = await TransactionDB(dbName: 'transactions.db');
    Transactions? deletedTransaction =
        transactions.firstWhere((t) => t.keyID == index);

    await db.deleteDatabase(index);

    transactionHistory.add(deletedTransaction);
    this.transactions = await db.loadAllData();
    print('Deleted transaction: $deletedTransaction');
    notifyListeners();
  }

  void updateTransaction(Transactions transaction) async {
    var db = await TransactionDB(dbName: 'transactions.db');
    await db.updateDatabase(transaction);
    this.transactions = await db.loadAllData();
    print('Updated transaction: $transaction');
    notifyListeners();
  }
}
