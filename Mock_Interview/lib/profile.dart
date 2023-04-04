import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:email_validator/email_validator.dart';
import 'package:mock_interview/editprofile.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const profileapp());
}

class profileapp extends StatelessWidget {
  const profileapp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ProfileUpPage(),
    );
  }
}

class ProfileUpPage extends StatefulWidget {
  const ProfileUpPage({Key? key}) : super(key: key);

  @override
  State<ProfileUpPage> createState() => _SProfileUpPagePageState();
}

class _SProfileUpPagePageState extends State<ProfileUpPage> {
  _SProfileUpPagePageState(){
    Profileview();
  }
String Name=" ";
String Place=" ";
String Gender=" ";
String Dob=" ";
String Qualification=" ";
String Phone=" ";
String Email=" ";
String Photo=" ";
Future<void> Profileview() async {
  final pref = await SharedPreferences.getInstance();
  String ip = pref.getString("ip").toString();
  print(ip);

  var data = await http.post(Uri.parse("http://" + ip + ":8000/profile_post/"),body: {"lid":pref.getString("lid").toString()});
  print(data.body);
  var jsonData = json.decode(data.body);
  String status=jsonData["status"].toString();
  if(status=="ok")
    {
      setState(() {
        Name=jsonData["name"].toString();
        Email=jsonData["emailid"].toString();
        Qualification=jsonData["qualification"].toString();
        Phone=jsonData["phone"].toString();
        Place=jsonData["place"].toString();
        Gender=jsonData["gender"].toString();
        Dob=jsonData["dob"].toString();
        Photo="http://" + ip + ":8000"+jsonData["photo"].toString();
      });
    }
  else{
    Fluttertoast.showToast(
        msg: "Failed",
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
        title: const Text('Profile'),
      ),
      body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[

              // Card(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15)),
              //   child:Row(
              //     children: [
              //
              //       SizedBox(width:100,height: 80,
              //         child: Align(
              //
              //           alignment: Alignment.center,child:
              //         Image.network(Photo,height: 200,width: 200,)),),
              //
              //     ],
              //   ),
              // ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15)),
              //   child:Row(
              //     children: [


                  SizedBox(width:100,height: 80,
                    child: Align(
                      alignment: Alignment.center,child:
                            CircleAvatar(radius: 100, child: ClipOval(
                                    child: Image.network(Photo,fit: BoxFit.fill,width: 200,height: 200,),),)

                            ),
                  ),


              //     ],
              //   ),
              // ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child:Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Colors.indigo,
                      size: 24.0,
                      semanticLabel: 'Name',
                    ),
                    SizedBox(width:100,height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text("Name"),),),
                    SizedBox(height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text(Name),),),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child:Row(
                  children: [
                    Icon(
                      Icons.mail_outline,
                      color: Colors.indigo,
                      size: 24.0,
                      semanticLabel: 'Name',
                    ),
                    SizedBox(width:100,height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text("E-mail"),),),
                    SizedBox(height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text(Email),),),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child:Row(
                  children: [
                    Icon(
                      Icons.place_outlined,
                      color: Colors.indigo,
                      size: 24.0,
                      semanticLabel: 'Name',
                    ),
                    SizedBox(width:100,height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text("Place"),),),
                    SizedBox(height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text(Place),),),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child:Row(
                  children: [
                    Icon(
                      Icons.phone_iphone,
                      color: Colors.indigo,
                      size: 24.0,
                      semanticLabel: 'Name',
                    ),
                    SizedBox(width:100,height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text("Phone"),),),
                    SizedBox(height: 80,
                      child: Align(
                       alignment: Alignment.center,child:
    Text(Phone),),),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child:Row(
                  children: [
                    Icon(
                      Icons.school,
                      color: Colors.indigo,
                      size: 24.0,
                      semanticLabel: 'Name',
                    ),
                    SizedBox(width:100,height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text("Qualification"),),),
                    SizedBox(height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text(Qualification),),),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child:Row(
                  children: [
                    Icon(
                      Icons.calendar_month,
                      color: Colors.indigo,
                      size: 24.0,
                      semanticLabel: 'Name',
                    ),
                    SizedBox(width:100,height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text("DOB"),),),
                    SizedBox(height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text(Dob),),),
                  ],
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child:Row(
                  children: [
                    Icon(
                      Icons.male,
                      color: Colors.indigo,
                      size: 24.0,
                      semanticLabel: 'Name',
                    ),
                    SizedBox(width:100,height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text("Gender"),),),
                    SizedBox(height: 80,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text(Gender),),),
                  ],
                ),
              ),




            ],
          ),]
      ),
    );
  }
}