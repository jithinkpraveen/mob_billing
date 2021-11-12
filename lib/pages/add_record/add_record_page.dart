import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mob_billing/db/database.dart';
import 'package:mob_billing/model/brand_model.dart';
import 'package:mob_billing/model/record_model.dart';
import 'package:mob_billing/model/services_model.dart';
import 'package:mob_billing/model/status_model.dart';
import 'package:mob_billing/model/user_modes.dart';

class AddRecordPage extends StatefulWidget {
  const AddRecordPage({Key? key}) : super(key: key);

  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  List<Brand>? _brand;
  List<Users>? _users;
  List<Status>? _status;
  List<Services>? _services;
  LocalDb db = LocalDb.instance;
  @override
  void initState() {
    setState(() {
      getFata();
    });
    super.initState();
  }

  void getFata() async {
    _brand = await db.getAllBrands();
    _users = await db.getAllUsers();
    _status = await db.getAllStatus();
    _services = await db.getAllServices();
    setState(() {});

    print(_services);
  }

  Brand? _selectedBrand;
  Users? _selectedUser;
  Status? _selectedStatus;
  Services? _selectedServices;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(width: double.infinity),
          DropdownButton<Brand>(
            value: _selectedBrand,
            hint: const Text("Select a Brand"),
            iconSize: 24,
            elevation: 16,
            onChanged: (newValue) {
              setState(() {
                _selectedBrand = newValue!;
              });
            },
            items: _brand?.map<DropdownMenuItem<Brand>>((Brand value) {
              return DropdownMenuItem<Brand>(
                value: value,
                child: Text(value.name!),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          DropdownButton<Users>(
            value: _selectedUser,
            hint: const Text("Select a User"),
            iconSize: 24,
            elevation: 16,
            onChanged: (newValue) {
              setState(() {
                _selectedUser = newValue!;
              });
            },
            items: _users?.map<DropdownMenuItem<Users>>((Users value) {
              return DropdownMenuItem<Users>(
                value: value,
                child: Text(value.name!),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          DropdownButton<Status>(
            value: _selectedStatus,
            hint: const Text("Select a Status"),
            iconSize: 24,
            elevation: 16,
            onChanged: (newValue) {
              setState(() {
                _selectedStatus = newValue!;
              });
            },
            items: _status?.map<DropdownMenuItem<Status>>((Status value) {
              return DropdownMenuItem<Status>(
                value: value,
                child: Text(value.name!),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          DropdownButton<Services>(
            value: _selectedServices,
            hint: const Text("Select a Services"),
            iconSize: 24,
            elevation: 16,
            onChanged: (newValue) {
              setState(() {
                _selectedServices = newValue!;
              });
            },
            items: _services?.map<DropdownMenuItem<Services>>((Services value) {
              return DropdownMenuItem<Services>(
                value: value,
                child: Text(value.name!),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () async {
                if (_selectedBrand != null &&
                    _selectedUser != null &&
                    _selectedStatus != null &&
                    _selectedServices != null) {
                  try {
                    await db.addRecord(Record(
                      model: _selectedBrand?.id.toString(),
                      status: _selectedStatus?.id.toString(),
                      service: _selectedServices?.id.toString(),
                      user: _selectedUser?.id.toString(),
                      time: DateTime.now(),
                      timeServices: DateTime.now(),
                    ));
                    Navigator.pop(context);
                  } catch (e) {
                    log(e.toString());
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Please select all values')));
                }
              },
              child: const Text("Add Data"))
        ],
      ),
    );
  }
}
