import 'package:expense_tracker/go%20router/go_router.dart';
import 'package:expense_tracker/provider/expense_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auto router/routes.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
  //     .then((value) {
  // });

  //runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appAutoRouter = AppRouter();
  final _appGoRouter = AppGoRouter().router;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> ExpenseProvider())
      ],
      child: MaterialApp.router(
        routerConfig: _appGoRouter,
        debugShowCheckedModeBanner: false,
        title: 'Expense',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
