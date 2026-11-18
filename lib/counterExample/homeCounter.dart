import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';


final counter = StateProvider<int>((ref){
  return 0;
});


class HomeCounter extends ConsumerWidget {
  const HomeCounter({super.key});

  //get child => null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //final count = ref.watch(counter);
    print('build');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Counter App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Consumer(builder: (context, ref, child) {
            final count = ref.watch(counter);
            print('build 2');
            return Text('Counter Value: $count', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),);
            }),
          // Text('Counter Value: $count', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        Row( 
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(counter.notifier).state++;
              },
              child: const Text('+'),
            ),
          ],
        )
        
        ],
      ),
      
     
    );
  }
}