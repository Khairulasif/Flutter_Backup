import 'package:flutter/material.dart';
import 'package:flutter_crud_operation/userList.dart';

import 'SQLDB.dart';

class UpdateUser extends StatefulWidget {
  final id;
  final username;
  final password;
  const UpdateUser({Key? key, this.id, this.username, this.password})
      : super(key: key);

  @override
  State<UpdateUser> createState() => _UpdateFilmState();
}

class _UpdateFilmState extends State<UpdateUser> {
  TextEditingController user = TextEditingController();
  TextEditingController pass = TextEditingController();
  SQLdb sqLdb = SQLdb();
  @override
  void initState() {
    user.text = widget.username;
    pass.text = widget.password.toString();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Update User"),
        ),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: user,
                style: TextStyle(fontSize: 20, color: Colors.purple),
                decoration: InputDecoration(
                  labelText: "User Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextField(
                controller: pass,
                style: TextStyle(fontSize: 20, color: Colors.purple),
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(40))),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    int rep = await sqLdb.updateData('''
              UPDATE "users" SET
              username = "${user.text}",
              password = ${int.parse(pass.text)}
              WHERE id = "${widget.id}"
              ''');
                    if (rep > 0) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => UserList()),
                          (route) => false);
                    }
                  },
                  child: Text("Update"))
            ],
          ),
        ));
  }
}
