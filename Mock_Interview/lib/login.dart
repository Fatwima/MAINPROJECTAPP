


import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mock_interview/Homepage.dart';
import 'package:mock_interview/forgotpassword.dart';
import 'package:mock_interview/signup.dart';
// import 'package:mock_interview/main.dart';
import 'package:shared_preferences/shared_preferences.dart';




void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();


  Future<void> login_method(String username,String Password) async {
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    print(ip);

    var data = await http.post(Uri.parse("http://" + ip + ":8000/and_login/"),body: {"uname":username,"password":Password});

    print(data.body);
    var jsonData = json.decode(data.body);
    String status=jsonData["status"].toString();

    // Fluttertoast.showToast(
    //     msg: status,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     timeInSecForIosWeb: 1,
    //     backgroundColor: Colors.blue,
    //     textColor: Colors.white,
    //     fontSize: 16.0
    // );

    if(status=="ok")
    {

      Fluttertoast.showToast(
          msg: "Login Successfull",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.blue,
          textColor: Colors.white,
          fontSize: 16.0
      );


      String lid=jsonData["lid"].toString();



      await pref.setString('name', jsonData["name"].toString());

      await pref.setString('photo', jsonData["photo"].toString());
      await pref.setString('email', jsonData["email"].toString());

      await pref.setString('lid', lid);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => new  HomePage()),
      );


    }
    else {


      Fluttertoast.showToast(
          msg: "Invalid username or password",
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
    return Scaffold(backgroundColor: Colors.pinkAccent,
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 100,bottom: 100),
        child: Card(elevation: 5,
          child: Padding(
            padding: const EdgeInsets.only(left: 10,right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
            Icon( Icons.supervised_user_circle_outlined,size: 75,color: Colors.blue,),


                SizedBox(height: 20),
            TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.email_outlined)
                  ),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),

                      labelText: 'Password',
                      prefixIcon: Icon(Icons.key)
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    String username = _usernameController.text;
                    String password = _passwordController.text;
                    login_method(username,password);
                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () async {



                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new  forgotpass()),
                        );

                      },
                      child: Text('Forgot Password?'),
                    ),
                    SizedBox(width: 20),
                    TextButton(
                      onPressed: () async {



                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new  signupapp()),
                        );

                      },
                      child: Text('SignUP'),
                    ),


                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}