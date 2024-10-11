import 'package:account/provider/transaction_provider.dart';
import 'package:account/screens/edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/A2.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            if (provider.transactions.isEmpty) {
              return const Center(
                child: Text('ไม่มีรายการ'),
              );
            } else {
              return ListView.builder(
                itemCount: provider.transactions.length,
                itemBuilder: (context, index) {
                  var statement = provider.transactions[index];
                  return Card(
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              image: const DecorationImage(
                                image: AssetImage(
                                    'images/A1.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        ListTile(
                          title: _buildShadowedText(
                              statement),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors
                                .black54,
                            child: FittedBox(
                              child: Text('${statement.amount}',
                                  style: const TextStyle(
                                      color: Colors.white)),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete,
                                color: Colors.red),
                            onPressed: () {
                              provider.deleteTransaction(statement.keyID);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return EditScreen(statement: statement);
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildShadowedText(var statement) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(136, 0, 0, 0),
        borderRadius: BorderRadius.circular(5),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            statement.title,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          Text(
            'ชื่อ: ${statement.title1}',
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          Text(
            'ประเภท: ${statement.title2}',
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          Text(
            'แคตาล็อก: ${statement.title3}',
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
          Text(
            DateFormat('dd MMM yyyy hh:mm:ss').format(statement.date),
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.black54,
                  offset: Offset(1, 1),
                  blurRadius: 5.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
