import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:hive/hive.dart';
import 'package:study_language_ai_flutter_project/common/component/drop_button.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';
import 'package:study_language_ai_flutter_project/common/utill/utils.dart';
import 'package:study_language_ai_flutter_project/user/auth/auth.dart';
import 'package:collection/collection.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Lang? myBaseLang;
  final box = Hive.box<String>('lowSecurityRequired');

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBaseLang = Util.changeStringToLang(box.get(base_lang_key) ?? Lang.English.name);
    _emailController.text = box.get(login_saved_email_key, defaultValue: '')!;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? emailError;
    String? passwordError;

    return KeyboardDismissOnTap(
      child: KeyboardVisibilityBuilder(
        builder: (context, isKeyboardVisible) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                'asset/background/markus-spiske-k0rVudBoB4c-unsplash.jpg',
                fit: BoxFit.cover,
              ),
              Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextFormField(
                                  controller: _emailController,
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      emailError = 'Email cannot be empty';
                                      return emailError;
                                    }
                                    if (!value.contains('@')) {
                                      emailError = 'Invalid email format';
                                      return emailError;
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 16.0),
                                TextFormField(
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  validator: (String? value) {
                                    if (value == null || value.trim().isEmpty) {
                                      passwordError =
                                          'Password cannot be empty';
                                      return passwordError;
                                    }
                                    return null;
                                  },
                                  obscureText: true,
                                ),
                                SizedBox(height: 16.0),
                                Container(
                                  // 로그인
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      try {
                                        if (_formKey.currentState!.validate()) {
                                          Auth().signInWithEmailAndPassword(
                                            email: _emailController.value.text,
                                            password:
                                                _passwordController.value.text,
                                          );

                                          box.put(
                                              login_saved_email_key,
                                              _emailController.value.text);
                                        } else {
                                          if (emailError != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    content:
                                                        Text(emailError!)));
                                          } else if (passwordError != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    content:
                                                        Text(passwordError!)));
                                          }
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'user-not-found') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  content: Text(
                                                      'No user found for that email.')));
                                        } else if (e.code == 'wrong-password') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  content: Text(
                                                      'Wrong password provided for that user.')));
                                        }
                                      }
                                    },
                                    child: Text('Sign In'),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.blue),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      padding: MaterialStateProperty.all<
                                              EdgeInsets>(
                                          EdgeInsets.symmetric(vertical: 10)),
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                              TextStyle(fontSize: 16)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  // 회원가입
                                  width: 150,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      try {
                                        if (_formKey.currentState!.validate()) {
                                          Auth().createUserWithEmailAndPassword(
                                            email: _emailController.value.text,
                                            password:
                                                _passwordController.value.text,
                                          );

                                          box.put(
                                              login_saved_email_key,
                                              _emailController.value.text);
                                        } else {
                                          if (emailError != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    content:
                                                        Text(emailError!)));
                                          } else if (passwordError != null) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    duration: const Duration(
                                                        seconds: 2),
                                                    content:
                                                        Text(passwordError!)));
                                          }
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  content: Text(
                                                      'The password provided is too weak.')));
                                        } else if (e.code ==
                                            'email-already-in-use') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  duration: const Duration(
                                                      seconds: 2),
                                                  content: Text(
                                                      'The account already exists for that email.')));
                                        }
                                      }
                                    },
                                    child: Text('Sign Up'),
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.green),
                                      foregroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Colors.white),
                                      padding: MaterialStateProperty.all<
                                              EdgeInsets>(
                                          EdgeInsets.symmetric(vertical: 10)),
                                      textStyle:
                                          MaterialStateProperty.all<TextStyle>(
                                              TextStyle(fontSize: 16)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Text('or'),
                      Container(
                        padding: EdgeInsets.all(16.0),
                        child: ElevatedButton(
                          onPressed: () {
                            try {
                              Auth().signInWithGoogle();
                            } catch (e) {
                              print(e);
                            }
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.g_mobiledata_rounded),
                              SizedBox(width: 10),
                              Text('Sign In with Google'),
                            ],
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.black),
                            overlayColor: MaterialStateProperty.all<Color>(
                                Colors.black.withOpacity(0.05)),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(vertical: 10)),
                            textStyle: MaterialStateProperty.all<TextStyle>(
                                TextStyle(fontSize: 16)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (!isKeyboardVisible)
                Positioned(
                  bottom: 0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButtonHideUnderline(
                      child: DropDownButtonSearchCustom<Lang>(
                        value: myBaseLang,
                        hintText: 'Base Language 선택',
                        onChanged: (Lang? lang) {
                          box.put(base_lang_key, lang!.name);
                          setState(() {
                            myBaseLang = lang;
                          });
                        },
                        items: Lang.values,
                        valueToString: (Lang val) {
                          return val.name;
                        },
                        textEditingController: _textEditingController,
                        buttonSize: 300,
                        dropSize: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                )
            ],
          );
        },
      ),
    );
  }
}
