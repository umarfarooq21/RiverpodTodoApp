import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_app/APIProvider/post_provider.dart';

class APIProviderHome extends ConsumerWidget {
  const APIProviderHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Get (Future Provider)'),
      ),
      body: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          final postList = ref.watch(postProvider);

          return RefreshIndicator(
            onRefresh: () async {
              try {
                // Clear previous data, then fetch fresh from API.
                ref.invalidate(postProvider);
                await ref.read(postProvider.future);
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Something went wrong: $e'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: postList.when(
              skipLoadingOnRefresh: false,
              data: (data) => ListView.builder(
                physics: const AlwaysScrollableScrollPhysics(),
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
              loading: () => ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
              error: (error, stack) => ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Center(
                      child: Text(
                        'Error: $error\nPull down to retry',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
