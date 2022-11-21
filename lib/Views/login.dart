import 'dart:developer';

import 'package:cafebanter/Utils/cafeBanterConstantColors.dart';
import 'package:cafebanter/Views/bottomNavigation.dart';
import 'package:cafebanter/Views/signUp.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Customer/cafeBanterHomePageView.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? role = "";
  final List<String> roles = ['Customer', 'Cafe Admin'];
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login to \nContinue as $role',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: DropdownButtonFormField2(
                    decoration: InputDecoration(
                      //Add isDense true and zero Padding.
                      //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      //Add more decoration as you want here
                      //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                    ),
                    isExpanded: true,
                    hint: const Text(
                      'Select Your Role',
                      style: TextStyle(fontSize: 14),
                    ),
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.black45,
                    ),
                    iconSize: 30,
                    buttonHeight: 60,
                    buttonPadding: const EdgeInsets.only(left: 20, right: 10),
                    dropdownDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    items: roles
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        role = value as String;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        role = value as String;
                      });
                    },
                  )),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Email',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your email',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Password',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter your password',
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (emailController.text.isNotEmpty &&
                        passwordController.text.isNotEmpty) {
                      FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((value) {
                        if (value.user?.uid != null) {
                          if (role == "Customer") {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavCustomer()));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BottomNavAdmin()));
                          }
                        } else {
                          Fluttertoast.showToast(
                              msg: "Please provide rigth email and passsword");
                        }
                      });
                    } else {
                      Fluttertoast.showToast(msg: "Please fill all fields");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: CafeBanterColors.appMainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text("Login"),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.black),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(color: CafeBanterColors.appMainColor),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// import 'dart:developer';

// import 'package:cafebanter/Services/firebaseCafeBanterSeries.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/scheduler.dart' show timeDilation;
// import 'package:flutter_login/flutter_login.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// class LoginView extends StatefulWidget {
//   const LoginView({super.key});

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

//   final CafebanterFirebaseService _cafebanterFirebaseService =
//       CafebanterFirebaseService();

//   FirebaseAuth _auth = FirebaseAuth.instance;
//   Future<String?> _loginUser(LoginData data) {
//     return Future.delayed(loginTime).then((_) {
//       if (!mockUsers.containsKey(data.name)) {
//         return 'User not exists';
//       }
//       if (mockUsers[data.name] != data.password) {
//         return 'Password does not match';
//       }
//       return null;
//     });
//   }

//   Future<String?> _signupUser(SignupData data) {
//     return Future.delayed(loginTime).then((_) {
//       return null;
//     });
//   }

//   Future<String?> _recoverPassword(String name) {
//     return Future.delayed(loginTime).then((_) {
//       if (!mockUsers.containsKey(name)) {
//         return 'User not exists';
//       }
//       return null;
//     });
//   }

//   Future<String?> _signupConfirm(String error, LoginData data) {
//     return Future.delayed(loginTime).then((_) {
//       return null;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FlutterLogin(
//       logo: const AssetImage('assets/cafeBanter-removebg.png'),
//       logoTag: Constants.logoTag,
//       titleTag: Constants.titleTag,
//       navigateBackAfterRecovery: true,
//       onConfirmRecover: _signupConfirm,
//       onConfirmSignup: _signupConfirm,
//       loginAfterSignUp: false,

//       termsOfService: [
//         TermOfService(
//           id: 'newsletter',
//           mandatory: false,
//           text: 'Newsletter subscription',
//         ),
//         TermOfService(
//           id: 'general-term',
//           mandatory: true,
//           text: 'Term of services',
//           linkUrl: 'https://github.com/NearHuscarl/flutter_login',
//         ),
//       ],
//       additionalSignupFields: [
//         const UserFormField(
//           keyName: 'Username',
//           icon: Icon(FontAwesomeIcons.userLarge),
//         ),
//         const UserFormField(keyName: 'Name'),
//         const UserFormField(keyName: 'Surname'),
//         UserFormField(
//           keyName: 'phone_number',
//           displayName: 'Phone Number',
//           userType: LoginUserType.phone,
//           fieldValidator: (value) {
//             final phoneRegExp = RegExp(
//               '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$',
//             );
//             if (value != null &&
//                 value.length < 7 &&
//                 !phoneRegExp.hasMatch(value)) {
//               return "This isn't a valid phone number";
//             }
//             return null;
//           },
//         ),
//       ],
//       // scrollable: true,
//       // hideProvidersTitle: false,
//       // loginAfterSignUp: false,
//       // hideForgotPasswordButton: true,
//       // hideSignUpButton: true,
//       // disableCustomPageTransformer: true,
//       // messages: LoginMessages(
//       //   userHint: 'User',
//       //   passwordHint: 'Pass',
//       //   confirmPasswordHint: 'Confirm',
//       //   loginButton: 'LOG IN',
//       //   signupButton: 'REGISTER',
//       //   forgotPasswordButton: 'Forgot huh?',
//       //   recoverPasswordButton: 'HELP ME',
//       //   goBackButton: 'GO BACK',
//       //   confirmPasswordError: 'Not match!',
//       //   recoverPasswordIntro: 'Don\'t feel bad. Happens all the time.',
//       //   recoverPasswordDescription: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry',
//       //   recoverPasswordSuccess: 'Password rescued successfully',
//       //   flushbarTitleError: 'Oh no!',
//       //   flushbarTitleSuccess: 'Succes!',
//       //   providersTitle: 'login with'
//       // ),
//       // theme: LoginTheme(
//       //   primaryColor: Colors.teal,
//       //   accentColor: Colors.yellow,
//       //   errorColor: Colors.deepOrange,
//       //   pageColorLight: Colors.indigo.shade300,
//       //   pageColorDark: Colors.indigo.shade500,
//       //   logoWidth: 0.80,
//       //   titleStyle: TextStyle(
//       //     color: Colors.greenAccent,
//       //     fontFamily: 'Quicksand',
//       //     letterSpacing: 4,
//       //   ),
//       //   // beforeHeroFontSize: 50,
//       //   // afterHeroFontSize: 20,
//       //   bodyStyle: TextStyle(
//       //     fontStyle: FontStyle.italic,
//       //     decoration: TextDecoration.underline,
//       //   ),
//       //   textFieldStyle: TextStyle(
//       //     color: Colors.orange,
//       //     shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
//       //   ),
//       //   buttonStyle: TextStyle(
//       //     fontWeight: FontWeight.w800,
//       //     color: Colors.yellow,
//       //   ),
//       //   cardTheme: CardTheme(
//       //     color: Colors.yellow.shade100,
//       //     elevation: 5,
//       //     margin: EdgeInsets.only(top: 15),
//       //     shape: ContinuousRectangleBorder(
//       //         borderRadius: BorderRadius.circular(100.0)),
//       //   ),
//       //   inputTheme: InputDecorationTheme(
//       //     filled: true,
//       //     fillColor: Colors.purple.withOpacity(.1),
//       //     contentPadding: EdgeInsets.zero,
//       //     errorStyle: TextStyle(
//       //       backgroundColor: Colors.orange,
//       //       color: Colors.white,
//       //     ),
//       //     labelStyle: TextStyle(fontSize: 12),
//       //     enabledBorder: UnderlineInputBorder(
//       //       borderSide: BorderSide(color: Colors.blue.shade700, width: 4),
//       //       borderRadius: inputBorder,
//       //     ),
//       //     focusedBorder: UnderlineInputBorder(
//       //       borderSide: BorderSide(color: Colors.blue.shade400, width: 5),
//       //       borderRadius: inputBorder,
//       //     ),
//       //     errorBorder: UnderlineInputBorder(
//       //       borderSide: BorderSide(color: Colors.red.shade700, width: 7),
//       //       borderRadius: inputBorder,
//       //     ),
//       //     focusedErrorBorder: UnderlineInputBorder(
//       //       borderSide: BorderSide(color: Colors.red.shade400, width: 8),
//       //       borderRadius: inputBorder,
//       //     ),
//       //     disabledBorder: UnderlineInputBorder(
//       //       borderSide: BorderSide(color: Colors.grey, width: 5),
//       //       borderRadius: inputBorder,
//       //     ),
//       //   ),
//       //   buttonTheme: LoginButtonTheme(
//       //     splashColor: Colors.purple,
//       //     backgroundColor: Colors.pinkAccent,
//       //     highlightColor: Colors.lightGreen,
//       //     elevation: 9.0,
//       //     highlightElevation: 6.0,
//       //     shape: BeveledRectangleBorder(
//       //       borderRadius: BorderRadius.circular(10),
//       //     ),
//       //     // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
//       //     // shape: CircleBorder(side: BorderSide(color: Colors.green)),
//       //     // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
//       //   ),
//       // ),
//       userValidator: (value) {
//         if (!value!.contains('@') || !value.endsWith('.com')) {
//           return "Email must contain '@' and end with '.com'";
//         }
//         return null;
//       },
//       passwordValidator: (value) {
//         if (value!.isEmpty) {
//           return 'Password is empty';
//         }
//         return null;
//       },
//       onLogin: (loginData) async {
//         debugPrint('Login info');
//         debugPrint('Name: ${loginData.name}');
//         debugPrint('Password: ${loginData.password}');
//         UserCredential credential;
//         await _auth.useEmulator("http://localhost:9099");
//         credential = await _auth.signInWithEmailAndPassword(
//             email: loginData.name, password: loginData.password);

//         return credential.user!.uid;
//       },
//       onSignup: (signupData) async {
//         debugPrint('Signup info');
//         debugPrint('Name: ${signupData.name}');
//         debugPrint('Password: ${signupData.password}');

//         signupData.additionalSignupData?.forEach((key, value) {
//           debugPrint('$key: $value');
//         });
//         if (signupData.termsOfService.isNotEmpty) {
//           debugPrint('Terms of service: ');
//           for (final element in signupData.termsOfService) {
//             debugPrint(
//               ' - ${element.term.id}: ${element.accepted == true ? 'accepted' : 'rejected'}',
//             );
//           }
//         }
//         var response = await _cafebanterFirebaseService.firebaseSignUp(
//             signupData.name!, signupData.password!);

//         debugPrint(response!.user!.uid);
//       },
//       onSubmitAnimationCompleted: () {
//         debugPrint("Hello");
//       },
//       onRecoverPassword: (name) {
//         debugPrint('Recover password info');
//         debugPrint('Name: $name');
//         return _recoverPassword(name);
//         // Show new password dialog
//       },
//       //headerWidget: const IntroWidget(),
//     );
//   }
// }

// const mockUsers = {
//   'dribbble@gmail.com': '12345',
//   'hunter@gmail.com': 'hunter',
//   'near.huscarl@gmail.com': 'subscribe to pewdiepie',
//   '@.com': '.',
// };

// class Constants {
//   static const String appName = 'CafeBanter';
//   static const String logoTag = 'near.huscarl.loginsample.logo';
//   static const String titleTag = 'near.huscarl.loginsample.title';
// }
