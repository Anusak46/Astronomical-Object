import 'package:account/main.dart';
import 'package:account/models/transactions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final name = TextEditingController();
  final type = TextEditingController();
  final Catalog = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'แบบฟอร์มเพิ่มข้อมูล วัตถุท้องฟ้า',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 61, 61, 61),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/A3.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'รหัสวัตถุ',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: false,
                    controller: titleController,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'กรุณากรอกข้อมูล';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ชื่อวัตถุ',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: false,
                    controller: name,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'กรุณากรอกข้อมูล';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ประเภท',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: false,
                    controller: type,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'กรุณากรอกข้อมูล';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'แคตาล็อก',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    autofocus: false,
                    controller: Catalog,
                    validator: (String? str) {
                      if (str!.isEmpty) {
                        return 'กรุณากรอกข้อมูล';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'ลำดับวัตถุ',
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    validator: (String? input) {
                      try {
                        double amount = double.parse(input!);
                        if (amount < 0) {
                          return 'กรุณากรอกข้อมูลมากกว่า 0';
                        }
                      } catch (e) {
                        return 'กรุณากรอกข้อมูลเป็นตัวเลข';
                      }
                    },
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 0, 0, 0),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    ),
                    child: const Text(
                      'บันทึก',
                      style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        var statement = Transactions(
                          keyID: null,
                          title: titleController.text,
                          title1: name.text,
                          title2: type.text,
                          title3: Catalog.text,
                          amount: double.parse(amountController.text),
                          date: DateTime.now(),
                        );

                        var provider = Provider.of<TransactionProvider>(context,
                            listen: false);
                        provider.addTransaction(statement);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) {
                              return const MyHomePage();
                            },
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
