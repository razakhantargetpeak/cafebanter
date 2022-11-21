import 'dart:async';

import 'package:cafebanter/Views/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Views/bottomNavigation.dart';

Future<void> main(List<String> args) async {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor:
          SystemUiOverlayStyle.light.systemNavigationBarColor,
    ),
  );
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

// Ideal time to initialize
  //await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(const CafeBanterMainApp());
}

class CafeBanterMainApp extends StatefulWidget {
  const CafeBanterMainApp({Key? key}) : super(key: key);

  @override
  State<CafeBanterMainApp> createState() => _CafeBanterMainAppState();
}

class _CafeBanterMainAppState extends State<CafeBanterMainApp> {
  bool isLoggedIn = false;
  bool isCustomer = false;
  @override
  void initState() {
    FirebaseAuth.instance.authStateChanges().listen((event) {
      if (event != null) {
        setState(() {
          isLoggedIn = true;
        });
      } else {
        setState(() {
          isLoggedIn = false;
        });
      }
    });

    super.initState();
    getRole();
    // new Future.delayed(const Duration(seconds: 2));
  }

  getRole() async {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .get()
        .then((value) {
      Map<String, dynamic> fdata = value.data() as Map<String, dynamic>;

      if (fdata["role"] == "Customer") {
        setState(() {
          isCustomer = true;
        });
      } else {
        setState(() {
          isCustomer = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.light(),
      theme: ThemeData(
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.orange),

        // fontFamily: 'SourceSansPro',
        textTheme: TextTheme(
          headline3: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            // fontWeight: FontWeight.w400,
            color: Colors.orange,
          ),
          button: const TextStyle(
            // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
            fontFamily: 'OpenSans',
          ),
          caption: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.deepPurple[300],
          ),
          headline1: const TextStyle(fontFamily: 'Quicksand'),
          headline2: const TextStyle(fontFamily: 'Quicksand'),
          headline4: const TextStyle(fontFamily: 'Quicksand'),
          headline5: const TextStyle(fontFamily: 'NotoSans'),
          headline6: const TextStyle(fontFamily: 'NotoSans'),
          subtitle1: const TextStyle(fontFamily: 'NotoSans'),
          bodyText1: const TextStyle(fontFamily: 'NotoSans'),
          bodyText2: const TextStyle(fontFamily: 'NotoSans'),
          subtitle2: const TextStyle(fontFamily: 'NotoSans'),
          overline: const TextStyle(fontFamily: 'NotoSans'),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: Colors.orange),
      ),
      debugShowCheckedModeBanner: false,
      home: isLoggedIn == true
          ? DecisionTime(
              isCustomer: isCustomer,
            )
          : const DecisionTimeLogin(),
    );
  }
}

class DecisionTimeLogin extends StatefulWidget {
  const DecisionTimeLogin({super.key});

  @override
  State<DecisionTimeLogin> createState() => _DecisionTimeLoginState();
}

class _DecisionTimeLoginState extends State<DecisionTimeLogin> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LoginView())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/cafeBanter-removebg.png"))),
      ),
    );
  }
}

class DecisionTime extends StatefulWidget {
  final bool isCustomer;
  const DecisionTime({super.key, required this.isCustomer});

  @override
  State<DecisionTime> createState() => _DecisionTimeState();
}

class _DecisionTimeState extends State<DecisionTime> {
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (widget.isCustomer) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const BottomNavCustomer()));
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const BottomNavAdmin()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/cafeBanter-removebg.png"))),
      ),
    );
  }
}
