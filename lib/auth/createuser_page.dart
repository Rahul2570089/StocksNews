import 'package:flutter/material.dart';
import 'package:newsapp/auth/loginuser_page.dart';
import 'package:newsapp/auth/usercontroller.dart';
import 'package:newsapp/homepage.dart';
import 'package:newsapp/localdata/sharedpreferences.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
        backgroundColor: Colors.black,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                        controller: emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter email';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            filled: true,
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.black45),
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Colors.green,
                            )),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: Color.fromARGB(255, 243, 191, 46),
                            )))),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                          filled: true,
                          hintText: "Password",
                          hintStyle: TextStyle(color: Colors.black45),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Colors.green,
                          )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                            color: Color.fromARGB(255, 243, 191, 46),
                          ))),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_key.currentState!.validate()) {
                            setState(() {
                              isLoading = true;
                            });
                            var user = await UserController.createUser(
                                emailController.text, passwordController.text);
                            if (user.email != null) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage(
                                          token: UserSimplePreferences
                                              .getToken()!)));
                              setState(
                                () => isLoading = false,
                              );
                            } else {
                              setState(() {
                                isLoading = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                          'Something went wrong...User not created...')));
                            }
                          }
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.black),
                            shadowColor:
                                MaterialStateProperty.all(Colors.transparent),
                            elevation: MaterialStateProperty.all(0),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                        child: const Text('Create User'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginUserPage()));
                      },
                      style: ButtonStyle(
                          shadowColor:
                              MaterialStateProperty.all(Colors.transparent),
                          elevation: MaterialStateProperty.all(0),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)))),
                      child: const Text('Login'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
