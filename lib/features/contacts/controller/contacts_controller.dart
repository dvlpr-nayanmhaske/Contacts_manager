import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:houzeo_task/core/routes/app_pages.dart';
import 'package:houzeo_task/core/routes/app_routes.dart';
import 'package:houzeo_task/features/contacts/repository/contacts_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/contact_model.dart';

class ContactsController extends GetxController {
  ///=============================================   CONTROLLERS ============================================///
  ContactModel? selectedContact;
  final addContactFormKey = GlobalKey<FormState>();
  final editContactFormKey = GlobalKey<FormState>();
  final searchController = TextEditingController();

  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  final emailController = TextEditingController();

  final companyController = TextEditingController();

  final addressController = TextEditingController();

  final notesController = TextEditingController();

  final selectedImagePath = ''.obs;
  final searchQuery = ''.obs;

  final isFavorite = false.obs;

  ///=============================================   CONTROLLERS ============================================///
  ///=============================================   COMPUTED LIST ============================================///
  List<ContactModel> get filteredContacts {
    if (searchQuery.value.isEmpty) {
      return contacts;
    }

    return contacts.where((contact) {
      return contact.name.toLowerCase().contains(
            searchQuery.value.toLowerCase(),
          ) ||
          contact.phone.contains(searchQuery.value);
    }).toList();
  }

  ///=============================================   COMPUTED LIST ============================================///

  final ContactsRepository repository;

  ContactsController(this.repository);

  final contacts = <ContactModel>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    loadContacts();
  }

  Future<void> loadContacts() async {
    try {
      isLoading.value = true;

      contacts.value = await repository.getContacts();
    } finally {
      isLoading.value = false;
    }
  }

  List<ContactModel> get favoriteContacts {
    return contacts.where((contact) => contact.isFavorite).toList();
  }

  ///=============================================   PICK IMAGE  ============================================///

  Future<void> pickImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      selectedImagePath.value = image.path;
    }
  }

  ///=============================================   PICK IMAGE  ============================================///

  ///=============================================   SAVE CONTACTS ============================================///

  Future<void> addContact() async {
    if (!addContactFormKey.currentState!.validate()) {
      return;
    }

    final contact = ContactModel(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      company: companyController.text.trim(),
      address: addressController.text.trim(),
      notes: notesController.text.trim(),
      image: selectedImagePath.value,
      isFavorite: isFavorite.value,
      createdAt: DateTime.now().toIso8601String(),
    );

    await repository.addContact(contact);

    await loadContacts();
    clearForm();

    Get.back();

    Get.snackbar('Success', 'Contact added successfully');
  }

  ///=============================================   SAVE CONTACTS ============================================///
  ///=============================================   CLEAR FORM ============================================///

  void clearForm() {
    addContactFormKey.currentState?.reset();
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    companyController.clear();
    addressController.clear();
    notesController.clear();

    selectedImagePath.value = '';

    isFavorite.value = false;
  }

  ///=============================================   CLEAR FORM ============================================///
  ///=============================================   CALLING ============================================///

  Future<void> callContact(String phone) async {
    final Uri phoneUri = Uri.parse('tel:$phone');

    await launchUrl(phoneUri);
  }

  ///=============================================   CALLING ============================================///

  ///=============================================   DELETE CONTACT ============================================///

  Future<void> deleteContactDialog(int id) async {
    Get.defaultDialog(
      title: 'Delete Contact',
      middleText: 'Are you sure you want to delete this contact?',
      textCancel: 'Cancel',
      textConfirm: 'Delete',
      confirmTextColor: Colors.white,
      onConfirm: () async {
        await repository.deleteContact(id);

        await loadContacts();

        Get.back(); // Dialog

        Get.back(); // Details Screen

        Get.snackbar('Success', 'Contact deleted successfully');
      },
    );
  }

  ///=============================================   DELETE CONTACT ============================================///
  void populateContact(ContactModel contact) {
    selectedContact = contact;

    nameController.text = contact.name;
    phoneController.text = contact.phone;
    emailController.text = contact.email ?? '';
    companyController.text = contact.company ?? '';
    addressController.text = contact.address ?? '';
    notesController.text = contact.notes ?? '';

    selectedImagePath.value = contact.image ?? '';

    isFavorite.value = contact.isFavorite;
  }

  ///=============================================   UPDATE CONTACT ============================================///

  Future<void> updateContact() async {
    if (!editContactFormKey.currentState!.validate()) {
      return;
    }

    final updatedContact = ContactModel(
      id: selectedContact!.id,
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      company: companyController.text.trim(),
      address: addressController.text.trim(),
      notes: notesController.text.trim(),
      image: selectedImagePath.value,
      isFavorite: isFavorite.value,
      createdAt: selectedContact!.createdAt,
    );

    await repository.updateContact(updatedContact);

    await loadContacts();

    clearForm();

    Get.toNamed(AppRoutes.dashboard);

    Get.snackbar('Success', 'Contact updated successfully');
  }

  ///=============================================   UPDATE CONTACT ============================================///
  ///=============================================   GROUPED LIST ============================================///

  Map<String, List<ContactModel>> get groupedContacts {
    final Map<String, List<ContactModel>> grouped = {};

    for (final contact in filteredContacts) {
      final letter = contact.name[0].toUpperCase();

      grouped.putIfAbsent(letter, () => []);

      grouped[letter]!.add(contact);
    }

    return grouped;
  }

  ///=============================================  GROUPED LIST ============================================///
  ///=============================================  DELETE CONTACT DISMMISIBLE ============================================///
  Future<void> deleteContact(int id) async {
    await repository.deleteContact(id);

    await loadContacts();

    Get.snackbar(
      'Deleted',
      'Contact removed successfully',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  ///============================================= DELETE CONTACT DISMMISIBLE ============================================///
}
