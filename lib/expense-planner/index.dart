import 'dart:io';

import 'package:flutter/cupertino.dart';
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
  final List<Transaction> _userTransactions = [];
  bool _showChart = false;

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
      // isScrollControlled: true,
      builder: (_) {
        return AddTransaction(_addTransaction);
      },
    );
  }

  void _removeTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((element) => element.id == id);
    });
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
    final PreferredSizeWidget appBar = Platform.isIOS
        ? PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: CupertinoNavigationBar(
              middle: const Text('Personal Expenses'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () => _startAddTransaction(context),
                    child: const Icon(CupertinoIcons.add),
                  ),
                ],
              ),
            ),
          )
        : PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: AppBar(
              title: const Text('Personal Expenses'),
              actions: [
                Builder(
                  builder: (context) => IconButton(
                    onPressed: () => _startAddTransaction(context),
                    icon: const Icon(Icons.add),
                  ),
                ),
              ],
            ),
          );

    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
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
      home: Builder(builder: (context) {
        final mediaQuery = MediaQuery.of(context);
        final isLandscape = mediaQuery.orientation == Orientation.landscape;
        final txListWidget = Container(
          height: (mediaQuery.size.height -
                  appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              0.7,
          child: TransactionList(
            transactions: _userTransactions,
            removeTransaction: _removeTransaction,
          ),
        );

        final pageBody = SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isLandscape)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text('Show Chart', style: Theme.of(context).textTheme.titleMedium,),
                      Switch.adaptive(
                        value: _showChart,
                        onChanged: (value) {
                          setState(() {
                            _showChart = value;
                          });
                        },
                      ),
                    ],
                  ),
                if (!isLandscape)
                  SizedBox(
                    height: (mediaQuery.size.height -
                            appBar.preferredSize.height -
                            mediaQuery.padding.top) *
                        0.3,
                    child: Chart(
                      recentTransactions: _recentTransactions,
                    ),
                  ),
                if (!isLandscape) txListWidget,
                if (isLandscape)
                  _showChart
                      ? SizedBox(
                          height: (mediaQuery.size.height -
                                  appBar.preferredSize.height -
                                  mediaQuery.padding.top) *
                              0.6,
                          child: Chart(
                            recentTransactions: _recentTransactions,
                          ),
                        )
                      : txListWidget,
              ],
            ),
          ),
        );

        return
        // Platform.isIOS
        //     ? CupertinoPageScaffold(
        //         // navigationBar: appBar,
        //         child: pageBody,
        //       )
        //     :
            Scaffold(
                appBar: appBar,
                body: pageBody,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: Builder(
                  builder: (ctx) => FloatingActionButton(
                    child: const Icon(Icons.add),
                    onPressed: () => _startAddTransaction(ctx),
                  ),
                ),
              );
      }),
    );
  }
}
