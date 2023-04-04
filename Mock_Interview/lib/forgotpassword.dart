
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
      title: 'Forgot password?',
      debugShowCheckedModeBanner: false,
      home: forgotpass(),
    );
  }
}

class forgotpass extends StatefulWidget {
  @override
  _forgotpassState createState() => _forgotpassState();
}

class _forgotpassState extends State<forgotpass> {
  TextEditingController _mailidController = TextEditingController();


  Future<void> forgot_method(String mailid) async {
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    print(ip);

    var data = await http.post(
        Uri.parse("http://" + ip + ":8000/and_forgotpassword/"),
        body: {"maild": mailid});
    // print("------------------------------hey---------------");
    print(data.body);
    var jsonData = json.decode(data.body);
    String status = jsonData["status"].toString();


    if (status == "ok") {
      Fluttertoast.showToast(
          msg: "Change",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );


      String lid = jsonData["lid"].toString();


      await pref.setString('lid', lid);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new LoginPage()),
      );
    }
    // else {
    //   Fluttertoast.showToast(
    //       msg: "Invalid username or password",
    //       toastLength: Toast.LENGTH_SHORT,
    //       gravity: ToastGravity.CENTER,
    //       timeInSecForIosWeb: 1,
    //       backgroundColor: Colors.blue,
    //       textColor: Colors.white,
    //       fontSize: 16.0
    //   );
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
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
                controller: _mailidController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'Mail id',
                    prefixIcon: Icon(Icons.email_outlined)
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String username = _mailidController.text;
                forgot_method(username);
              },
              child: Text('Change'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


              ],
            ),
          ],
        ),
      ),
    );
  }
}
