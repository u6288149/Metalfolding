import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:metalfolding/login.dart';
import 'package:flutter/material.dart';

import 'home.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  //Text Editing Controllers
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  
  String get firstName => _firstNameController.text.trim();
  String get lastName => _lastNameController.text.trim();
  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();
  String get confirmPassword => _confirmController.text.trim();

  void clearText() {
    _firstNameController.clear();
    _lastNameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmController.clear();
  }

  final _auth = FirebaseAuth.instance;
  String? errorMsg;
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore(value.user)});
            // .catchError((e) {
            //   Fluttertoast.showToast(msg: e!.message);}
            // );
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMsg = "Your email address is badly formatted.";
            break;
          case "wrong-password":
            errorMsg = "Wrong password.";
            break;
          case "user-not-found":
            errorMsg = "The account does not exist.";
            break;
          case "user-disabled":
            errorMsg = "The account has been disabled.";
            break;
          case "too-many-requests":
            errorMsg = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMsg = "The operation is not allowed.";
            break;
          default:
            errorMsg = "An undefined error has occurred.";
        }
        Fluttertoast.showToast(msg: errorMsg!);
      }
    }
  }

  Future<void> postDetailsToFirestore(User? user) async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

    // Creating a map to store user details
    Map<String, dynamic> userData = {
      'email': user!.email,
      'uid': user.uid,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
    };

    // Storing user details in Firestore
    await firebaseFirestore.collection("users").doc(user.uid).set(userData);
    Fluttertoast.showToast(msg: "Account created successfully!");

    // Navigating to the homepage after successful registration
    Navigator.pushAndRemoveUntil((context),
        MaterialPageRoute(builder: (context) => const HomePage()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {

    //first name field
    final firstNameField = TextFormField(
        controller: _firstNameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ('Required field.');
          }
          if (!regex.hasMatch(value)) {
            return ('Names cannot contain special characters.');
          }
          return null;
        },
        onSaved: (value) {
          _firstNameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    //last name field
    final lastNameField = TextFormField(
        autofocus: false,
        controller: _lastNameController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ('Required field.');
          }
          if (!regex.hasMatch(value)) {
            return ('Names cannot contain special characters.');
          }
          return null;
        },
        onSaved: (value) {
          _lastNameController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.account_circle),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    //email field
    final emailField = TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ('Required field.');
          }
          //reg expression for email validation
          if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
              .hasMatch(value)) {
            return ('The submitted email format is invalid.');
          }
          return null;
        },
        onSaved: (value) {
          _emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          //hintText: 'Enter your email address',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    //password field
    final passwordField = TextFormField(
        autofocus: false,
        controller: _passwordController,
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ('Please enter your password.');
          }
          if (!regex.hasMatch(value)) {
            return ('Some characters are invalid.');
          }
          return null;
        },
        onSaved: (value) {
          _passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          //contentPadding: EdgeInsets.symmetric(vertical: 20.0),
          //hintText: 'Enter your password',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    //confirm password field
    final confirmPasswordField = TextFormField(
        controller: _confirmController,
        obscureText: true,
        validator: (value) {
          if (_confirmController.text !=
              _passwordController.text) {
            return "Passwords don't match";
          }
          return null;
        },
        onSaved: (value) {
          _confirmController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        )
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            //Imply the back button on the leading side of the appbar
            //automaticallyImplyLeading: true,
            backgroundColor: const Color(0xFF1E3F66),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context, false),
            )
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(10),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Form(
                key: _formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              const Text('Register',
                                  style: TextStyle(
                                      fontSize: 36)),
                              const SizedBox(height: 30),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('First Name',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  firstNameField,
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Last Name',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  lastNameField,
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Email',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  emailField,
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Password',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  passwordField,
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Confirm Password',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold)),
                                  const SizedBox(height: 4),
                                  confirmPasswordField,
                                ],
                              ),
                              const SizedBox(height: 20),

                              Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    const Text(
                                      "Already have an account? ",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 20),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const LoginPage()));
                                      },
                                      child: const Text(
                                        'Login now',
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
                                    )
                                  ]),
                              const SizedBox(height: 40),

                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: (Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                              color: const Color(0xFF528AAE)),
                                      child: MaterialButton(
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                          onPressed: () {
                                            signUp(_emailController.text,
                                                _passwordController.text);
                                          },
                                          child: const Text(
                                            "REGISTER",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    )),
                                  ),
                                  const SizedBox(
                                    width: 30,
                                  ),
                                  Expanded(
                                    child: (Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          color: Colors.red.shade300),
                                      child: MaterialButton(
                                          minWidth:
                                              MediaQuery.of(context).size.width,
                                          onPressed: clearText,
                                          child: const Text(
                                            "CLEAR",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )),
                                    )),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 25),
                            ]),
                      ),
                    ]),
              ),
            ),
          ),
        )
    );
  }
}