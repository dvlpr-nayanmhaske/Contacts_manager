import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:houzeo_task/core/routes/app_routes.dart';
import 'package:houzeo_task/core/widgets/empty_state_widget.dart';
import 'package:houzeo_task/features/contacts/controller/contacts_controller.dart';
import 'package:houzeo_task/features/contacts/widgets/alphabet_header.dart';
import 'package:houzeo_task/features/contacts/widgets/contact_tile.dart';
import 'package:houzeo_task/features/contacts/widgets/search_contact_bar.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ContactsController>();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        floatingActionButton: FloatingActionButton.extended(
          elevation: 2,
          onPressed: () {
            controller.clearForm();
            Get.toNamed(AppRoutes.addContact);
          },
          icon: const Icon(Icons.person_add),
          label: const Text('Add Contact'),
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Contacts',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 6.h),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Manage your contacts',
                      style: TextStyle(fontSize: 14.sp),
                    ),

                    Obx(
                      () => Text(
                        '${controller.contacts.length} Contacts',
                        style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                SearchContactBar(
                  controller: controller.searchController,
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                  },
                ),

                SizedBox(height: 20.h),

                Expanded(
                  child: Obx(() {
                    if (controller.contacts.isEmpty) {
                      return const EmptyStateWidget(
                        title: 'No Contacts Yet',
                        subtitle:
                            'Tap Add Contact to create your first contact.',
                      );
                    }

                    if (controller.filteredContacts.isEmpty) {
                      return const EmptyStateWidget(
                        title: 'No Contacts Found',
                        subtitle: 'Try another search.',
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// Favorites Section
                        if (controller.favoriteContacts.isNotEmpty) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Favorite Contacts',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              ),

                              Text(
                                '${controller.favoriteContacts.length}',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 12.h),

                          SizedBox(
                            height: 100.h,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.favoriteContacts.length,
                              itemBuilder: (context, index) {
                                final contact =
                                    controller.favoriteContacts[index];

                                return GestureDetector(
                                  onTap: () {
                                    Get.toNamed(
                                      AppRoutes.contactDetails,
                                      arguments: contact,
                                    );
                                  },
                                  child: Container(
                                    width: 90.w,
                                    margin: EdgeInsets.only(right: 12.w),
                                    child: Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 28.r,
                                          child: Text(
                                            contact.name.isNotEmpty
                                                ? contact.name[0].toUpperCase()
                                                : '?',
                                          ),
                                        ),

                                        SizedBox(height: 8.h),

                                        Text(
                                          contact.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 12.sp),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 20.h),
                        ],

                        /// Contacts List
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await controller.loadContacts();
                            },
                            child: ListView(
                              keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior.onDrag,
                              children: controller.groupedContacts.entries.map((
                                entry,
                              ) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    AlphabetHeader(letter: entry.key),

                                    ...entry.value.map((contact) {
                                      return Dismissible(
                                        key: ValueKey(contact.id),

                                        direction: DismissDirection.endToStart,

                                        background: Container(
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.only(
                                            right: 20,
                                          ),
                                          margin: const EdgeInsets.only(
                                            bottom: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.circular(
                                              16,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),

                                        onDismissed: (_) async {
                                          await controller.deleteContact(
                                            contact.id!,
                                          );

                                          Get.snackbar(
                                            'Deleted',
                                            '${contact.name} removed',
                                            snackPosition: SnackPosition.BOTTOM,
                                            duration: const Duration(
                                              seconds: 2,
                                            ),
                                          );
                                        },

                                        child: ContactTile(
                                          contact: contact,
                                          onTap: () {
                                            FocusScope.of(context).unfocus();

                                            Get.toNamed(
                                              AppRoutes.contactDetails,
                                              arguments: contact,
                                            );
                                          },
                                        ),
                                      );
                                    }),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
