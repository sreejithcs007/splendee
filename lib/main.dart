import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:splendee/presentation/add_details_screen/controller/add_detail_controller.dart';
import 'package:splendee/presentation/commonscreen/splashscreen.dart';
import 'package:splendee/repository/model/expensemodel.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExpenseModelAdapter());
  var box = await Hive.openBox('mybox');
  var inc = await Hive.openBox('income');
  var exp = await Hive.openBox('expense');
  var totalincome = await Hive.openBox('totalincom');
  var totalexpense = await Hive.openBox('totalexpenss');
  var totstaticexp = await Hive.openBox('staticexp');

  var totstaticin = Hive.openBox('staticin');

  var balance = await Hive.openBox('balance');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AddDetailController())
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Splashscreen(),
      ),
    );
  }
}
