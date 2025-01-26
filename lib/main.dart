import 'package:assignment3/repository/news_repositories.dart';
import 'package:assignment3/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RepositoryProvider(
          create: (context) => NewsRepository(),
          child: const Home(),
        ));
  }
}
