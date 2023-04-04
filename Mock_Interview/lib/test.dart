
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'package:mock_interview/changepassword.dart';
import 'package:mock_interview/editprofile.dart';
import 'package:mock_interview/login.dart';
import 'package:mock_interview/profile.dart';
import 'package:mock_interview/testdemo.dart';


import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyAppHome());

class MyAppHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Page',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String nme="Attend interview";
  String photo=" ";
  String Email=" ";
  _HomePageState(){
    ppp();
  }
  Future<void> ppp()
  async {

    final pref = await SharedPreferences.getInstance();
    setState(() {
      nme = pref.getString("name").toString();
      Email=pref.getString("email").toString();
      String ip=pref.getString("ip").toString();
      photo="http://" + ip + ":8000"+pref.getString("photo").toString();
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ace TheInterview"),
        backgroundColor: Colors.blueAccent,
      ),
      body:  Center(
        child: ListView(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child:Row(
                children: [
                  SizedBox(width:100,height: 60,
                    child: Align(
                      alignment: Alignment.center,child:
                    Text("Email"),),),
                  SizedBox(height: 100,width: 60,
                    child: Align(
                      alignment: Alignment.center,child:
                    Text(Email),),),
                ],
              ),
            ),


          ],
        ),


      ),





      drawer: Drawer(
        child: ListView(
          padding:  EdgeInsets.all(0),
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  accountName: Text(
                    nme,
                    style: TextStyle(fontSize: 18),
                  ),
                  accountEmail: Text(Email),
                  currentAccountPictureSize: Size.square(50),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 39, 170, 150),

                    child: Image.network(photo,fit: BoxFit.fill,width: 200,height: 200,),)
                //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new ProfileUpPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' Attend Aptitude test '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new  attendtest()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.filter_center_focus_rounded),
              title: const Text(' Attend interview '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text(' Intereview result '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_label),
              title: const Text(' Aptitude test result '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Edit Profile '),
              onTap: () {



                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new  EditPagePAGE()),
                );

              },
            ),
            ListTile(
              leading: const Icon(Icons.password),
              title: const Text(' Change password '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => new changepass()),
                );
              },
            ),
            ElevatedButton(
              // leading: const Icon(Icons.logout),
              child: const Text('LogOut'),
    onPressed: () async {
    final _sharedprif = await SharedPreferences.getInstance();
    await _sharedprif.clear();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
    builder: ((ctx1) {
    return LoginPage();
    }),
    ), (route) => false);

              },
            ),
          ],
        ),
      ), //Drawer
    );
  }
}





////////////////
// onPressed: () async {
// final _sharedprif = await SharedPreferences.getInstance();
// await _sharedprif.clear();
// Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
// builder: ((ctx1) {
// return LoginPage();
// }),
// ), (route) => false);
// }
