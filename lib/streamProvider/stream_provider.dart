import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';


//StreamProvider to simulate stock price updates
final stockPriceProvider = StreamProvider<double>((ref) async*{
    final random = Random();
    double currentPrice = 100.0;

    while (true) {
      await Future.delayed(Duration(seconds: 1));
      currentPrice += random.nextDouble() * 4 - 2; // Randomly change the price
      yield double.parse(currentPrice.toStringAsFixed(2)); // Yield the new price

      throw ('Internet error'); // Simulate an error for dem
    }
});