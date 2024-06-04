import 'package:auto_route/annotations.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:expense_tracker/extended%20cards/expense_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../extended cards/extended_bar_graph.dart';
import '../extended cards/bottom_modal.dart';

@RoutePage()
class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final List<ExtendedBarGraph> listOfGraph = [
    const ExtendedBarGraph(category: tittle.General, icon: Icons.work),
    const ExtendedBarGraph(
        category: tittle.Foods, icon: Icons.emoji_food_beverage),
    const ExtendedBarGraph(category: tittle.Fuels, icon: Icons.pedal_bike),
    const ExtendedBarGraph(category: tittle.Misc, icon: Icons.add)
  ];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Consumer<ExpenseProvider>(
      builder: (context, expenseProvider, state) {
        return Scaffold(
          backgroundColor: const Color(0xffF4EEFF),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const ExtendedModalSheet();
                  });
            },
          ),
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Expense tracker",
              style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff424874)),
            ),
          ),
          body: expenseProvider.listOfCard.isNotEmpty
              ? SafeArea(
                  child: SingleChildScrollView(
                    child: height > width
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.025),
                                child: Center(
                                  child: Container(
                                    width: width * 0.9,
                                    height: height * 0.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.075),
                                        gradient: const LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                          colors: [
                                            Color(0xfff5f3f7),
                                            Color(0xffe0d6f0),
                                            Color(0xffd0c3ea),
                                            Color(0xffe1d4f9)
                                          ],
                                        )),
                                    child: Row(children: listOfGraph),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height: height * 0.5,
                                  width: width * 0.9,
                                  child: ListView.builder(
                                    itemCount:
                                    expenseProvider.listOfCard.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key:
                                        ValueKey(DateTime.now().toString()),
                                        onDismissed: (direction) {
                                          final expenseData = expenseProvider.listOfCard[index];
                                          expenseProvider.deleteItem(
                                              expenseProvider
                                                  .listOfCard[index].uniqueKey);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                              const Text("Deleted successfully"),
                                              action: SnackBarAction(
                                                label: "Undo",
                                                onPressed: () {
                                                  expenseProvider.undoDelete(
                                                      expenseData);
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        child: ExtendedExpenseCard(
                                            icon: expenseProvider.getIcon(
                                                expenseProvider
                                                    .listOfCard[index]
                                                    .whichTitle!),
                                            amount: expenseProvider
                                                .listOfCard[index].amount,
                                            title: expenseProvider
                                                .listOfCard[index].title,
                                            date: expenseProvider
                                                .listOfCard[index].date,
                                            whichTitle: expenseProvider
                                                .listOfCard[index].whichTitle,
                                            uniqueKey: expenseProvider
                                                .listOfCard[index].uniqueKey
                                                .toString()),
                                      );
                                    },
                                  )),
                              /*


               */
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.025),
                                child: Center(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.3,
                                    height: MediaQuery.of(context).size.height *
                                        0.9,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            MediaQuery.of(context).size.width *
                                                0.075),
                                        gradient: const LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                          colors: [
                                            Color(0xfff5f3f7),
                                            Color(0xffe0d6f0),
                                            Color(0xffd0c3ea),
                                            Color(0xffe1d4f9)
                                          ],
                                        )),
                                    child: Row(children: listOfGraph),
                                  ),
                                ),
                              ),
                              SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width * 0.5,
                                  child: ListView.builder(
                                    itemCount:
                                        expenseProvider.listOfCard.length,
                                    itemBuilder: (context, index) {
                                      return Dismissible(
                                        key:
                                            ValueKey(DateTime.now().toString()),
                                        onDismissed: (direction) {
                                          expenseProvider.deleteItem(
                                              expenseProvider
                                                  .listOfCard[index].uniqueKey);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  const Text("Deleted successfully"),
                                              action: SnackBarAction(
                                                label: "Undo",
                                                onPressed: () {
                                                  expenseProvider.undoDelete(
                                                      expenseProvider
                                                          .listOfCard[index]);
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        child: ExtendedExpenseCard(
                                            icon: expenseProvider.getIcon(
                                                expenseProvider
                                                    .listOfCard[index]
                                                    .whichTitle!),
                                            amount: expenseProvider
                                                .listOfCard[index].amount,
                                            title: expenseProvider
                                                .listOfCard[index].title,
                                            date: expenseProvider
                                                .listOfCard[index].date,
                                            whichTitle: expenseProvider
                                                .listOfCard[index].whichTitle,
                                            uniqueKey: expenseProvider
                                                .listOfCard[index].uniqueKey
                                                .toString()),
                                      );
                                    },
                                  )),
                              /*


               */
                            ],
                          ),
                  ),
                )
              : const Center(
                  child: Text(
                    "No expenses registered",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff424874)),
                  ),
                ),
        );
      },
    );
  }
}
