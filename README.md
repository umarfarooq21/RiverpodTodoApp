# Riverpod Todo App

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Riverpod-3.3-blue?style=for-the-badge" alt="Riverpod" />
  <img src="https://img.shields.io/badge/Dart-3.11-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/HTTP-API-green?style=for-the-badge" alt="HTTP API" />
  <img src="https://img.shields.io/badge/State%20Management-Riverpod-purple?style=for-the-badge" alt="State Management" />
</p>

<p align="center">
  A hands-on Flutter demo that explores <b>Riverpod</b> — counter apps with <code>ConsumerWidget</code> / <code>ConsumerStatefulWidget</code>, REST API fetching with <code>FutureProvider</code> + <code>http</code>, CRUD with <code>StateNotifierProvider</code>, and live updates with <code>StreamProvider</code>.
</p>

---

## Features

| Feature | Provider / Widget | What it shows |
|--------|-------------------|----------------|
| API posts list | `FutureProvider` + `http` | Fetch JSON from REST API, loading/error UI |
| Counter (stateless) | `StateProvider` + `ConsumerWidget` | Rebuild only the watched UI |
| Counter (stateful) | `StateProvider` + `ConsumerStatefulWidget` | Same Riverpod API with lifecycle access |
| Switch toggle | `StateProvider<bool>` + `Consumer` | Boolean state with Switch widget |
| Todo CRUD | `StateNotifierProvider` | Add, update, and delete items |
| Live stock ticker | `StreamProvider` | Continuous stream updates + error retry |
| Favorites / search | Custom notifier | Filtering and favorite state |

---

## Project structure

```text
lib/
├── main.dart
├── home_screen.dart              # CRUD todo UI
├── item.dart
├── item_provider.dart            # StateNotifierProvider (CRUD)
├── APIProvider/
│   ├── post_provider.dart        # FutureProvider + http GET posts
│   └── home_api_future_provider.dart
├── counterExample/
│   └── homeCounter.dart          # ConsumerWidget + ConsumerStatefulWidget + Switch
├── streamProvider/
│   ├── stream_provider.dart      # StreamProvider (live stock price)
│   └── home_streamProvider.dart
├── futureProvider/
│   ├── future_provider.dart
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

### 1. FutureProvider — API using Future Provider

Fetches posts from [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts) with the `http` package, maps JSON to `PostModel`, and handles loading / error / retry in the UI.

```dart
final postProvider = FutureProvider<List<PostModel>>((ref) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
      .timeout(const Duration(seconds: 2));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    return data.map((item) => PostModel.fromJson(item)).toList();
  }
  throw ('something went wrong');
});
```

UI with `AsyncValue.when`:

```dart
postList.when(
  data: (data) => ListView.builder(...),
  loading: () => const CircularProgressIndicator(),
  error: (error, stack) => TextButton(
    onPressed: () => ref.invalidate(postProvider),
    child: Text('Error: $error'),
  ),
);
```

### 2. StateProvider — Counter + Switch

```dart
final counter = StateProvider<int>((ref) => 0);
final switchProvider = StateProvider<bool>((ref) => false);
```

- `HomeCounter` → `ConsumerWidget` (stateless)
- `GomeCounter` → `ConsumerStatefulWidget` (stateful + lifecycle)

### 3. StateNotifierProvider — Todo CRUD

```dart
final itemProvider = StateNotifierProvider<itemNotifier, List<Item>>((ref) {
  return itemNotifier();
});
```

### 4. StreamProvider — Live stock price

```dart
final stockPriceProvider = StreamProvider<double>((ref) async* {
  // yields updated prices over time
});
```

---

## Switch demos in `main.dart`

```dart
home: APIProviderHome(),               // API using FutureProvider + http
// home: const HomeCounter(),          // ConsumerWidget counter + Switch
// home: const GomeCounter(),          // ConsumerStatefulWidget counter
// home: const HomeScreen(),           // CRUD with StateNotifierProvider
// home: const HomeStreamprovider(),   // StreamProvider demo
```

---

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_riverpod: ^3.3.2
  http: ^1.6.0
  cupertino_icons: ^1.0.8
```

---

## Learning goals

- Wrap the app with `ProviderScope`
- Fetch REST APIs with `FutureProvider` + `http`
- Handle `AsyncValue` states: `data`, `loading`, `error`
- Retry failed requests with `ref.invalidate`
- Use both `ConsumerWidget` and `ConsumerStatefulWidget`
- Use `ref.watch` to listen and `ref.read` to update
- Manage UI state with `StateProvider` / `StateNotifierProvider`
- Keep UI and state logic separated

---

## License

This project is for learning and demonstration purposes.

---

<p align="center">
  Built with Flutter + Riverpod
</p>
