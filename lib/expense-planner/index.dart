import 'package:flutter/material.dart';

import './widgets/add_transaction.dart';
import './widgets/transaction_list.dart';
import './models/transaction.dart';
import './widgets/chart.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: 'tx1',
    //   title: 'New shoes',
    //   amount: 96.98,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 'tx2',
    //   title: 'Warriors of the day',
    //   amount: 45.49,
    //   date: DateTime.now(),
    // ),
  ];

  void _addTransaction(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (_) {
        return AddTransaction(_addTransaction);
      },
    );
  }

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          const Duration(days: 7),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.purple,
          secondary: Colors.amber,
        ),
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium: const TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
        appBarTheme: const AppBarTheme(
          // backgroundColor: Colors.red,
          // foregroundColor: Colors.green,
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Expense'),
          actions: [
            Builder(
              builder: (context) => IconButton(
                onPressed: () => _startAddTransaction(context),
                icon: const Icon(Icons.add),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Chart(recentTransactions: _recentTransactions),
              TransactionList(transactions: _userTransactions)
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Builder(
          builder: (ctx) => FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () => _startAddTransaction(ctx),
          ),
        ),
      ),
    );
  }
}
