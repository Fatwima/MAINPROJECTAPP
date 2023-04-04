import 'dart:collection';
import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mock_interview/testresult.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(const Test());

class Test extends StatelessWidget {
  const Test({super.key});

  static const String _title = 'test';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text(_title)),
        body: const Center(
          child: attendtest(),
        ),
      ),
    );
  }
}



class attendtest extends StatefulWidget {
  const attendtest({super.key});

  @override
  State<attendtest> createState() => _attendtestState();
}
 class _attendtestState extends State<attendtest> {
   _attendtestState() {
     Attendtest();
   }

   List<String> question_ = <String>[];
   List<String> option1_ = <String>[];
   List<String> option2_ = <String>[];
   List<String> option3_ = <String>[];
   List<String> option4_ = <String>[];
   List<String> answer_ = <String>[];


   int index = 0;

   Future<void> Attendtest() async {
     final pref = await SharedPreferences.getInstance();
     String ip = pref.getString("ip").toString();
     print(ip);


     List<String> question = <String>[];
     List<String> option1 = <String>[];
     List<String> option2 = <String>[];
     List<String> option3 = <String>[];
     List<String> option4 = <String>[];
     List<String> answer = <String>[];


     var data = await http.post(
         Uri.parse("http://" + ip + ":8000/addquestion/"), body: {});
     print(data.body);


     var jsonData = json.decode(data.body);
     String status = jsonData["status"].toString();
     var jsondata = json.decode(data.body);


     var arr = jsondata["data"];
     print(arr.length);

     for (int i = 0; i < arr.length; i++) {
       question.add(arr[i]['question'].toString());
       option1.add(arr[i]['option1'].toString());
       option2.add(arr[i]['option2'].toString());
       option3.add(arr[i]['option3'].toString());
       option4.add(arr[i]['option4'].toString());
       answer.add(arr[i]['answer'].toString());
     }

     setState(() {
       question_ = question;
       option1_ = option1;
       option2_ = option2;
       option3_ = option3;
       option4_ = option4;
       answer_ = answer;
     });
   }

   int mark = 0;

   String _character = " ";
   String q = " ";
   String r = " ";
   String p = " ";
   String s = " ";
   String f = " ";
   String BTvalue = "Save & Next";

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text('Attend aptitude test'),

       ),
       body: ListView(
           shrinkWrap: true,
           children: [
             SizedBox(width: 40, height: 60,
               child:
               Text(""),),


             SizedBox(width: 40, height: 60,
               child:
               Text((index + 1).toString(),
                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                 textAlign: TextAlign.center,),
             ),


             SizedBox(width: 200, height: 100,
               child:
               Text(question_[index],
                 style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                 maxLines: 10,),),


             RadioListTile(
               title: Text(option1_[index]),
               value: option1_[index],
               groupValue: f,
               onChanged: (value) {
                 setState(() {
                   f = value.toString();
                 });
               },
             ),
             SizedBox(width: 40, height: 40,
               child:
               Text(""),),


             RadioListTile(
               title: Text(option2_[index]),
               value: option2_[index],
               groupValue: f,
               onChanged: (value) {
                 setState(() {
                   f = value.toString();
                 });
               },
             ),
             SizedBox(width: 30, height: 30,
               child:
               Text(""),),

             RadioListTile(
               title: Text(option3_[index]),
               value: option3_[index],
               groupValue: f,
               onChanged: (value) {
                 setState(() {
                   f = value.toString();
                 });
               },
             ),
             SizedBox(width: 30, height: 30,
               child:
               Text(""),),

             RadioListTile(
               title: Text(option4_[index]),
               value: option4_[index],
               groupValue: f,
               onChanged: (value) {
                 setState(() {
                   f = value.toString();
                 });
               },
             ),
             SizedBox(width: 30, height: 30,
               child:
               Text(""),),


             const SizedBox(height: 16.0),
             ElevatedButton(
               onPressed: () {
                 if (f != " ") {
                   if (f == answer_[index]) {
                     mark += 1;
                   }

                   print(f + "----" + answer_[index]);

                   setState(() {
                     if (index == 29) {
                       saveme(mark.toString());
                       Fluttertoast.showToast(
                           msg: "Exit",
                           toastLength: Toast.LENGTH_SHORT,
                           gravity: ToastGravity.CENTER,
                           timeInSecForIosWeb: 1,
                           backgroundColor: Colors.blue,
                           textColor: Colors.white,
                           fontSize: 16.0


                       );



                     }

                     else {
                       index += 1;
                       f = " ";
                       if (index == 29) {
                         setState(() {
                           BTvalue = "Finish";
                         });
                       }
                     }
                   });
                   Fluttertoast.showToast(
                       msg: mark.toString(),
                       toastLength: Toast.LENGTH_SHORT,
                       gravity: ToastGravity.CENTER,
                       timeInSecForIosWeb: 1,
                       backgroundColor: Colors.blue,
                       textColor: Colors.white,
                       fontSize: 16.0
                   );
                 }
                 else {
                   Fluttertoast.showToast(
                       msg: "Choose an answer",
                       toastLength: Toast.LENGTH_SHORT,
                       gravity: ToastGravity.CENTER,
                       timeInSecForIosWeb: 1,
                       backgroundColor: Colors.blue,
                       textColor: Colors.white,
                       fontSize: 16.0
                   );
                 }
               }, child: Text(BTvalue),


             ),

           ]
       ),);
   }


   Future<void> saveme(String MArk) async
   { print(mark);
     final pref = await SharedPreferences.getInstance();
     String ip = pref.getString("ip").toString();
     String lid = pref.getString("lid").toString();
     print(ip);

     var data = await http.post(Uri.parse(
         "http://" + ip + ":8000/and_viewresult/"), body: {
       "lid": lid, "mark": MArk.toString()
     });
     print(mark);

     var jsonData = json.decode(data.body);
     String status = jsonData["status"].toString();
     if (status == "ok") {
       final prefs = await SharedPreferences.getInstance();


       await prefs.setString('mark', jsonData["mark"].toString());
       await prefs.setString('description', jsonData["desc"].toString());
       Navigator.push(
         context,
         MaterialPageRoute(builder: (context) => new  testresultPage(title: 'Result',)),
       );

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
     };
   }
 }



