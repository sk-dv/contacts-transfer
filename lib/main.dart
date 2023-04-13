import 'package:contacts_transfer/data/contacts_transfer_service.dart';
import 'package:contacts_transfer/data/locator_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:permission_handler/permission_handler.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  LocatorService.setupService();

  runApp(const ContactsTransfer());
}

class ContactsTransfer extends StatelessWidget {
  const ContactsTransfer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              child: const Icon(Icons.download),
              onPressed: () async {
                if (await Permission.contacts.request().isGranted) {
                  locator.get<ContactsTransferService>().downloadContacts();
                }
              },
            ),
            const SizedBox(width: 10),
            FloatingActionButton(
              child: const Icon(Icons.upload),
              onPressed: () async {
                if (await Permission.contacts.request().isGranted) {
                  locator.get<ContactsTransferService>().uploadContacts();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
