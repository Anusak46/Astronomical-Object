import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  void _showTransactionDetails(BuildContext context, transaction) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(transaction.title, textAlign: TextAlign.left),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ชื่อวัตถุ: ${transaction.title1}',
                  textAlign: TextAlign.left),
              Text('ประเภท: ${transaction.title2}', textAlign: TextAlign.left),
              Text('แคตาล็อก: ${transaction.title3}',
                  textAlign: TextAlign.left),
              Text('ลำดับวัตถุ: ${transaction.amount}',
                  textAlign: TextAlign.left),
              Text('วันที่: ${transaction.date}', textAlign: TextAlign.left),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("ปิด"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ประวัติการเพิ่มและลบ',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromARGB(255, 56, 56, 56),
      ),
      body: Consumer<TransactionProvider>(
        builder: (context, provider, child) {
          var currentTransactions = provider.getTransaction();
          var deletedTransactions = provider.getDeletedTransactions();

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'รายการที่มีอยู่',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              Expanded(
                child: currentTransactions.isEmpty
                    ? const Center(child: Text('ไม่มีรายการที่มีอยู่'))
                    : ListView.builder(
                        itemCount: currentTransactions.length,
                        itemBuilder: (context, index) {
                          var transaction = currentTransactions[index];
                          return Card(
                            color: Colors.grey[200],
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            child: ListTile(
                              title: Text(
                                transaction.title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'ชื่อวัตถุ: ${transaction.title1}',
                                style: const TextStyle(color: Colors.black54),
                              ),
                              onTap: () {
                                _showTransactionDetails(context, transaction);
                              },
                            ),
                          );
                        },
                      ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'รายการที่ถูกลบ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                ),
              ),
              Expanded(
                child: deletedTransactions.isEmpty
                    ? const Center(child: Text('ไม่มีรายการที่ถูกลบ'))
                    : ListView.builder(
                        itemCount: deletedTransactions.length,
                        itemBuilder: (context, index) {
                          var transaction = deletedTransactions[index];
                          return Card(
                            color: Colors.red[100],
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 8),
                            child: ListTile(
                              title: Text(
                                transaction.title,
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                'ชื่อวัตถุ: ${transaction.title1}',
                                style: const TextStyle(color: Colors.redAccent),
                              ),
                              trailing: IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  provider.deleteTransaction(transaction.keyID);
                                },
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
