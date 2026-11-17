
import 'package:flutter_riverpod/legacy.dart';
import 'item.dart';


final itemProvider = StateNotifierProvider<itemNotifier, List<Item>>((ref) {
  return itemNotifier();
});

class itemNotifier extends StateNotifier<List<Item>>{
  itemNotifier() : super([]);

  void addItem(String name){
    final item = Item(id: DateTime.now().toString(), name: name);
    state.add(item);
    state = state.toList();
  }

  void deleteItem(String id){
    state.removeWhere((item) => item.id == id);
    state = state.toList();
    //state = state.where((item) => item.id != id).toList();
  }

  void updateItem(String id, String newName){
    final index = state.indexWhere((item) => item.id == id);
    if(index != -1){
      state[index].name = newName;
      state = state.toList();
    }
  }

} 