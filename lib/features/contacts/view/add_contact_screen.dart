import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:houzeo_task/features/contacts/controller/contacts_controller.dart';

import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_textfield.dart';

class AddContactScreen extends GetView<ContactsController> {
  AddContactScreen({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Contact',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: controller.addContactFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

                /// Profile Image
                Center(
                  child: Obx(
                    () => GestureDetector(
                      onTap: controller.pickImage,
                      child: CircleAvatar(
                        radius: 55.r,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primaryContainer,
                        backgroundImage:
                            controller.selectedImagePath.value.isNotEmpty
                            ? FileImage(
                                File(controller.selectedImagePath.value),
                              )
                            : null,
                        child: controller.selectedImagePath.value.isEmpty
                            ? Icon(Icons.camera_alt_outlined, size: 35.sp)
                            : null,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                Center(
                  child: Text(
                    'Tap to add profile picture',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),

                SizedBox(height: 30.h),

                /// Name
                Text(
                  'Name *',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 8.h),

                AppTextField(
                  controller: controller.nameController,
                  hintText: 'Enter full name',
                  validator: Validators.requiredField,
                ),

                SizedBox(height: 18.h),

                /// Phone
                Text(
                  'Phone Number *',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 8.h),

                AppTextField(
                  controller: controller.phoneController,
                  hintText: 'Enter phone number',
                  keyboardType: TextInputType.phone,
                  validator: Validators.phone,
                ),

                SizedBox(height: 18.h),

                /// Email
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 8.h),

                AppTextField(
                  controller: controller.emailController,
                  hintText: 'Enter email',
                  keyboardType: TextInputType.emailAddress,
                  validator: Validators.email,
                ),

                SizedBox(height: 18.h),

                /// Company
                Text(
                  'Company',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 8.h),

                AppTextField(
                  controller: controller.companyController,
                  hintText: 'Enter company name',
                ),

                SizedBox(height: 18.h),

                /// Address
                Text(
                  'Address',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 8.h),

                AppTextField(
                  controller: controller.addressController,
                  hintText: 'Enter address',
                ),

                SizedBox(height: 18.h),

                /// Notes
                Text(
                  'Notes',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                SizedBox(height: 8.h),

                AppTextField(
                  controller: controller.notesController,
                  hintText: 'Additional notes',
                  maxLines: 4,
                ),

                SizedBox(height: 20.h),

                /// Favorite Switch
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Obx(
                    () => SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        'Mark as Favorite',
                        style: TextStyle(fontSize: 15.sp),
                      ),
                      value: controller.isFavorite.value,
                      onChanged: (value) {
                        controller.isFavorite.value = value;
                      },
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                /// Save Button
                AppButton(
                  title: 'Save Contact',
                  onPressed: controller.addContact,
                ),

                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
