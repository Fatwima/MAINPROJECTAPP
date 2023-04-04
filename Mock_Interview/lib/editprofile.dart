import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mock_interview/login.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mock_interview/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
void main() {
  runApp(const EditPage());
}

class EditPage extends StatelessWidget {
  const EditPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EditPagePAGE(),
    );
  }
}

class EditPagePAGE extends StatefulWidget {
  const EditPagePAGE({Key? key}) : super(key: key);

  @override
  State<EditPagePAGE> createState() => _EditpageState();
}

class _EditpageState extends State<EditPagePAGE> {

  _EditpageState()
  {

      Profileview();

  }
  File? uploadimage;

  String get id => '';
  String get img=> '';//variable for choose file

  Future<void> chooseImage() async {
    final choosedimage = await ImagePicker().pickImage(source: ImageSource.gallery);
    //set source: ImageSource.camera to get image from camera
    setState(() {
      uploadimage = File(choosedimage!.path);
    });
  }

  String Name=" ";
  String Place=" ";
  String Gender=" ";
  String Dob=" ";
  String Qualification=" ";
  String Phone=" ";
  String Email=" ";
  String Photo=" ";

  String dropdownvalue2 = 'Male';

// List of items in our dropdown menu
  var items2 = [

    'Male',
    'Female',
    'Prefer not to say',

  ];


  String dob="";


  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _qualificationController =TextEditingController();
  final _placeController =TextEditingController();
  final _dobController =TextEditingController();
  final _genderController =TextEditingController();
  DateTime? _selectedDate;


    Future<void> Profileview() async {
      final pref = await SharedPreferences.getInstance();
      String ip = pref.getString("ip").toString();
      print(ip);

      // var data = await http.post(
      //     Uri.parse("http://" + ip + ":8000/and_profileupdate/"),
      //     body: {"lid": pref.getString("lid").toString()});


      var data = await http.post(Uri.parse("http://" + ip + ":8000/profile_post/"),body: {"lid":pref.getString("lid").toString()});

      print(data.body);
      var jsonData = json.decode(data.body);
      String status = jsonData["status"].toString();
      if (status == "ok") {
        setState(() {
          _nameController.text = jsonData["name"].toString();
          Email= jsonData["emailid"].toString();
          _emailController.text=jsonData["emailid"].toString();
          _qualificationController.text = jsonData["qualification"].toString();
          _placeController.text = jsonData["place"].toString();
          _phoneController.text = jsonData["phone"].toString();
          _dobController.text =jsonData["dob"].toString();
          Gender = jsonData["gender"].toString();
          // Dob = jsonData["dob"].toString();
          Photo="http://" + ip + ":8000"+jsonData["photo"].toString();
        });
      }
      else {
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


  String base64Image="no";


  Future<void> _submitForm() async {
      final name = _nameController.text;
      final phone = _phoneController.text;
      final email = _emailController.text;
      final qualification = _qualificationController.text;
      final place = _placeController.text;
      final gender = dropdownvalue2;
      final dob =_dobController.text;

      final bool emailValid =
      RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(email);
//validation
      if (name.isEmpty) {
        Fluttertoast.showToast(
            msg: "Name Missing",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

      else if (gender.isEmpty ){
        Fluttertoast.showToast(
            msg: "Choose gender",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

      else if (_dobController.text==""){
        Fluttertoast.showToast(
            msg: "Dob required",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

      else if (phone.isEmpty) {
        Fluttertoast.showToast(
            msg: "Phone number required",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else if (phone.length != 10) {
        Fluttertoast.showToast(
            msg: "Invaid Phonenumber",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else if (place.isEmpty) {
        Fluttertoast.showToast(
            msg: "Place required",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
      else if (qualification.isEmpty) {
        Fluttertoast.showToast(
            msg: "Qualification required",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }


      else {
        try {


          try{
            List<int> imageBytes = uploadimage!.readAsBytesSync();
            String baseimage = base64Encode(imageBytes);


            final bytes = File(uploadimage!.path).readAsBytesSync();
            base64Image = base64Encode(bytes);
          }
          catch(e)
    {
      base64Image="no";
    }
          print("img_pan : $base64Image");

          final pref = await SharedPreferences.getInstance();
          String ip = pref.getString("ip").toString();
               print(name+"-"+phone+"-"+qualification+"-"+place+"-"+dob+"-"+email+"-"+gender);
          var data = await http.post(
              Uri.parse("http://" + ip + ":8000/editprofile_post/"), body: {
            "image": base64Image,
            "name": name,
          "lid":pref.getString("lid").toString(),
            "phone": phone,
            "qualification": qualification,
            "place": place,
            "gender": gender,
            "dob": dob,
            "emailid":email,



          });
          var jsondata = json.decode(data.body);
          print(jsondata);

          if (jsondata["status"].toString() == "ok") {
            Fluttertoast.showToast(
                msg: "Success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
            );
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => new profileapp()),
            );
          }
          else if (jsondata["status"].toString() == "none") {
            Fluttertoast.showToast(
                msg: "Email id exists",
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
                msg: "Failed",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        } catch (e) {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.blue,
              textColor: Colors.white,
              fontSize: 16.0
          );
          print("Error ------------------- " + e.toString());
          //there is error during converting file image to base64 encoding.
        }


        // Use the username, password, and date of birth to create a new user account
        //   final dob = _selectedDate.toString();

      }
    }


    @override
    void dispose() {
      _nameController.dispose();
      _placeController.dispose();
      _phoneController.dispose();
      _emailController.dispose();
      _qualificationController.dispose();
      _genderController.dispose();
      _dobController.dispose();

      super.dispose();
    }


  Future<void> _selectDate(BuildContext context) async {

    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime(2012,1,1,9,0,0),
      firstDate: DateTime(1980,1,1,9,0,0),
      lastDate: DateTime(2012,1,1,9,0,0),
      helpText: 'SELECT DATE OF BIRTH',
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.dark(),
          child: child!,
        );
      },
    );
    //
    if (selected != null )

    {
      setState(() {
        _selectedDate = selected;
        dob=selected.year.toString()+"-"+selected.month.toString()+"-"+selected.day.toString();
        _dobController.text=dob;
        print(dob);

      });
    }

  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update your profile'),
      ),
      body: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [Column(
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: InkWell(
                  onTap: () {
                    chooseImage();
                  },
                  child:

                  Container( //show image here after choosing image

                    child: uploadimage == null ?
                    Container(child: SizedBox(
                        height: 150,
                        child: Image.network(Photo),
                           //load image from file
                    )) : //if upload image is null then show empty container
                    Container( //else show image here
                        child: SizedBox(
                            height: 150,
                            child: Image.file(uploadimage!, height: 200,
                              width: 200,) //load image from file
                        )
                    ),
                  ),
                ),
              ),

              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person_outline)),
                ),
              ),


              Card(shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),

                child:     DropdownButtonFormField(

                  // Initial Value
                  value: dropdownvalue2,

                  // Down Arrow Icon
                  icon: const Icon(Icons.keyboard_arrow_down),




                  // Array list of items
                  items: items2.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  // After selecting the desired option,it will
                  // change button value to selected value
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue2 = newValue!;
                    });
                  },
                ),
              ),


              const SizedBox(height: 16.0),
              Card(shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'Phone Number',
                      prefixIcon: Icon(Icons.phone_android_outlined)),
                ),
              ),
              const SizedBox(height: 16.0),
              Card(shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'E-mail ',

                      prefixIcon: Icon(Icons.mail_outline)),
                ),
              ),
              // Card(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15)),
              //   child:Row(
              //     children: [
              //       SizedBox(width:100,height: 60,
              //         child: Align(
              //           alignment: Alignment.center,child:
              //         Text("Email"),),),
              //       SizedBox(height: 60,
              //         child: Align(
              //           alignment: Alignment.center,child:
              //         Text(Email),),),
              //     ],
              //   ),
              // ),
              Card(shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
                child: TextFormField(
                  controller: _placeController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      labelText: 'Place',
                      prefixIcon: Icon(Icons.place_outlined)
                  ),
                ),
              ),


              Card(shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
              ),
                child: TextFormField(
                  controller: _qualificationController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)
                      ),
                      labelText: 'Qualification',
                      prefixIcon: Icon(Icons.cast_for_education_rounded)
                  ),
                ),
              ),


              // Card(
              //   shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(15)),
              //   child: Row(
              //     children: [
              //       SizedBox(width: 100, height: 60,
              //         child: Align(
              //           alignment: Alignment.center, child:
              //         Text("DOB"),),),
              //       SizedBox(height: 60,
              //         child: Align(
              //           alignment: Alignment.center, child:
              //         Text(Dob),),),
              //     ],
              //   ),
              // ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: TextFormField(
                  controller: _dobController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      labelText: 'DOB',
                      prefixIcon: Icon(Icons.person_outline)),
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Update'),
              ),

            ],
          ),
          ]
      ),
    );
  }
}