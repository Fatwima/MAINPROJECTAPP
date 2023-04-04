import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(const Interviewatt());
}

class Interviewatt extends StatelessWidget {
  const Interviewatt({super.key});

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
      home: const InterviewattPage(title: 'TEST RESULT'),
    );
  }
}

class InterviewattPage extends StatefulWidget {
  const InterviewattPage({super.key, required this.title});


  final String title;

  @override
  State<InterviewattPage> createState() => _InterviewattPageState();
}

class _InterviewattPageState extends State<InterviewattPage> {


  _InterviewattPageState() {
    and_userresult();
  }

  String Date=" ";
  String Suggestion=" ";



  Future<void> and_userresult() async {

    String Date=" ";
    String Suggestion=" ";




    setState(() async {
      final pref = await SharedPreferences.getInstance();

      Date=pref.getString("mark").toString();
      Suggestion=pref.getString("description").toString();


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
        body: ListView.builder(
          physics: BouncingScrollPhysics(),
          // padding: EdgeInsets.all(5.0),
          // shrinkWrap: true,
          // itemCount: id_.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              onLongPress: () {
                print("long press" + index.toString());
              },
              title: Card(
                elevation: 8,
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [


                    SizedBox(height: 50,
                      child: Align(
                        alignment: Alignment.center,child:
                      Text(Date),),),


                    SizedBox(height: 50,
                      // child:Text("Job Name  : "+date_[index].toString())),
                      child: Align(
                        alignment: Alignment.center,child:
                      Text(Suggestion),),),




                    SizedBox(width:100,child:
                    ElevatedButton(
                      // onPressed: _submitForm,

                      onPressed: () async {


                        final pref=await SharedPreferences.getInstance();
                        pref.setString("exit", [index].toString());
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new  Interviewatt()),
                        );

                      },


                      child: const Text('Attend '),

                    ),),

                  ],),
              ),
            );
          },
        )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
