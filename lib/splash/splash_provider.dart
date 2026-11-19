import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks splash lifecycle so the UI can react when intro animation finishes.
enum SplashPhase { animating, ready }

final splashPhaseProvider =
    NotifierProvider<SplashPhaseNotifier, SplashPhase>(SplashPhaseNotifier.new);

class SplashPhaseNotifier extends Notifier<SplashPhase> {
  @override
  SplashPhase build() => SplashPhase.animating;

  void markReady() => state = SplashPhase.ready;
}
