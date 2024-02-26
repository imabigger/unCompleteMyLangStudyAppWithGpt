import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';
import 'package:study_language_ai_flutter_project/common/component/alert_function.dart';
import 'package:study_language_ai_flutter_project/user/auth/auth.dart';

// nick name
//email
// password - change only
// email- verify button and submit check

class AccountDetailScreen extends StatefulWidget {
  const AccountDetailScreen({super.key});

  @override
  State<AccountDetailScreen> createState() => _AccountDetailScreenState();
}

class _AccountDetailScreenState extends State<AccountDetailScreen> {
  final User user = Auth().currentUser!;

  final _formKey = GlobalKey<FormState>();

  final _nickNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _nickNameController.text = user.displayName!;
    _emailController.text = user.email!;
  }

  @override
  void dispose() {
    _nickNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color: Colors.red, //change your color here
        ),
        title: Text(
          '계정 정보 관리',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: KeyboardDismissOnTap(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  // Nick Name Field
                  TextFormField(
                    controller: _nickNameController,
                    decoration: InputDecoration(
                      labelText: 'Nick Name',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your nick name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!value.contains('@')) {
                        return 'Invalid email format';
                      }
                      // Add more complex email validation here if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),

                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: 'Password 변경',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      // Add more complex password validation here if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password 변경 확인',
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (_passwordController.text != value) {
                        return 'Password가 일치하지 않습니다.';
                      }
                      // Add more complex password validation here if needed
                      return null;
                    },
                  ),
                  SizedBox(height: 20.0),



                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (_nickNameController.value.text !=
                            user.displayName) {
                          user.updateDisplayName(
                              _nickNameController.value.text);
                        }
                        if (_emailController.value.text != user.email) {
                          user.updateEmail(_emailController.value.text);
                        }
                        if (_passwordController.value.text.trim().isNotEmpty) {
                          user.updatePassword(_passwordController.value.text);
                        }

                        context.pop();
                      }
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.blueAccent),
                      padding: MaterialStateProperty.all(
                          EdgeInsets.symmetric(horizontal: 50, vertical: 10)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 20)),
                    ),
                  ),

                  TextButton(
                      onPressed: () {
                        alert_function(
                          onConfirmPressed: (){
                            user.delete();
                            context.pop();
                          },
                          alertMessage: '정말로 계정을 삭제하시겠습니까?\n현재 기기에 저장된 데이터는 보존됩니다.',
                          validator: (){return true;},
                          validatorFalseMessage: '',
                          context: context,
                        );
                      },
                      child: Text(
                        'Account Delete',
                        style: TextStyle(color: Colors.red),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
