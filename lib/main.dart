import 'package:account/screens/form_screen.dart';
import 'package:account/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:account/provider/transaction_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) {
          return TransactionProvider();
        }),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<TransactionProvider>(context, listen: false).initData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Text("Astronomical Object"),
          actions: [
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              color: Colors.red,
              onPressed: () {
                SystemNavigator.pop();
              },
            ),
          ],
        ),
        body: Container(
          color: const Color.fromARGB(255, 32, 32, 32),
          child: const Column(
            children: [
              TabBar(
                labelColor: Color.fromARGB(255, 255, 255, 255),
                unselectedLabelColor: Color.fromARGB(255, 153, 153, 153),
                indicatorColor: Color.fromARGB(255, 255, 255, 255),
                tabs: [
                  Tab(
                    text: "วัตถุท้องฟ้า",
                    icon: Icon(Icons.public),
                  ),
                  Tab(
                    text: "เพิ่มวัตถุ",
                    icon: Icon(Icons.add_circle_outline),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    HomeScreen(),
                    FormScreen(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
