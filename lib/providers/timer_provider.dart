import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'timer_provider.g.dart';

@riverpod
Stream<int> remainingSeconds(RemainingSecondsRef ref) {
  return Stream.periodic(const Duration(seconds: 1), (x) => 30 - x % 30);
}
