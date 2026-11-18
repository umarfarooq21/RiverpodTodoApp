
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_app/APIProvider/post_provider.dart';

class APIProviderHome extends ConsumerWidget {
  const APIProviderHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final postList = ref.watch(postProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('API Get (Future Provider)'),
      ),
      body: Center(
        child: postList.when(
          skipLoadingOnRefresh: true ,
          data: (data) => ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Card(
                child: ListTile(
                  title: Text(item.title),
                  subtitle: Text(item.body),
                ),
              );
            },
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, stack) => TextButton(onPressed: (){
            ref.invalidate(postProvider);
          }, child: Text('Error: $error'),),
        ),
      ),
    );
  }
}






