import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:houzeo_task/core/routes/app_routes.dart';

import '../../../core/utils/validators.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_textfield.dart';
import '../controller/contacts_controller.dart';

class EditContactScreen extends GetView<ContactsController> {
  const EditContactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Contact',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: controller.editContactFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.h),

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
                            ? Icon(Icons.camera_alt, size: 30.sp)
                            : null,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                Center(
                  child: Text(
                    'Tap to change picture',
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),

                SizedBox(height: 30.h),

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

                AppButton(
                  title: 'Update Contact',
                  onPressed: controller.updateContact,
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
