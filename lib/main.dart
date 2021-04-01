import 'dart:async';
import 'dart:io' show Platform;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:uber_clone/dataProvider/appData.dart';
import 'package:uber_clone/screens/login_page.dart';
import 'package:uber_clone/screens/mainpage.dart';
import 'package:uber_clone/screens/registration.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final FirebaseApp app = await FirebaseApp.configure(
    name: 'db2',
    options: Platform.isIOS || Platform.isMacOS
        ? FirebaseOptions(
      googleAppID: '1:330969427525:ios:c7423fd1594e2665a0bd2c',
      apiKey: 'AIzaSyAG9RzRJty7Pr0LgDmuq5CkJwZ8JkVaBD8',
      gcmSenderID: '330969427525',
      databaseURL: "https://uberclone-56581-default-rtdb.firebaseio.com",
    )
        : FirebaseOptions(
      googleAppID: '1:330969427525:android:ed55602945abc469a0bd2c',
      apiKey: 'AIzaSyA18MNzjk_fM6KMyRnx4JAeloi1skVdkts',
      databaseURL: "https://uberclone-56581-default-rtdb.firebaseio.com",


    ),
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'Brand-Regular',
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),

        initialRoute: RegistrationPage.id ,
        routes: {
          RegistrationPage.id: (context) => RegistrationPage(),
          LoginPage.id: (context) => LoginPage(),
          MainPage.id: (context) => MainPage(),

        },
      ),
    );
  }


}
