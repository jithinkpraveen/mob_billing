import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mob_billing/model/user_modes.dart';
import 'package:mob_billing/services/user_services.dart';

class ClintHomePage extends StatefulWidget {
  const ClintHomePage({Key? key}) : super(key: key);

  @override
  _ClintHomePageState createState() => _ClintHomePageState();
}

class _ClintHomePageState extends State<ClintHomePage> {
  final _formKey = GlobalKey<FormState>();
  UserServices userrepo = UserServices();
  List<Users> users = [];
  bool loading = true;

  @override
  initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          adduser();
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text("Clients"),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, i) {
                return Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey),
                      ],
                      color: Colors.white,
                    ),
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      trailing: IconButton(
                          onPressed: () {
                            showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                title: const Text(
                                    'Are you sure do you want to delete ?'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, 'Cancel'),
                                    child: const Text('NO'),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await userrepo.deleteUser(users[i]);

                                      await getUsers();
                                      Navigator.pop(context, 'OK');
                                    },
                                    child: const Text('YES'),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Id : ${users[i].id}"),
                          Text("Name : ${users[i].name}"),
                          Text("phone : ${users[i].phone1}"),
                          Text("phone 2 : ${users[i].phone2}"),
                          Text("address : ${users[i].address}"),
                        ],
                      ),
                    ));
              }),
    );
  }

  adduser() {
    String? phone1;
    String? phone2;
    String? address;
    String? name;

    showDialog<String>(
      context: context,
      builder: (BuildContext context) => SizedBox(
        height: 200,
        child: Material(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    name = value;
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "Name"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    phone1 = value;
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "phone1"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    phone2 = value;
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "phone2"),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    address = value;
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "address"),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // print(name);
                      var data = await addUser(Users(
                          name: name,
                          phone1: phone1,
                          phone2: phone2,
                          address: address,
                          createdTime: DateTime.now()));
                      if (data.runtimeType == Users) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('User Added successfully')),
                        );
                        Navigator.pop(context);
                        getUsers();
                      }
                    }
                  },
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

// Methords //
// Get all user //
  getUsers() async {
    var data = await userrepo.getUser();
    // print(data);
    setState(() {
      users = data as List<Users>;
      loading = false;
    });
  }

  //Add user //
  addUser(Users user) async {
    var data = await userrepo.addUser(user);
    return data;
  }
}
