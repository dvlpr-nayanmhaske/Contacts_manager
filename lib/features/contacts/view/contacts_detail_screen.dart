import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:houzeo_task/core/routes/app_routes.dart';

import '../controller/contacts_controller.dart';
import '../models/contact_model.dart';

class ContactDetailsScreen extends GetView<ContactsController> {
  const ContactDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ContactModel contact = Get.arguments;

    return Scaffold(
      appBar: AppBar(title: const Text('Contact Details')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            /// Avatar
            Hero(
              tag: 'contact_${contact.id}',
              child: CircleAvatar(
                radius: 55.r,
                backgroundImage:
                    contact.image != null && contact.image!.isNotEmpty
                    ? FileImage(File(contact.image!))
                    : null,
                child: contact.image == null || contact.image!.isEmpty
                    ? Text(
                        contact.name[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ),

            SizedBox(height: 16.h),

            Text(
              contact.name,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8.h),

            Text(
              contact.phone,
              style: TextStyle(fontSize: 16.sp, color: Colors.grey),
            ),

            SizedBox(height: 25.h),

            /// Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    controller.callContact(contact.phone);
                  },
                  icon: const Icon(Icons.call),
                  label: const Text('Call'),
                ),

                OutlinedButton.icon(
                  onPressed: () {
                    controller.populateContact(contact);

                    Get.toNamed(AppRoutes.editContact);
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit'),
                ),
              ],
            ),

            SizedBox(height: 30.h),

            /// Details Card
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.w),
                child: Column(
                  children: [
                    _infoTile(title: 'Phone', value: contact.phone),

                    if ((contact.email ?? '').isNotEmpty)
                      _infoTile(title: 'Email', value: contact.email!),

                    if ((contact.company ?? '').isNotEmpty)
                      _infoTile(title: 'Company', value: contact.company!),

                    if ((contact.address ?? '').isNotEmpty)
                      _infoTile(title: 'Address', value: contact.address!),

                    if ((contact.notes ?? '').isNotEmpty)
                      _infoTile(title: 'Notes', value: contact.notes!),

                    _infoTile(
                      title: 'Favorite',
                      value: contact.isFavorite ? 'Yes' : 'No',
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 30.h),

            /// Delete Button
            SizedBox(
              width: double.infinity,
              child: TextButton.icon(
                onPressed: () {
                  controller.deleteContactDialog(contact.id!);
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                label: const Text(
                  'Delete Contact',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoTile({required String title, required String value}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey),
            ),
          ),

          Expanded(
            flex: 4,
            child: Text(
              value,
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
