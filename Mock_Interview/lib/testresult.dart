

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const testresult());
}

class testresult extends StatelessWidget {
  const testresult({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Result page',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const testresultPage(title: 'TEST RESULT'),
    );
  }
}

class testresultPage extends StatefulWidget {
  const testresultPage({super.key, required this.title});


  final String title;

  @override
  State<testresultPage> createState() => _testresultPageState();
}

class _testresultPageState extends State<testresultPage> {


  _testresultPageState()  {
and_userresult();


  }

  String Mark=" ";
  String Suggestion=" ";



void and_userresult() async {



      final pref = await SharedPreferences.getInstance();
setState(() {
  Mark=pref.getString("mark").toString();
  Suggestion=pref.getString("description").toString();
  print( Mark);
});




  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("YOUR RESULT"
            ""),
      ),
      body:  Card(
        elevation: 8,
        margin: EdgeInsets.all(10),
        child: Column(
          children: [


            SizedBox(height: 80,
              child: Card(
                child: Align(
                  alignment: Alignment.center,child:
                Text(Mark),),
              ),),


            SizedBox(height: 250,
              // child:Text("Job Name  : "+Mark_[index].toString())),
              child: Card(
                child: Align(
                  alignment: Alignment.center,child:
                Text(Suggestion),),
              ),),

          ],),
      ),
    );
  }

// This trailing comma makes auto-formatting nicer for build methods.

}
