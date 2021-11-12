import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mob_billing/model/services_model.dart';
import 'package:mob_billing/services/service_services.dart';
// import 'package:mob_billing/model/user_modes.dart';
// import 'package:mob_billing/services/user_sservices.dart';

class ServicesHomePage extends StatefulWidget {
  const ServicesHomePage({Key? key}) : super(key: key);

  @override
  _ServicesHomePageState createState() => _ServicesHomePageState();
}

class _ServicesHomePageState extends State<ServicesHomePage> {
  final _formKey = GlobalKey<FormState>();
  ServiceServices servicerepo = ServiceServices();
  List<Services> services = [];
  bool loading = true;

  @override
  initState() {
    getServices();
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
        title: const Text("Services"),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : services.isEmpty
              ? const Center(
                  child: Text("No Services added yet please add service first"),
                )
              : ListView.builder(
                  itemCount: services.length,
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
                                  builder: (BuildContext context) =>
                                      AlertDialog(
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
                                          await servicerepo
                                              .deleteService(services[i]);

                                          await getServices();
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
                              Text("Id : ${services[i].id}"),
                              Text("Name : ${services[i].name}"),
                              Text("phone : ${services[i].discretion}"),
                            ],
                          ),
                        ));
                  }),
    );
  }

  adduser() {
    String? discretion;
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
                    discretion = value;
                    return null;
                  },
                  decoration: const InputDecoration(hintText: "discretion"),
                ),
                const SizedBox(height: 10),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // print(name);
                      var data = await addService(Services(
                          name: name,
                          discretion: discretion,
                          createdTime: DateTime.now()));
                      if (data.runtimeType == Services) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Services Added successfully')),
                        );
                        Navigator.pop(context);
                        getServices();
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
  getServices() async {
    var data = await servicerepo.getService();
    // print(data);
    setState(() {
      services = data as List<Services>;
      loading = false;
    });
  }

  //Add user //
  addService(Services service) async {
    var data = await servicerepo.addService(service);
    return data;
  }
}
