import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houzeo_task/features/contacts/view/contacts_screen.dart';
import 'package:houzeo_task/features/contacts/view/favorites_Screen.dart';
import 'package:houzeo_task/features/dashboard/controller/dashboard_controller.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screens = [const ContactsScreen(), const FavoritesScreen()];

    return Obx(
      () => Scaffold(
        body: screens[controller.selectedIndex.value],

        bottomNavigationBar: NavigationBar(
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: controller.changeTab,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.people_outline),
              selectedIcon: Icon(Icons.people),
              label: 'Contacts',
            ),
            NavigationDestination(
              icon: Icon(Icons.star_outline),
              selectedIcon: Icon(Icons.star),
              label: 'Favorites',
            ),
          ],
        ),
      ),
    );
  }
}
