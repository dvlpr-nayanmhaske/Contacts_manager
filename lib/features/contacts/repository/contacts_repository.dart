import '../datasource/contacts_local_datasource.dart';
import '../models/contact_model.dart';

class ContactsRepository {
  final ContactsLocalDatasource datasource;

  ContactsRepository(this.datasource);

  Future<List<ContactModel>> getContacts() {
    return datasource.getContacts();
  }

  Future<int> addContact(ContactModel contact) {
    return datasource.insertContact(contact);
  }

  Future<int> updateContact(ContactModel contact) {
    return datasource.updateContact(contact);
  }

  Future<int> deleteContact(int id) {
    return datasource.deleteContact(id);
  }
}
