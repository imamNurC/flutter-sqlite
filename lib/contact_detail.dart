import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sqlite/contact.dart';
import 'package:flutter_sqlite/contactdataaccess.dart';
import 'package:get/get.dart';

class ContactDetail extends StatelessWidget {
  int id;
  ContactDetail({super.key, required this.id});
  var dataAcces = ContactDataAccess();
  var _contact = Contact(id: 0, name: "", email: "", phone: "").obs;
  Contact get contact => _contact.value;
  var nameCtl = TextEditingController();
  var emailCtl = TextEditingController();
  var phoneCtl = TextEditingController();
  var formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Contact Detail"),
        backgroundColor: Colors.blue,
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Form(
          key: formkey,
          child:ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "Nama"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Phone"),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Email"),
              ),
              SizedBox(height: 20,),
              SizedBox(
                height: 40,
                child: ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
                child : Text("Save", style: TextStyle(color: Colors.white),)     
              )),
              SizedBox( height : 20 ),
              SizedBox(
                height: 40,
                child: ElevatedButton(onPressed: (){},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8))),
                child : Text("Delete", style: TextStyle(color: Colors.white),)     
              )),
              
            ],
          )
        ),
      ),
    );
  }
}
