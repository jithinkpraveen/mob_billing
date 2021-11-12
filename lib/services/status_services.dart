// ignore_for_file: file_names

import 'dart:developer';
import 'package:mob_billing/db/database.dart';
import 'package:mob_billing/model/status_model.dart';

abstract class StatusRepo {
  Future getStatus();
  Future addStatus(Status status);
  Future deleteStatus(Status uStatusser);
}

class StatusServices implements StatusRepo {
  @override
  Future addStatus(Status status) async {
    return await LocalDb.instance.addStatus(status);
  }

  @override
  Future getStatus() async {
    var res = await LocalDb.instance.getAllStatus();
    log(res.toString());
    return res;
  }

  @override
  Future deleteStatus(Status status) async {
    var res = await LocalDb.instance.deleteService(status.id!);
    return res;
  }
}
