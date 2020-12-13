import 'package:covid_19_tracker/views/homeView.dart';
import 'package:covid_19_tracker/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid-19 Tracker',
        home: HomeView(),
      ),
    );
  }
}
