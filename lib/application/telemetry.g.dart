// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'telemetry.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(telemetry)
final telemetryProvider = TelemetryProvider._();

final class TelemetryProvider
    extends $FunctionalProvider<TelemetrySink, TelemetrySink, TelemetrySink>
    with $Provider<TelemetrySink> {
  TelemetryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'telemetryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$telemetryHash();

  @$internal
  @override
  $ProviderElement<TelemetrySink> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TelemetrySink create(Ref ref) {
    return telemetry(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TelemetrySink value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TelemetrySink>(value),
    );
  }
}

String _$telemetryHash() => r'dafdd7439af14b5b4fd613ce877ab3ea8f84837a';
