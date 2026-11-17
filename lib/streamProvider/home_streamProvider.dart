import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_app/streamProvider/stream_provider.dart';

class HomeStreamprovider extends ConsumerWidget{
  const HomeStreamprovider({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stockPriceAsyncValue = ref.watch(stockPriceProvider);
    print('build new widget');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Stock Price Stream'),
      ),
      body: Consumer(builder: (context, ref, child) {
        return Center(
          child: stockPriceAsyncValue.when(
            skipLoadingOnRefresh: false,
            data: (price) => Text('Current Stock Price: \$${price.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)
            ),
            loading: () => const CircularProgressIndicator(),
            error: (error, stack) => TextButton(onPressed: () {
              ref.invalidate(stockPriceProvider);
            }, child: const Text('Error occurred. Tap to retry.')),
          ),
        );
      })
    );

 }
}