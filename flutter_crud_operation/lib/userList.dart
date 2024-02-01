import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_crud_operation/SQLDB.dart';
import 'package:flutter_crud_operation/updateUser.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  SQLdb sqLdb = SQLdb();

  Future<List<Map>> getAllUser() async {
    List<Map> users = await sqLdb.getData("SELECT * FROM 'users'");
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
      ),
      body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(
                flex: 11,
                child: Container(
                  child: FutureBuilder(
                    future: getAllUser(),
                    builder: (ctx, snp) {
                      if (snp.hasData) {
                        List<Map> listUser = snp.data!;
                        return ListView.builder(
                            itemCount: listUser.length,
                            itemBuilder: (ctx, index) {
                              return Card(
                                child: ListTile(
                                  leading: Icon(
                                    Icons.movie,
                                    color: Colors.pink,
                                    size: 30,
                                  ),
                                  title: Text(
                                    "${listUser[index]['username']}",
                                    style: TextStyle(
                                        fontSize: 25, color: Colors.pink),
                                  ),
                                  subtitle: Text(
                                    "${listUser[index]['password']} min",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.purple),
                                  ),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateUser(
                                                          id: listUser[index]
                                                              ['id'],
                                                          username:
                                                              listUser[index]
                                                                  ['username'],
                                                          password:
                                                              listUser[index]
                                                                  ['password'],
                                                        )));
                                          },
                                          child: Icon(
                                            Icons.edit,
                                            color: Colors.green,
                                            size: 25,
                                          )),
                                      TextButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) =>
                                                    AlertDialog(
                                                      title: Text(
                                                          "Do you want to delete? ${listUser[index]['username']}"),
                                                      actions: [
                                                        ElevatedButton(
                                                            onPressed:
                                                                () async {
                                                              int rep = await sqLdb
                                                                  .deleteData(
                                                                      "DELETE FROM 'users' WHERE id = ${listUser[index]['id']}");
                                                              if (rep > 0) {
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                setState(() {});
                                                              }
                                                            },
                                                            child: Text("OK")),
                                                        ElevatedButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text("Cancel")),
                                                      ],
                                                    ));
                                          },
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                            size: 25,
                                          ))
                                    ],
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
