import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_app/item_provider.dart';

class HomeScreen extends ConsumerWidget {
const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(itemProvider);
    print('build new widgetsssss');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: item.isEmpty ? Center(child: const Text('No data found')) : ListView.builder(
        itemCount: item.length,
        itemBuilder: (context, index) {
          final itemDetail = ref.watch(itemProvider)[index];
          return ListTile(
            title: Text(itemDetail.name),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () {
                    ref.read(itemProvider.notifier).updateItem(itemDetail.id, 'Updated Name');
                    // Handle edit action
                  }, 
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref.read(itemProvider.notifier).deleteItem(itemDetail.id);
                  },
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to the second screen when the button is pressed
          ref.read(itemProvider.notifier).addItem('New Umar');
        },
        child: const Icon(Icons.add),
      ),
      
    );
  }

}