import 'package:contacts_transfer/data/contacts_transfer_service.dart';
import 'package:contacts_transfer/data/local_storage_service.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

class LocatorService {
  static void setupService() {
    locator.registerFactory(() => LocalStorageService.instance);
    locator.registerFactory(() => ContactsTransferService.instance);
  }
}
