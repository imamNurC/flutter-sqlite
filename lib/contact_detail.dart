import 'package:flutter/material.dart';
import 'package:flutter_sqlite/contact.dart';
import 'package:flutter_sqlite/contactdataaccess.dart';
import 'package:get/get.dart';

class ContactDetail extends StatefulWidget {
  final int id;

  ContactDetail({super.key, required this.id});

  @override
  _ContactDetailState createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  final ContactDataAccess dataAccess = ContactDataAccess();
  final Rx<Contact> _contact = Contact(id: 0, name: "", email: "", phone: "").obs;
  Contact get contact => _contact.value;
  final TextEditingController nameCtl = TextEditingController();
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController phoneCtl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.id != 0) {
      loadData();
    }
  }

  void loadData() async {
    var contact = await dataAccess.getByID(widget.id);
    if (contact != null) {
      _contact.value = contact;
      nameCtl.text = contact.name;
      emailCtl.text = contact.email;
      phoneCtl.text = contact.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Detail"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: nameCtl,
                decoration: InputDecoration(labelText: "Nama"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Nama tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: phoneCtl,
                decoration: InputDecoration(labelText: "Phone"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone tidak boleh kosong';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: emailCtl,
                decoration: InputDecoration(labelText: "Email"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email tidak boleh kosong';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Email tidak valid';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      contact.name = nameCtl.text;
                      contact.phone = phoneCtl.text;
                      contact.email = emailCtl.text;
                      if (widget.id == 0) {
                        await dataAccess.insert(contact);
                      } else {
                        await dataAccess.update(contact);
                      }
                      Get.back();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              widget.id != 0
                  ? SizedBox(
                      height: 40,
                      child: ElevatedButton(
                        onPressed: () async {
                          await dataAccess.delete(contact.id);
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8))),
                        child: Text(
                          "Delete",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
