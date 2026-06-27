import 'package:freezed_annotation/freezed_annotation.dart';

part 'contacts.freezed.dart';

/// Per-recipient delivery state when alerting trusted contacts.
enum DeliveryStatus { queued, sending, reached, failed }

/// A trusted contact alerted during an incident.
@freezed
abstract class TrustedContact with _$TrustedContact {
  const factory TrustedContact({required String name, String? relation}) =
      _TrustedContact;
}

/// A contact paired with its current delivery status — what
/// `ContactStatusList` mirrors.
@freezed
abstract class ContactDelivery with _$ContactDelivery {
  const factory ContactDelivery({
    required TrustedContact contact,
    required DeliveryStatus status,
  }) = _ContactDelivery;
}
