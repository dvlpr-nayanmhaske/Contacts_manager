import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/empty_state_widget.dart';
import '../controller/contacts_controller.dart';
import '../widgets/contact_tile.dart';

class FavoritesScreen extends GetView<ContactsController> {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Favorites',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              const Text('Your favorite contacts'),

              const SizedBox(height: 20),

              Expanded(
                child: Obx(() {
                  if (controller.favoriteContacts.isEmpty) {
                    return const EmptyStateWidget(
                      title: 'No Favorite Contacts',
                      subtitle: 'Mark contacts as favorite to see them here.',
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.favoriteContacts.length,
                    itemBuilder: (_, index) {
                      final contact = controller.favoriteContacts[index];

                      return ContactTile(contact: contact, onTap: () {});
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
