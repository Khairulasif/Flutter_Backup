import 'package:flutter/material.dart';
import 'package:flutter_crud_operation/SQLDB.dart';
import 'package:flutter_crud_operation/userList.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  SQLdb sqLdb = SQLdb();

  Future<void> _login() async {
    String username = _usernameController.text.trim();
    String password = _passwordController.text.trim();

    // Perform login logic here
    // You can validate the username and password, make API calls, etc.

    if (username.isNotEmpty && password.isNotEmpty) {
      int rep = await sqLdb.insertData(
          "INSERT INTO 'users' (username, password) VALUES (\"${_usernameController.text}\",${int.parse(_passwordController.text)})");
      if (rep > 0) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => UserList()),
            (route) => false);
      }

      // Successful login
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Successful'),
            content: Text('Welcome, $username!'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    } else {
      // Invalid login
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Login Failed'),
            content: Text('Invalid username or password.'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(
                labelText: 'Username',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Text('Login'),
              onPressed: _login,
            ),
          ],
        ),
      ),
    );
  }
}
