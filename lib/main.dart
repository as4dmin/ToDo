import 'package:flutter/material.dart';
import 'package:flutter_application_1/AppProvider.dart';
import 'package:flutter_application_1/todo.dart';
import 'package:provider/provider.dart';

void main(){
  runApp( ChangeNotifierProvider(
    create: (context) => AppProvider(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
    home: TODO(),
    );
  }
}
