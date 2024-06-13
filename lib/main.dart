import 'package:flutter/material.dart';
import 'package:flutter_sqlite/contact.dart';
import 'package:flutter_sqlite/contactdataaccess.dart';
import 'package:get/get.dart';

import 'contact_detail.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ContactDataAccess dataAccess = ContactDataAccess();
  final RxList<Contact> list = <Contact>[].obs;

  loadData() async {
    var contacts = await dataAccess.getAll();
    list.clear();
    list.addAll(contacts);
  }

  @override
  Widget build(BuildContext context) {
    loadData();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter SQLite",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter SQLite"),
          backgroundColor: Colors.blue,
        ),
        body: Container(
          child: Obx(() => ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  var contact = list[index];
                  return ListTile(
                    title: Text(contact.name),
                    subtitle: Text(contact.phone),
                    trailing: Text(contact.email),
                    onTap: () async {
                      await Get.to(() => ContactDetail(id: contact.id));
                      loadData();
                    },
                    onLongPress: () async {
                      await dataAccess.delete(contact.id);
                      loadData();
                    },
                  );
                },
              )),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Get.to(() => ContactDetail(id: 0)); // Form kosong untuk input baru
            loadData();
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
