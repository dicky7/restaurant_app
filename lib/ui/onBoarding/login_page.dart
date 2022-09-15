import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:restaurant_app/ui/main/main_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  static const rootName = "/login_page";
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _name = "";
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                  child: Lottie.asset("images/food.json", height: size.height /2 )
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 22),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          const Text(
                            "Lets Find Near Restaurant",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                                color: Colors.amber),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: TextFormField(
                              decoration: const InputDecoration(
                                labelText: "Your Name",
                              ),
                              validator: (value){
                                if (value == null || value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                _name = value;
                                return null;
                              },
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                            width: double.infinity, // <-- match_parent
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.amberAccent,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))

                              ),
                              child: const Text("Login"),
                              onPressed: () {
                                if (_formKey.currentState!.validate()){
                                  Navigator.pushReplacementNamed(context, MainPage.rootName);
                                  saveUsername(_name, true);
                                }
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  saveUsername(String username, bool state) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setString("username", username);
      prefs.setBool("loginState", state);
    });
  }
}

