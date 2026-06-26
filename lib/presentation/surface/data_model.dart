import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'data_model.g.dart';

/// Client-side DataModel: a flat map keyed by data paths (e.g. `/sos/countdown`).
///
/// Interactive widgets read/write declared paths only; they never call network
/// actions directly. The orchestrator's interaction loop turns a write into the
/// next compose pass (Phase 3). For Phase 0 it backs live data bindings.
@Riverpod(keepAlive: true)
class DataModel extends _$DataModel {
  @override
  Map<String, Object?> build() => const <String, Object?>{};

  /// Writes a single [path]. Replaces the map so dependents rebuild.
  void write(String path, Object? value) {
    state = {...state, path: value};
  }

  /// Writes several paths at once.
  void writeAll(Map<String, Object?> values) {
    state = {...state, ...values};
  }

  Object? read(String path) => state[path];
}

/// Watches a single data [path]. The provider recomputes on every DataModel
/// write, but only rebuilds its dependents when this path's value actually
/// changes (Riverpod suppresses notifications when the output is unchanged).
@Riverpod(keepAlive: true)
Object? dataPath(Ref ref, String path) {
  final values = ref.watch(dataModelProvider);
  return values[path];
}
