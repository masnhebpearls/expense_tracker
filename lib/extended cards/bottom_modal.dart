import 'package:auto_route/auto_route.dart';
import 'package:expense_tracker/class/class.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:provider/provider.dart';
import 'package:string_validator/string_validator.dart';

class ExtendedModalSheet extends StatefulWidget {
  const ExtendedModalSheet({super.key});

  @override
  State<ExtendedModalSheet> createState() => _ExtendedModalSheetState();
}

class _ExtendedModalSheetState extends State<ExtendedModalSheet> {

  String getMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "Aug";
      case 9:
        return "Sept";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "null";
    }
  }
  List<String> dropItem = ["General", "Foods", "Fuels", "Misc"];
  tittle abc = tittle.General;

  var presentSelected = "General";

  String textInTextField = '';
  String numberInTextField = '0.0';
  String dropDownValue = "General";

  final _formKey = GlobalKey<FormState>();

  DateTime selectedDate = DateTime.now();
  String selectedDateString = '';

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedDateString = '${getMonth(selectedDate.month)} ${selectedDate.day}';
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Consumer<ExpenseProvider>(
      builder: (context, expenseProvider, child) {
        return GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: Container(
            width: width,
            height: height * 0.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(width * 0.15),
                    topLeft: Radius.circular(width * 0.15)),
                color: const Color(0xffCADEFC)),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: height * 0.035,
                        ),
                        SizedBox(
                          width: width * 0.85,
                          child: TextFormField(
                            controller: _titleController,
                            validator: (val) {
                              if (val!.length < 3) {
                                return "must be at least 3 character";
                              }
                              return null;
                            },
                            style: const TextStyle(
                                color: Color(0xff424874), fontSize: 22),
                            decoration:  InputDecoration(
                              prefixIcon: const Icon(
                                Icons.title,
                                size: 38,
                                color: Color(0xff424874),
                              ),
                              label: const Text(
                                "Title",
                                style: TextStyle(
                                  color: Color(0xff424874),
                                  fontSize: 22,
                                ),
                              ),
                              contentPadding: const EdgeInsets.all(20),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(width*0.05),
                                  borderSide:const BorderSide(
                                      width: 4, color: Color(0xff424874))),
                            ),
                            onChanged: (String? value) {
                              setState(() {
                                textInTextField = value!;
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          height: height * 0.0125,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              width: width * 0.075,
                            ),
                            SizedBox(
                              width: width * 0.4,
                              // height: MediaQuery.of(context).size.height*0.1,
                              child: TextFormField(
                                validator: (val) {
                                  if (val!.isEmpty) {
                                    return "enter amount";
                                  }
                                  if (isAlpha(val)) {
                                    return "numeric values only";
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                controller: _amountController,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.currency_rupee,
                                    size: 38,
                                    color: Color(0xff424874),
                                  ),
                                  label: const Text(
                                    "Amount",
                                    style: TextStyle(
                                      color: Color(0xff424874),
                                      fontSize: 22,
                                    ),
                                  ),
                                  contentPadding: const EdgeInsets.all(16),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(width*0.05),
                                      borderSide: const BorderSide(
                                          width: 4, color: Color(0xff424874))),
                                ),
                                onChanged: (String? value) {
                                  setState(() {
                                    numberInTextField = value!;
                                  });
                                },
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              // width: width * 0.25,
                              height: height * 0.1,
                              child: Center(
                                child: Text(
                                  selectedDateString,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w800,
                                      textBaseline: TextBaseline.alphabetic,
                                      fontSize: 20,
                                      color: Color(0xff424874)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                DateTime? date = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month - 1,
                                      DateTime.now().day),
                                  lastDate: DateTime(
                                      DateTime.now().year,
                                      DateTime.now().month + 1,
                                      DateTime.now().day),
                                );
                                setState(() {
                                  selectedDateString =
                                      formatDate(date!, [yy, '-', MM, '-', d]);
                                });
                              },
                              icon: const Icon(
                                Icons.calendar_today,
                                color: Color(0xff424874),
                                size: 32,
                              ),
                            ),
                            SizedBox(
                              width: width * 0.075,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.0125,
                        ),
                        SizedBox(
                          width: width * 0.85,
                          height: height * 0.1,
                          child: Row(
                            children: [
                              const Text(
                                "Select category :",
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    textBaseline: TextBaseline.alphabetic,
                                    fontSize: 26,
                                    color: Color(0xff424874)),
                              ),
                              const Spacer(),
                              DropdownButton(
                                  value: dropDownValue,
                                  items: [
                                    DropdownMenuItem(
                                      value: dropItem[0],
                                      child: Text(
                                        dropItem[0],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w800,
                                            textBaseline:
                                                TextBaseline.alphabetic,
                                            fontSize: 26,
                                            color: Color(0xff424874)),
                                      ),
                                    ),
                                    DropdownMenuItem(
                                        value: dropItem[1],
                                        child: Text(
                                          dropItem[1],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 26,
                                              color: Color(0xff424874)),
                                        )),
                                    DropdownMenuItem(
                                        value: dropItem[2],
                                        child: Text(
                                          dropItem[2],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 26,
                                              color: Color(0xff424874)),
                                        )),
                                    DropdownMenuItem(
                                        value: dropItem[3],
                                        child: Text(
                                          dropItem[3],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w800,
                                              textBaseline:
                                                  TextBaseline.alphabetic,
                                              fontSize: 26,
                                              color: Color(0xff424874)),
                                        ))
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropDownValue = value!;
                                      switch (value) {
                                        case ("General"):
                                          {
                                            abc = tittle.General;
                                          }
                                        case ("Foods"):
                                          {
                                            abc = tittle.Foods;
                                          }
                                        case ("Fuels"):
                                          {
                                            abc = tittle.Fuels;
                                          }
                                        case ("Misc"):
                                          {
                                            abc = tittle.Misc;
                                          }
                                        default:
                                          abc = tittle.General;
                                      }
                                    });
                                  }),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Spacer(),
                            InkWell(
                                onTap: () {
                                  AutoRouter.of(context).maybePop();
                                },
                                child: Container(
                                  height: height * 0.05,
                                  width: width * 0.3,
                                  decoration: BoxDecoration(
                                      color: const Color(0xff4D869C),
                                      borderRadius:
                                          BorderRadius.circular(width * 0.075)),
                                  child: const Center(
                                    child: Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Color(0xffCDE8E5),
                                          fontWeight: FontWeight.w800,
                                          fontSize: 22),
                                    ),
                                  ),
                                )),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            InkWell(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  expenseProvider.addToList(
                                    ExpenseData(
                                        title: textInTextField,
                                        amount: numberInTextField,
                                        date: selectedDateString,
                                        whichTitle: abc,
                                        uniqueKey: DateTime.now()),
                                  );
                                  AutoRouter.of(context).maybePop();
                                }
                              },
                              child: Container(
                                height: height * 0.05,
                                width: width * 0.4,
                                decoration: BoxDecoration(
                                    color: const Color(0xff4D869C),
                                    borderRadius:
                                        BorderRadius.circular(width * 0.075)),
                                child: const Center(
                                  child: Text(
                                    "Add Record",
                                    style: TextStyle(
                                        color: Color(0xffCDE8E5),
                                        fontWeight: FontWeight.w800,
                                        fontSize: 22),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.075,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
