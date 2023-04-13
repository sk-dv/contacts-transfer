import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';

import '../models/simple_contact.dart';

class ContactsTransferService {
  const ContactsTransferService._(this.db);

  final FirebaseFirestore db;

  static ContactsTransferService instance =
      ContactsTransferService._(FirebaseFirestore.instance);

  void _print(List<Contact> contacts) async {
    for (final Contact contact in contacts) {
      print(contact.toMap());
    }
  }

  void uploadContacts() async {
    final rawContacts = await ContactsService.getContacts();

    _print(rawContacts);

    // final id = await locator.get<LocalStorageService>().checkUserId();
    // final contacts = rawContacts
    //     .map((e) => e.toSimpleContact())
    //     .toSet()
    //     .map((e) => e.toMap())
    //     .toList();

    // await db
    //     .collection('user')
    //     .doc(id.toUpperCase())
    //     .set({'contacts': contacts});
  }

  void downloadContacts() async {
    final snapshot = await db.collection('contacts').get();
    final contacts = snapshot.docs
        .map((query) => SimpleContact.fromMap(query.data()).toContact())
        .toList();

    for (final Contact contact in contacts) {
      await ContactsService.addContact(contact);
    }
  }
}
