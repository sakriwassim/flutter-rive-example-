import 'package:flutter/material.dart';
import 'package:flutter_hive/bank_account.dart';
import 'package:hive_flutter/hive_flutter.dart';

late Box box;
Future<void> main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('box');
  Hive.registerAdapter(BankAccountAdapter());
  box.put('bankAccount', BankAccount(currency: "\$USD", myMoney: 100000));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    BankAccount bankAccount = box.get('bankAccount');

    return Scaffold(
        appBar: AppBar(
          title: Text("${bankAccount.currency} ${bankAccount.myMoney}"),
        ),
        body: Container());
  }
}
