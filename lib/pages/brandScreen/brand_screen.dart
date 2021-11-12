import 'package:flutter/material.dart';
import 'package:mob_billing/model/brand_model.dart' as br;
// import 'package:mob_billing/model/brand_model.dart';
import 'package:mob_billing/services/brand_services.dart';
// import 'package:mob_billing/model/status_model.dart' as st;
// import 'package:mob_billing/services/status_Services.dart';

class BrandHomePage extends StatefulWidget {
  const BrandHomePage({Key? key}) : super(key: key);

  @override
  _BrandHomePageState createState() => _BrandHomePageState();
}

class _BrandHomePageState extends State<BrandHomePage> {
  final _formKey = GlobalKey<FormState>();
  BrandServices brandRepo = BrandServices();
  List<br.Brand> brand = [];
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
        title: const Text("Brands"),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : brand.isEmpty
              ? const Center(
                  child: Text("No Services added yet please add service first"),
                )
              : ListView.builder(
                  itemCount: brand.length,
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
                                          await brandRepo.deleteBrand(brand[i]);

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
                              Text("Id : ${brand[i].id}"),
                              Text("Name : ${brand[i].name}"),
                              Text("phone : ${brand[i].discretion}"),
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
                      var data = await addService(br.Brand(
                          name: name,
                          discretion: discretion,
                          createdTime: DateTime.now()));
                      if (data.runtimeType == br.Brand) {
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
    var data = await brandRepo.getBrand();
    // print(data);
    setState(() {
      brand = data as List<br.Brand>;
      loading = false;
    });
  }

  //Add user //
  addService(br.Brand brand) async {
    var data = await brandRepo.addBrand(brand);
    return data;
  }
}
