# Riverpod Todo App

<p align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Riverpod-3.3-blue?style=for-the-badge" alt="Riverpod" />
  <img src="https://img.shields.io/badge/Dart-3.11-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/HTTP-API-green?style=for-the-badge" alt="HTTP API" />
  <img src="https://img.shields.io/badge/Animations-Splash-teal?style=for-the-badge" alt="Splash Animations" />
  <img src="https://img.shields.io/badge/State%20Management-Riverpod-purple?style=for-the-badge" alt="State Management" />
</p>

<p align="center">
  A hands-on Flutter demo that explores <b>Riverpod</b> — an animated splash intro, REST API fetching with <code>FutureProvider</code> + pull-to-refresh, counter apps with <code>ConsumerWidget</code> / <code>ConsumerStatefulWidget</code>, CRUD with <code>StateNotifierProvider</code>, and live updates with <code>StreamProvider</code>.
</p>

---

## Features

| Feature | Provider / Widget | What it shows |
|--------|-------------------|----------------|
| Animated splash | `NotifierProvider` + `ConsumerStatefulWidget` | Eye-pleasing logo, orbit, and fade/scale intro |
| API posts list | `FutureProvider.autoDispose` + `http` | Fresh API fetch, no cached list on refresh |
| Pull to refresh | `RefreshIndicator` + `ref.invalidate` | Re-call API; SnackBar on failure |
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
├── splash/
│   ├── splash_screen.dart        # Animated splash (ConsumerStatefulWidget)
│   └── splash_provider.dart      # SplashPhase NotifierProvider
├── APIProvider/
│   ├── post_provider.dart        # FutureProvider.autoDispose + http GET
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

App flow: **Splash animation → API posts screen**

---

## Providers in this project

### 1. Splash — Riverpod + animations

Animated intro with gradient background, glowing logo, orbiting dots, floating orbs, and a fade/scale transition into the home screen.

```dart
enum SplashPhase { animating, ready }

final splashPhaseProvider =
    NotifierProvider<SplashPhaseNotifier, SplashPhase>(SplashPhaseNotifier.new);
```

Uses `ConsumerStatefulWidget` with multiple `AnimationController`s for coordinated motion.

### 2. FutureProvider — API + pull to refresh

Fetches posts from [JSONPlaceholder](https://jsonplaceholder.typicode.com/posts).

- `FutureProvider.autoDispose` — no kept cache when unused
- Pull-to-refresh clears data with `ref.invalidate`, then fetches again
- Timeout + `SocketException` / `TimeoutException` handling
- SnackBar toast when refresh fails

```dart
final postProvider = FutureProvider.autoDispose<List<PostModel>>((ref) async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'))
      .timeout(const Duration(seconds: 10));
  // ...
});
```

```dart
onRefresh: () async {
  ref.invalidate(postProvider);
  await ref.read(postProvider.future);
},
```

### 3. StateProvider — Counter + Switch

```dart
final counter = StateProvider<int>((ref) => 0);
final switchProvider = StateProvider<bool>((ref) => false);
```

- `HomeCounter` → `ConsumerWidget` (stateless)
- `GomeCounter` → `ConsumerStatefulWidget` (stateful + lifecycle)

### 4. StateNotifierProvider — Todo CRUD

```dart
final itemProvider = StateNotifierProvider<itemNotifier, List<Item>>((ref) {
  return itemNotifier();
});
```

### 5. StreamProvider — Live stock price

```dart
final stockPriceProvider = StreamProvider<double>((ref) async* {
  // yields updated prices over time
});
```

---

## App entry (`main.dart`)

```dart
home: const SplashScreen(), // animated splash → APIProviderHome
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

- Build an animated splash with `ConsumerStatefulWidget` + Riverpod
- Wrap the app with `ProviderScope`
- Fetch REST APIs with `FutureProvider.autoDispose` + `http`
- Pull-to-refresh without showing stale cached data
- Show user-friendly errors with SnackBar
- Handle `AsyncValue` states: `data`, `loading`, `error`
- Use both `ConsumerWidget` and `ConsumerStatefulWidget`
- Use `ref.watch` / `ref.read` / `ref.invalidate`
- Keep UI and state logic separated

---

## License

This project is for learning and demonstration purposes.

---

<p align="center">
  Built with Flutter + Riverpod
</p>
