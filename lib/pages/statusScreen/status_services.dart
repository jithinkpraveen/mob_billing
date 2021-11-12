import 'package:flutter/material.dart';
import 'package:mob_billing/model/status_model.dart' as st;
import 'package:mob_billing/services/status_Services.dart';

class StatusHomePage extends StatefulWidget {
  const StatusHomePage({Key? key}) : super(key: key);

  @override
  _StatusHomePageState createState() => _StatusHomePageState();
}

class _StatusHomePageState extends State<StatusHomePage> {
  final _formKey = GlobalKey<FormState>();
  StatusServices statusRepo = StatusServices();
  List<st.Status> status = [];
  bool loading = true;

  @override
  initState() {
    getStatus();
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
        title: const Text("Status"),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : status.isEmpty
              ? const Center(
                  child: Text("No Services added yet please add service first"),
                )
              : ListView.builder(
                  itemCount: status.length,
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
                                          await statusRepo
                                              .deleteStatus(status[i]);

                                          await getStatus();
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
                              Text("Id : ${status[i].id}"),
                              Text("Name : ${status[i].name}"),
                              Text("phone : ${status[i].discretion}"),
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
                      var data = await addService(st.Status(
                          name: name,
                          discretion: discretion,
                          createdTime: DateTime.now()));
                      if (data.runtimeType == st.Status) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Status Added successfully')),
                        );
                        Navigator.pop(context);
                        getStatus();
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
  getStatus() async {
    var data = await statusRepo.getStatus();
    // print(data);
    setState(() {
      status = data as List<st.Status>;
      loading = false;
    });
  }

  //Add user //
  addService(st.Status service) async {
    var data = await statusRepo.addStatus(service);
    return data;
  }
}
