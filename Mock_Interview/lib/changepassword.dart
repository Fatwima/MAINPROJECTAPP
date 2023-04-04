
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mock_interview/login.dart';
import 'package:shared_preferences/shared_preferences.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Change password?',
      debugShowCheckedModeBanner: false,
      home: changepass(),
    );
  }
}

class changepass extends StatefulWidget {
  @override
  _changepassState createState() => _changepassState();
}

class _changepassState extends State<changepass> {
  TextEditingController _oldController = TextEditingController();
  TextEditingController _newController = TextEditingController();
  TextEditingController _confirmController = TextEditingController();


  Future<void> forgot_method() async {
    if(_oldController.text =="")
    {
      Fluttertoast.showToast(
          msg: "Enter Old Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
    else if(_confirmController.text =="")
    {
      Fluttertoast.showToast(
          msg: "Enter confirm  Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
   else if(_newController.text =="")
    {
      Fluttertoast.showToast(
          msg: "Enter new Password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
   else if(_newController.text != _confirmController.text)
      {
        Fluttertoast.showToast(
            msg: "Passwords Missmatch",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    print(ip);

    var data = await http.post(
        Uri.parse("http://" + ip + ":8000/and_changepassword/"),
        body: {"old": _oldController.text,"new":_newController.text,"lid":pref.getString("lid").toString()});
    print("------------------------------hey---------------");
    print(data.body);
    var jsonData = json.decode(data.body);
    String status = jsonData["status"].toString();


    if (status == "ok") {
      Fluttertoast.showToast(
          msg: "Password changed successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );




      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new LoginPage()),
      );
    }
    else {
      Fluttertoast.showToast(
          msg: "Invalid  password",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Change password '),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                obscureText: true,
                controller: _oldController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Old password',
                    prefixIcon: Icon(Icons.password)
                ),
              ),
            ),
            Card(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                obscureText: true,
                controller: _newController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'New password',
                    prefixIcon: Icon(Icons.security)
                ),
              ),
            ),
            Card(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
              child: TextFormField(
                obscureText: true,
                controller: _confirmController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Confirm password',
                    prefixIcon: Icon(Icons.security)
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {

                forgot_method();
              },
              child: Text('Change Your password'),
            ),

          ],
        ),
      ),
    );
  }
}
