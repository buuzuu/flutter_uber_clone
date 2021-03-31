import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uber_clone/screens/login_page.dart';
import 'package:uber_clone/screens/mainpage.dart';
import 'package:uber_clone/widgets/progressDialog.dart';
import 'package:uber_clone/widgets/taxi_button.dart';


import '../brand_colors.dart';

// ignore: must_be_immutable
class RegistrationPage extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackBar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var fullNameController = TextEditingController();

  var phoneController = TextEditingController();

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void registerUser() async {

    showDialog(
        context: context,
        builder: (BuildContext context) =>
            ProgressDialog(status: 'Registering...'),
        barrierDismissible: false);

    final FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      ).catchError((err){
        Navigator.pop(context);
        PlatformException thisEx = err;
        showSnackBar(thisEx.message);
      })).user;



      if (user != null) {
        DatabaseReference reference = FirebaseDatabase.instance.reference()
            .child('users/${user.uid}');
        Map userMap = {
          'fullName' : fullNameController.text,
          'email' : emailController.text,
          'phone' : phoneController.text
        };
        reference.set(userMap);
        Navigator.pop(context);

        //Take user to main page
        Navigator.pushNamedAndRemoveUntil(context, MainPage.id, (route) => false);
      }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 120,
              ),
              Image(
                image: AssetImage('images/logo.png'),
                height: 100,
                width: 100,
              ),
              SizedBox(
                height: 50,
              ),
              Text(
                "Create a Rider Account",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontFamily: 'Brand-Bold'),
              ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    TextField(
                      keyboardType: TextInputType.name,
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: "Full Name",
                        labelStyle: TextStyle(fontSize: 14.8),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        labelStyle: TextStyle(fontSize: 14.8),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        labelStyle: TextStyle(fontSize: 14.8),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(fontSize: 14.8),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0,
                        ),
                      ),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    TaxiButton("REGISTER", BrandColors.colorGreen, () async {

                      var connectivityResult = await (Connectivity().checkConnectivity());
                      if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi ) {
                        showSnackBar("No Internet");
                        return;
                      }

                      if (fullNameController.text.length < 3) {
                        showSnackBar("Name Too Short");
                        return;
                      }
                      if(phoneController.text.length<10){
                        showSnackBar("Invalid Phone Number");
                        return;
                      }
                      if(!emailController.text.contains('@')){
                        showSnackBar("Must contain @ ");
                        return;
                      }
                      if(passwordController.text.length < 5){
                        showSnackBar("Too Short");
                        return;
                      }
                      registerUser();
                    }),
                  ],
                ),
              ),
              FlatButton(
                  onPressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, LoginPage.id, (route) => false);
                  },
                  child: Text("Already have account ? Log in"))
            ],
          ),
        ),
      ),
    );
  }
}

