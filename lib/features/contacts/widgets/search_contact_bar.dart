import 'package:flutter/material.dart';

class SearchContactBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const SearchContactBar({super.key, required this.controller, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: (_) {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      textInputAction: TextInputAction.search,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: 'Search contacts',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        filled: true,
      ),
    );
  }
}
