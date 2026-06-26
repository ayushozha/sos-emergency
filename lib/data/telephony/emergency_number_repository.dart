/// The local emergency number is **data, never hard-coded**. Resolved per
/// region so the call button dials 911 / 112 / 000 as appropriate.
// Repository seam for DI/testing despite the single method.
// ignore: one_member_abstracts
abstract interface class EmergencyNumberRepository {
  String numberFor(String regionCode);
}

/// A bundled region → number table. Defaults to 112 (the widest-reaching
/// number) for unknown regions.
class LocaleEmergencyNumberRepository implements EmergencyNumberRepository {
  const LocaleEmergencyNumberRepository();

  static const Map<String, String> _byRegion = {
    'US': '911',
    'CA': '911',
    'MX': '911',
    'GB': '999',
    'AU': '000',
    'NZ': '111',
    'IN': '112',
    'EU': '112',
  };

  @override
  String numberFor(String regionCode) =>
      _byRegion[regionCode.toUpperCase()] ?? '112';
}
