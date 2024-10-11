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
  bool isAscending = true;
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  String _selectedCategory = 'ทั้งหมด';

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
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 56, 56, 56),
          elevation: 0,
          toolbarHeight: 40,
          title: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.white, size: 18),
                      const SizedBox(width: 5),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'ค้นหา...',
                            hintStyle:
                                TextStyle(color: Colors.white70, fontSize: 14),
                            border: InputBorder.none,
                          ),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                          onChanged: (text) {
                            setState(() {
                              _searchText = text;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  dropdownColor: Colors.grey[800],
                  underline: const SizedBox(),
                  icon:
                      const Icon(Icons.category, color: Colors.white, size: 18),
                  items: <String>[
                    'ทั้งหมด',
                    'Star',
                    'Galaxy',
                    'Nebula',
                    'Globular Cluster',
                    'Planet'
                  ].map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(
                        category,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: IconButton(
                  icon: Icon(
                    isAscending ? Icons.arrow_upward : Icons.arrow_downward,
                    color: Colors.white,
                    size: 18,
                  ),
                  onPressed: () {
                    setState(() {
                      isAscending = !isAscending;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        body: Consumer<TransactionProvider>(
          builder: (context, provider, child) {
            if (provider.transactions.isEmpty) {
              return const Center(
                child: Text('ไม่มีรายการ'),
              );
            } else {
              var filteredTransactions =
                  provider.transactions.where((transaction) {
                bool matchesSearchText =
                    transaction.title.contains(_searchText) ||
                        transaction.title2.contains(_searchText);
                bool matchesCategory = _selectedCategory == 'ทั้งหมด' ||
                    transaction.title2 == _selectedCategory;
                return matchesSearchText && matchesCategory;
              }).toList();

              filteredTransactions.sort((a, b) => isAscending
                  ? a.amount.compareTo(b.amount)
                  : b.amount.compareTo(a.amount));

              return ListView.builder(
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  var statement = filteredTransactions[index];
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
                                image: AssetImage('images/A1.png'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        ListTile(
                          title: _buildShadowedText(statement),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.black54,
                            child: FittedBox(
                              child: Text('${statement.amount}',
                                  style: const TextStyle(color: Colors.white)),
                            ),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
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
