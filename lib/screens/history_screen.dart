import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ประวัติการเพิ่มและลบ',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close,
              color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          var transactions =
              provider.getTransactionHistory();
          if (transactions.isEmpty) {
            return const Center(child: Text('ไม่มีประวัติการเพิ่มและลบ'));
          } else {
            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                var transaction = transactions[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                  child: ListTile(
                    title: Text(transaction.title),
                    subtitle: Text('จำนวน: ${transaction.amount}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        provider.deleteTransaction(
                            transaction.keyID);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
