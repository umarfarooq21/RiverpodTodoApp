# Riverpod Todo App

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Riverpod-3.3-blue?style=for-the-badge" alt="Riverpod" />
  <img src="https://img.shields.io/badge/Dart-3.11-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/State%20Management-Riverpod-purple?style=for-the-badge" alt="State Management" />
</p>

<p align="center">
  A hands-on Flutter demo that explores <b>Riverpod</b> — from a <code>ConsumerWidget</code> counter app with <code>StateProvider</code>, to CRUD with <code>StateNotifierProvider</code>, live updates with <code>StreamProvider</code>, and async work with <code>FutureProvider</code>.
</p>

---

## Features

| Feature | Provider / Widget | What it shows |
|--------|-------------------|----------------|
| Counter app | `StateProvider` + `ConsumerWidget` / `Consumer` | Rebuild only the watched UI |
| Todo CRUD | `StateNotifierProvider` | Add, update, and delete items |
| Live stock ticker | `StreamProvider` | Continuous stream updates + error retry |
| Async data | `FutureProvider` | One-shot async loading patterns |
| Favorites / search | Custom notifier | Filtering and favorite state |

---

## Project structure

```text
lib/
├── main.dart
├── home_screen.dart              # CRUD todo UI
├── item.dart
├── item_provider.dart            # StateNotifierProvider (CRUD)
├── counterExample/
│   └── homeCounter.dart          # ConsumerWidget + StateProvider counter
├── streamProvider/
│   ├── stream_provider.dart      # StreamProvider (live stock price)
│   └── home_streamProvider.dart
├── futureProvider/
│   ├── future_provider.dart      # FutureProvider demos
│   └── home_futureProvider.dart
└── favoriteSearch/
    ├── fav_provider.dart
    └── fav_states.dart
```

---

## Getting started

### Prerequisites

- Flutter SDK
- Dart `^3.11.0`

### Run the app

```bash
git clone https://github.com/umarfarooq21/RiverpodTodoApp.git
cd RiverpodTodoApp
flutter pub get
flutter run
```

---

## Providers in this project

### 1. StateProvider + ConsumerWidget — Counter app

A simple counter using `StateProvider`. The screen is a `ConsumerWidget`, and the count text is wrapped in a nested `Consumer` so only that part rebuilds when the value changes.

```dart
final counter = StateProvider<int>((ref) => 0);

class HomeCounter extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(
      builder: (context, ref, child) {
        final count = ref.watch(counter);
        return Text('Counter Value: $count');
      },
    );
  }
}
```

Increment with:

```dart
ref.read(counter.notifier).state++;
```

### 2. StateNotifierProvider — Todo CRUD

Manage a list of items with add / update / delete through a notifier.

```dart
final itemProvider = StateNotifierProvider<itemNotifier, List<Item>>((ref) {
  return itemNotifier();
});
```

### 3. StreamProvider — Live stock price

Simulates a real-time stock feed that emits a new price every second and handles loading / error / retry with `AsyncValue.when`.

```dart
final stockPriceProvider = StreamProvider<double>((ref) async* {
  // yields updated prices over time
});
```

### 4. FutureProvider — Async data

Loads data once (API-style) and rebuilds the UI when the future completes.

---

## Switch demos in `main.dart`

```dart
home: const HomeCounter(),             // ConsumerWidget + StateProvider counter
// home: const HomeScreen(),           // CRUD with StateNotifierProvider
// home: const HomeStreamprovider(),   // StreamProvider demo
// home: const HomeFutureProvider(),   // FutureProvider demo
```

---

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^3.3.2
  cupertino_icons: ^1.0.8
```

---

## Learning goals

- Wrap the app with `ProviderScope`
- Use `ConsumerWidget` and nested `Consumer` for scoped rebuilds
- Use `ref.watch` to listen and `ref.read` to update
- Handle `AsyncValue` states: `data`, `loading`, `error`
- Invalidate providers to retry failed streams/futures
- Keep UI and state logic separated

---

## License

This project is for learning and demonstration purposes.

---

<p align="center">
  Built with Flutter + Riverpod
</p>
