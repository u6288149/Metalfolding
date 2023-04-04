import 'package:metalfolding/home.dart';
import 'package:metalfolding/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();

  //Text Editing Controllers
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void clearText() {
    _emailController.clear();
    _passwordController.clear();
  }

  final _auth = FirebaseAuth.instance;
  String? errorMsg;
  //login method
  void signIn(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Login Successful"),
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const HomePage())),
                });
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

  @override
  Widget build(BuildContext context) {
    //email field
    final emailField = TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ('Please enter your email.');
          }
          //reg expression for email validation
          if (!RegExp('^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]')
              .hasMatch(value)) {
            return ('Email invalid');
          }
          return null;
        },
        onSaved: (value) {
          _emailController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail),
          hintText: 'Enter your email address',
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
          //RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ('Please enter your password.');
          }
          // if (!regex.hasMatch(value)) {
          //   return ('Some characters are invalid.');
          // }
          return null;
        },
        onSaved: (value) {
          _passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          //contentPadding: EdgeInsets.symmetric(vertical: 20.0),
          hintText: 'Enter your password',
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
                            const Text('Login',
                                style:
                                    TextStyle(fontSize: 36)),
                            const SizedBox(height: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('Email',
                                  style: TextStyle(
                                      fontSize: 20, fontWeight: FontWeight.bold)),
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
                                      fontSize: 20, fontWeight: FontWeight.bold)),
                                const SizedBox(height: 4),
                                passwordField,
                              ],
                            ),
                            const SizedBox(height: 20),
          
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  const Text(
                                    'New to our application? ',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 20),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterPage()));
                                    },
                                    child: const Text(
                                      'Register now',
                                      style: TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16),
                                    ),
                                  )
                                ]),
                            const SizedBox(height: 50),
          
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: (Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: const Color(0xFF528AAE)),
                                    child: MaterialButton(
                                        minWidth:
                                            MediaQuery.of(context).size.width,
                                        onPressed: () {
                                          signIn(_emailController.text,
                                              _passwordController.text);
                                        },
                                        child: const Text(
                                          "LOGIN",
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
                                        borderRadius: BorderRadius.circular(50),
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
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
          )));
  }
}