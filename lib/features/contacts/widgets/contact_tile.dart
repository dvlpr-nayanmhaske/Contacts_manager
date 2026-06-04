import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../models/contact_model.dart';

class ContactTile extends StatelessWidget {
  final ContactModel contact;
  final VoidCallback? onTap;

  const ContactTile({super.key, required this.contact, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.only(bottom: 10.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        leading: CircleAvatar(
          radius: 24.r,
          child: Text(
            contact.name.isNotEmpty ? contact.name[0].toUpperCase() : '?',
          ),
        ),
        title: Text(
          contact.name,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
        ),
        subtitle: Text(contact.phone, style: TextStyle(fontSize: 13.sp)),
        trailing: contact.isFavorite
            ? const Icon(Icons.star, color: Colors.amber)
            : null,
      ),
    );
  }
}
