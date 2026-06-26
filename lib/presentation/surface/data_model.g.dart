// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_model.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Client-side DataModel: a flat map keyed by data paths (e.g. `/sos/countdown`).
///
/// Interactive widgets read/write declared paths only; they never call network
/// actions directly. The orchestrator's interaction loop turns a write into the
/// next compose pass (Phase 3). For Phase 0 it backs live data bindings.

@ProviderFor(DataModel)
final dataModelProvider = DataModelProvider._();

/// Client-side DataModel: a flat map keyed by data paths (e.g. `/sos/countdown`).
///
/// Interactive widgets read/write declared paths only; they never call network
/// actions directly. The orchestrator's interaction loop turns a write into the
/// next compose pass (Phase 3). For Phase 0 it backs live data bindings.
final class DataModelProvider
    extends $NotifierProvider<DataModel, Map<String, Object?>> {
  /// Client-side DataModel: a flat map keyed by data paths (e.g. `/sos/countdown`).
  ///
  /// Interactive widgets read/write declared paths only; they never call network
  /// actions directly. The orchestrator's interaction loop turns a write into the
  /// next compose pass (Phase 3). For Phase 0 it backs live data bindings.
  DataModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataModelProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataModelHash();

  @$internal
  @override
  DataModel create() => DataModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<String, Object?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<String, Object?>>(value),
    );
  }
}

String _$dataModelHash() => r'7ccaf115b20f19f3491200f69310bf2c88dcfc2d';

/// Client-side DataModel: a flat map keyed by data paths (e.g. `/sos/countdown`).
///
/// Interactive widgets read/write declared paths only; they never call network
/// actions directly. The orchestrator's interaction loop turns a write into the
/// next compose pass (Phase 3). For Phase 0 it backs live data bindings.

abstract class _$DataModel extends $Notifier<Map<String, Object?>> {
  Map<String, Object?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<String, Object?>, Map<String, Object?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<String, Object?>, Map<String, Object?>>,
              Map<String, Object?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Watches a single data [path]. The provider recomputes on every DataModel
/// write, but only rebuilds its dependents when this path's value actually
/// changes (Riverpod suppresses notifications when the output is unchanged).

@ProviderFor(dataPath)
final dataPathProvider = DataPathFamily._();

/// Watches a single data [path]. The provider recomputes on every DataModel
/// write, but only rebuilds its dependents when this path's value actually
/// changes (Riverpod suppresses notifications when the output is unchanged).

final class DataPathProvider
    extends $FunctionalProvider<Object?, Object?, Object?>
    with $Provider<Object?> {
  /// Watches a single data [path]. The provider recomputes on every DataModel
  /// write, but only rebuilds its dependents when this path's value actually
  /// changes (Riverpod suppresses notifications when the output is unchanged).
  DataPathProvider._({
    required DataPathFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'dataPathProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dataPathHash();

  @override
  String toString() {
    return r'dataPathProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $ProviderElement<Object?> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Object? create(Ref ref) {
    final argument = this.argument as String;
    return dataPath(ref, argument);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Object? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Object?>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DataPathProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dataPathHash() => r'da0ad703af3056712013a17e931cf27e876cb48c';

/// Watches a single data [path]. The provider recomputes on every DataModel
/// write, but only rebuilds its dependents when this path's value actually
/// changes (Riverpod suppresses notifications when the output is unchanged).

final class DataPathFamily extends $Family
    with $FunctionalFamilyOverride<Object?, String> {
  DataPathFamily._()
    : super(
        retry: null,
        name: r'dataPathProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Watches a single data [path]. The provider recomputes on every DataModel
  /// write, but only rebuilds its dependents when this path's value actually
  /// changes (Riverpod suppresses notifications when the output is unchanged).

  DataPathProvider call(String path) =>
      DataPathProvider._(argument: path, from: this);

  @override
  String toString() => r'dataPathProvider';
}
