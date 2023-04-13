import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';

class SimpleContact extends Equatable {
  const SimpleContact(this.name, this.phone);

  final String name;
  final String phone;

  @override
  List<Object> get props => [phone, name];

  Map<String, String> toMap() {
    return {'name': name, 'phone': phone};
  }

  Contact toContact() {
    final splittedName = name.split(' ');

    final givenName = splittedName.isNotEmpty ? splittedName[0] : '';
    String? middleName;

    if (splittedName.length > 1) {
      splittedName.remove(givenName);
      middleName = splittedName.join(' ');
    }

    return Contact(
      givenName: givenName,
      middleName: middleName,
      phones: [Item(label: 'mobile', value: phone)],
    );
  }

  factory SimpleContact.fromMap(Map<String, dynamic>? map) =>
      SimpleContact(map?['name'] ?? '', map?['phone'] ?? '');
}

extension ParsedContact on Contact {
  SimpleContact toSimpleContact() {
    return SimpleContact(
      displayName ?? '',
      phones == null || phones!.isEmpty ? '' : phones![0].value!,
    );
  }
}
