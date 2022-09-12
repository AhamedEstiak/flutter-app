import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spendingTotal;
  final double spendingPctOfTotal;

  const ChartBar({
    super.key,
    required this.label,
    required this.spendingTotal,
    required this.spendingPctOfTotal,
  });

  @override
  Widget build(BuildContext context) {
    print(spendingPctOfTotal);

    return Column(
      children: [
        Container(
          height: 20,
          child: FittedBox(
            child: Text(
              '\$${spendingTotal.toStringAsFixed(0)}',
            ),
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          width: 10,
          height: 60,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: Colors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromRGBO(220, 220, 220, 1),
                ),
              ),
              // spendingPctOfTotal need to between 0 - 1
              FractionallySizedBox(
                heightFactor: spendingPctOfTotal,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Text(label),
      ],
    );
  }
}
