import 'package:cab_management/Auth/Signin.dart';
import 'package:cab_management/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cab_management/Auth/helper.dart';

import 'constants.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
      apiKey: constansts.apiKey,
      appId: constansts.appId,
      messagingSenderId: constansts.messagingSenderId,
      projectId: constansts.projectId,
      storageBucket: "cab-management-7b661.appspot.com",
    ));
  } else {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  }

  runApp(const MyApp());
}
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   // initializing the firebase app
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(MyApp());
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;
  @override
  void initState() {
    super.initState();
    getUserLoggedInStatus();
  }

  void getUserLoggedInStatus() async {
    await helperFunctions.getUserLoggedInStatus().then((value) {
      if (value != null) {
        setState(() {
          _isSignedIn = value;
        });
      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData().copyWith(
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
          useMaterial3: true,
        ),
        home: 
            _isSignedIn ? Home() : const Signin() 
            // ResponsiveLayout(
            //  webScreenLayout: const webScreenLayout()
            
            );
  }
}
