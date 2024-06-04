import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExtendedExpenseCard extends StatefulWidget {
  final String title;
  final String amount;
  final String date;
  final IconData icon;
  final tittle? whichTitle;
  final String uniqueKey;
  const ExtendedExpenseCard({super.key, required this.icon,required this.amount, required this.title, required this.date, required this.whichTitle, required this.uniqueKey});

  @override
  State<ExtendedExpenseCard> createState() => _ExtendedExpenseCardState();
}

class _ExtendedExpenseCardState extends State<ExtendedExpenseCard> {
  String? newTitle;
  SnackBar?  snackBar;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      newTitle = widget.title;
    });
    snackBar = SnackBar(content: Text("Expense named $newTitle deleted successfully",
      style: const TextStyle(
          fontSize: 20
      ),
    )
    );

  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseProvider>(

  builder: (context,expenseProvider,state) {
    return Padding(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).size.height*0.025
      ),
      child: Container(
        width: MediaQuery.of(context).size.width*0.9,
        height: MediaQuery.of(context).size.height*0.125,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width*0.035),
          color: const Color(0xffe1d4f9)
        ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              left: MediaQuery.of(context).size.width*0.05
            ),
            child: SizedBox(
              width: MediaQuery.of(context).size.width*0.435,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(widget.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22
                  ),),
                  Row(
                    children: [
                      const Icon(Icons.currency_rupee, size: 16,),

                      Text(widget.amount.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                          fontWeight: FontWeight.w500,

                          color: Colors.black
                      ),),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(
              MediaQuery.of(context).size.width*0.025,
              0,
              MediaQuery.of(context).size.width*0,
                0

            ),
            child: Row(
              children: <Widget>[
                Icon(widget.icon),
                SizedBox(
                  width: MediaQuery.of(context).size.width*0.025,
                ),
                Text(
                    widget.date,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400
                ),
                )

              ],
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
