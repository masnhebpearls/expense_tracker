import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/tittle_enum.dart';

class ExtendedBarGraph extends StatefulWidget {
  final tittle category;
  final IconData icon;

  const ExtendedBarGraph(
      {super.key, required this.category, required this.icon});

  @override
  State<ExtendedBarGraph> createState() => _ExtendedBarGraphState();
}

class _ExtendedBarGraphState extends State<ExtendedBarGraph> {
  @override


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Consumer<ExpenseProvider>(
      builder: (context, expenseProvider, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            height > width ? width * 0.035 : width * 0.01,
            height > width ? height * 0.0125 : height * 0.02,
            0,
            0,
          ),
          child: SizedBox(
            width: height > width ? width * 0.175 : width * 0.075,
            height: height > width ? height * 0.275 : height * 0.7,
            child: InkWell(
              onTap: (){
                print('Tapped');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  expenseProvider.getSum(widget.category).toInt() != 0
                      ? Center(
                          child: Text(
                            'Rs. ${expenseProvider.getSum(widget.category).toInt().toString()}',
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xff424874)),
                          ),
                        )
                      : const SizedBox(),
                  Container(
                    height: height > width ? height*0.17*(expenseProvider.getSum(widget.category) / expenseProvider.threshold): height*0.475*(expenseProvider.getSum(widget.category) / expenseProvider.threshold),
                    width: MediaQuery.of(context).size.width * 0.175,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(height > width
                              ? width *
                                  0.035 *
                                  (expenseProvider.getSum(widget.category) /
                                      expenseProvider.threshold)
                              : width *
                                  0.025 *
                                  (expenseProvider.getSum(widget.category) /
                                      expenseProvider.threshold)),
                          topRight: Radius.circular(width < height
                              ? width *
                                  0.035 *
                                  (expenseProvider.getSum(widget.category) /
                                      expenseProvider.threshold)
                              : width *
                                  0.025 *
                                  (expenseProvider.getSum(widget.category) /
                                      expenseProvider.threshold)),
                        ),
                        color: const Color(0xff9572d4)),
                  ),
                  Icon(
                    widget.icon,
                    size: 32,
                    color: const Color(0xff9572d4),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
