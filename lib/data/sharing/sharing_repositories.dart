import 'package:sos_emergency/domain/models/contacts.dart';

/// Starts/stops a live location broadcast to recipients (911 relay, contacts).
abstract interface class LocationSharingRepository {
  Future<void> start(List<String> recipients);
  Future<void> stop();
}

/// Sandbox sharing: records the on/off state and recipients.
class SandboxLocationSharingRepository implements LocationSharingRepository {
  bool sharing = false;
  List<String> recipients = const [];

  @override
  Future<void> start(List<String> recipients) async {
    sharing = true;
    this.recipients = recipients;
  }

  @override
  Future<void> stop() async {
    sharing = false;
  }
}

/// Provides the user's trusted contacts.
// Repository seam for DI/testing despite the single method.
// ignore: one_member_abstracts
abstract interface class ContactsRepository {
  Future<List<TrustedContact>> contacts();
}

/// In-memory contacts (configurable, including the empty case).
class SandboxContactsRepository implements ContactsRepository {
  SandboxContactsRepository([this._contacts = _defaults]);

  static const List<TrustedContact> _defaults = [
    TrustedContact(name: 'Maya', relation: 'Sister'),
    TrustedContact(name: 'Dad', relation: 'Emergency contact'),
    TrustedContact(name: 'Jordan', relation: 'Friend'),
  ];

  final List<TrustedContact> _contacts;

  @override
  Future<List<TrustedContact>> contacts() async => _contacts;
}

/// Delivers an alert message to one contact, returning whether it was reached.
// Repository seam for DI/testing despite the single method.
// ignore: one_member_abstracts
abstract interface class ContactNotifier {
  Future<bool> notify(TrustedContact contact, String message);
}

/// Sandbox notifier: records sent messages and reports success unless the
/// contact's name is in [failFor].
class SandboxContactNotifier implements ContactNotifier {
  SandboxContactNotifier({this.failFor = const {}});

  final Set<String> failFor;
  final List<String> sentTo = [];

  @override
  Future<bool> notify(TrustedContact contact, String message) async {
    sentTo.add(contact.name);
    return !failFor.contains(contact.name);
  }
}
