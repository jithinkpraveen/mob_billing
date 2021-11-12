import 'dart:developer';

import 'package:mob_billing/db/database.dart';
import 'package:mob_billing/model/user_modes.dart';

abstract class UserRepo {
  Future getUser();
  Future addUser(Users user);
  Future deleteUser(Users user);
}

class UserServices implements UserRepo {
  @override
  Future addUser(Users user) async {
    return await LocalDb.instance.createUser(user);
  }

  @override
  Future getUser() async {
    var res = await LocalDb.instance.getAllUsers();
    log(res.toString());
    return res;
  }

  @override
  Future deleteUser(Users user) async {
    var res = await LocalDb.instance.deleteUser(user.id!);
    return res;
  }
}
