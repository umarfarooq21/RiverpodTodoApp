import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_app/APIProvider/home_api_future_provider.dart';
import 'package:flutter_riverpod_app/counterExample/homeCounter.dart';
import 'package:flutter_riverpod_app/home_screen.dart';
import 'package:flutter_riverpod_app/streamProvider/home_streamProvider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Riverpod',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: APIProviderHome(), // API uisng Future Provider
      //home: const HomeCounter(), //stateless work
      //home: const GomeCounter(), //statful counter example using provider
      //home: const HomeScreen(), //simple provider
      //home: const HomeStreamprovider(), //stream provider
    );
  }
}
