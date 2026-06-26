import 'package:flutter/material.dart';

/// Maps the catalog's emergency icon names (as they appear in A2UI `icon`
/// props) to Material icons. The handoff uses a bespoke line set; Material
/// equivalents keep the action vocabulary consistent without hand-drawn SVG.
///
/// Every icon always ships beside a word label — an icon never carries meaning
/// alone.
abstract final class SosIcons {
  static const Map<String, IconData> _byName = {
    'call': Icons.call,
    'location': Icons.location_on_outlined,
    'contacts': Icons.groups_outlined,
    'safe-route': Icons.shield_outlined,
    'voice': Icons.mic_none_outlined,
    'i-am-safe': Icons.check_rounded,
    'countdown': Icons.timer_outlined,
    'cancel': Icons.close_rounded,
    'hazard': Icons.warning_amber_rounded,
    'vehicle': Icons.directions_car_outlined,
    'offline': Icons.wifi_off_rounded,
    'siren': Icons.emergency_outlined,
    'navigate': Icons.navigation_outlined,
    'alert': Icons.notifications_none_rounded,
    'medical-id': Icons.medical_information_outlined,
    'eta': Icons.schedule_outlined,
    'crash': Icons.warning_amber_rounded,
    'medical': Icons.add_circle_outline,
    'unsafe': Icons.visibility_outlined,
    'followed': Icons.visibility_outlined,
    'locked-out': Icons.lock_outline,
    'roadside': Icons.vpn_key_outlined,
    'document': Icons.description_outlined,
    'info': Icons.info_outline,
    'police': Icons.shield_outlined,
    'fire': Icons.local_fire_department_outlined,
    'hospital': Icons.add_box_outlined,
    'check': Icons.check_rounded,
    'fuel': Icons.local_gas_station_outlined,
    'battery': Icons.battery_charging_full_outlined,
    'weather': Icons.cloud_outlined,
  };

  /// Resolves an icon by [name], falling back to a neutral dot when unknown.
  static IconData resolve(String? name) =>
      _byName[name] ?? Icons.circle_outlined;
}
