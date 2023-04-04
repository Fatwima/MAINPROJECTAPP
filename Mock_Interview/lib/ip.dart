import 'package:flutter/material.dart';
import 'package:mock_interview/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      home: ipaddr(),

    );
  }
}

class ipaddr extends StatefulWidget {
  @override
  _ipaddrState createState() => _ipaddrState();
}

class _ipaddrState extends State<ipaddr> {
  TextEditingController _ipController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IP Page'),

      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
              child: TextField(
                controller: _ipController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: 'ip',
                    prefixIcon: Icon(Icons.email_outlined)
                ),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String ip = _ipController.text;
                final prefs = await SharedPreferences.getInstance();


                await prefs.setString('ip', ip);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new  LoginPage()),
                );

              },
              child: Text('IP ADDRESS'),
            ),
            SizedBox(height: 20),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //
            //     SizedBox(width: 20),
            //     TextButton(
            //       onPressed: () {
            //         // Do something when sign up link is pressed
            //       },
            //       child: Text('IP CONTROLLER'),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),

    );
  }
}