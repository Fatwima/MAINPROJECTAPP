import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:mock_interview/interviews.dart';
import 'package:mock_interview/profile.dart';
import 'dart:convert';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter DropDownButton',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const interr(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class interr extends StatefulWidget {
  const interr({Key? key}) : super(key: key);

  @override
  _interrState createState() => _interrState();
}

class _interrState extends State<interr> {
  List categoryItemlist = [];

  Future getAllCategory() async {
    final pref = await SharedPreferences.getInstance();
    String ip = pref.getString("ip").toString();
    var baseUrl = "http://" + ip + ":8000/and_attendinter/";

    http.Response response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      print(jsonData);
      setState(() {
        categoryItemlist = jsonData["data"];
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllCategory();
  }

  var dropdownvalue;
  var dropdownvalueSubject;
  var subjectItemlist = [];
  int counter = 0;
  //
  // Future getSubjects(getClassCode) async {
  //   var baseUrlSubject = "https://gssskhokhar.com/api/classes/$getClassCode";
  //   http.Response responseSubject = await http.get(Uri.parse(baseUrlSubject));
  //   if (responseSubject.statusCode == 200) {
  //     var jsonDataSubject = json.decode(responseSubject.body);
  //     setState(() {
  //       subjectItemlist.add(jsonDataSubject);
  //       print(subjectItemlist);
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DropDown List"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton(
              hint: Text('Select category'),
              items: categoryItemlist.map((item) {
                return DropdownMenuItem(
                  value: item['id'].toString(),
                  child: Text(item['cat_name'].toString()),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {

                    counter = counter++;

                  dropdownvalue = newVal;
                 // getSubjects(dropdownvalue);
                });
              },
              value: dropdownvalue,
            ),



            SizedBox(height: 100,width: 100,),
            ElevatedButton(
              onPressed: () async {
                if (counter == 0) {
                  Fluttertoast.showToast(
                      msg: "can't",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 16.0
                  );
                }
                else
                {
                  {
                    final pref = await SharedPreferences.getInstance();
                    await pref.setString('newval', dropdownvalue);


                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new InterviewviewPage()),
                  );
                }

},
              child: Text('Attend'),
            ),
            // DropdownButton(
            //   hint: Text('Selected Class Code Here'),
            //   items: subjectItemlist.map((item) {
            //     return DropdownMenuItem(
            //       value: item['ClassCode'].toString(),
            //       child: Text(item['ClassName'].toString()),
            //     );
            //   }).toList(),
            //   onChanged: (newValSubject) {
            //     setState(() {
            //       dropdownvalueSubject = newValSubject;
            //     });
            //   },
            //   value: dropdownvalueSubject,
            // ),
          ],
        ),
      ),
    );
  }
}