import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Consumer<ExpenseProvider>(
      builder: (context, expenseProvider, state) {
        return Padding(
          padding: EdgeInsets.fromLTRB(
            width < height ? width * 0.035 : width * 0.01,
            width < height ? height * 0.0125 : height * 0.02,
            0,
            0,
          ),
          child: SizedBox(
            width: width < height ? width * 0.175 : width * 0.075,
            height: width < height ? height * 0.275 : height * 0.525,
            child: Column(
              mainAxisAlignment: width < height
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.center,
              children: [
                expenseProvider.getSum(widget.category).toInt() !=0 ? Center(
                  child: Text('Rs. ${expenseProvider.getSum(widget.category).toInt().toString()}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xff424874)
                  ),
                  ),
                ): const SizedBox(),
                Container(
                  height: MediaQuery.of(context).size.height *
                      0.16 *
                      (expenseProvider.getSum(widget.category) /
                          expenseProvider.threshold),
                  width: MediaQuery.of(context).size.width * 0.175,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(width < height
                            ? width *
                                0.035 *
                                (expenseProvider.getSum(widget.category) /
                                    expenseProvider.threshold)
                            : width *
                                0.01 *
                                (expenseProvider.getSum(widget.category) /
                                    expenseProvider.threshold)),
                        topRight: Radius.circular(width < height
                            ? width *
                                0.035 *
                                (expenseProvider.getSum(widget.category) /
                                    expenseProvider.threshold)
                            : width *
                                0.01 *
                                (expenseProvider.getSum(widget.category) /
                                    expenseProvider.threshold)),
                      ),
                      color: const Color(0xff9572d4)),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      0,
                      width < height ? height * 0.025 : height * 0.35,
                      0,
                      width < height ? height * 0.025 : height * 0.35),
                  child: Icon(
                    widget.icon,
                    size: 32,
                    color: const Color(0xff9572d4),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
