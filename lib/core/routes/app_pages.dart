import 'package:get/get.dart';
import 'package:houzeo_task/features/contacts/bindings/contacts_binding.dart';
import 'package:houzeo_task/features/contacts/view/add_contact_screen.dart';
import 'package:houzeo_task/features/contacts/view/contacts_detail_screen.dart';
import 'package:houzeo_task/features/contacts/view/edit_contact_screen.dart';
import 'package:houzeo_task/features/dashboard/bindings/dashboard_binding.dart';

import 'package:houzeo_task/features/dashboard/view/dashboard_screen.dart';
import 'package:houzeo_task/features/splash/view/spalsh_screen.dart';

import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardScreen(),
      bindings: [DashboardBinding(), ContactsBinding()],
    ),
    GetPage(name: AppRoutes.addContact, page: () => AddContactScreen()),
    GetPage(
      name: AppRoutes.contactDetails,
      page: () => const ContactDetailsScreen(),
    ),
    GetPage(name: AppRoutes.editContact, page: () => const EditContactScreen()),
    GetPage(name: AppRoutes.splash, page: () => const SplashScreen()),
  ];
}
