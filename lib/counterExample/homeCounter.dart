import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';


final counter = StateProvider<int>((ref){
  return 0;
});

final switchProvider = StateProvider<bool>((ref){
  return false;
}); 

//TODO: With Both Statful and Statless Widgets, Statfull has Lifecyle methods ;)
class GomeCounter extends ConsumerStatefulWidget {
  const GomeCounter({super.key});

  @override
  ConsumerState<GomeCounter> createState() => _GomeCounterState();
  
}

class _GomeCounterState extends ConsumerState<GomeCounter> {
  @override
  Widget build(BuildContext context) {
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
            print('only building counter label');
            return Text('Counter Value: $count', style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),);
            }),
        
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


class HomeCounter extends ConsumerWidget {
  const HomeCounter({super.key});

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
          Consumer(builder: (context, ref, child) {
            final swwtch = ref.watch(switchProvider);
            print('switch changed');
            return Switch(value: swwtch, onChanged: (value) {
              ref.read(switchProvider.notifier).state = value;
            });
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