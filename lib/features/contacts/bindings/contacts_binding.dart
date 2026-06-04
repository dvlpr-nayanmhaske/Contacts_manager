import 'package:get/get.dart';
import 'package:houzeo_task/features/contacts/controller/contacts_controller.dart';
import 'package:houzeo_task/features/contacts/repository/contacts_repository.dart';

import '../datasource/contacts_local_datasource.dart';

class ContactsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ContactsLocalDatasource());

    Get.lazyPut(() => ContactsRepository(Get.find()));

    Get.lazyPut(() => ContactsController(Get.find()));
  }
}
