import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function removeTransaction;

  const TransactionList({
    super.key,
    required this.transactions,
    required this.removeTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: [
                    Text(
                      'No transaction added yet',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: constraints.maxHeight * 0.7,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 15,
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                          child: Text(
                            '\$${transactions[index].amount}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              // fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    subtitle: Text(
                        DateFormat.yMMMd().format(transactions[index].date)),
                    trailing: MediaQuery.of(context).size.width > 400
                        ? TextButton.icon(
                            onPressed: () =>
                                removeTransaction(transactions[index].id),
                            icon: const Icon(Icons.delete),
                            style: TextButton.styleFrom(
                              primary: Theme.of(context).errorColor,
                            ),
                            label: const Text('Delete'),
                          )
                        : IconButton(
                            onPressed: () =>
                                removeTransaction(transactions[index].id),
                            icon: const Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                          ),
                  ),
                );
                // return Card(
                //   elevation: 0.3,
                //   child: Row(
                //     children: [
                //       Container(
                //         margin: const EdgeInsets.symmetric(
                //           vertical: 10,
                //           horizontal: 15,
                //         ),
                //         padding: const EdgeInsets.all(10),
                //         decoration: ShapeDecoration(
                //           shape: Border.all(
                //             color: Theme.of(context).colorScheme.primary,
                //             width: 2.0,
                //           ),
                //         ),
                //         child: Text(
                //           '\$${transactions[index].amount.toStringAsFixed(2)}',
                //           style: TextStyle(
                //             color: Theme.of(context).colorScheme.primary,
                //             fontSize: 20,
                //             fontWeight: FontWeight.bold,
                //           ),
                //         ),
                //       ),
                //       Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           Text(
                //             transactions[index].title,
                //             style: Theme.of(context).textTheme.titleMedium,
                //           ),
                //           Text(
                //             DateFormat('yMMMEd')
                //                 .format(transactions[index].date),
                //             style: const TextStyle(
                //               color: Colors.grey,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ],
                //   ),
                // );
              },
            ),
    );
  }
}
