import 'package:bcrypt/bcrypt.dart';
import 'package:flutter/material.dart';
import 'package:prac_tpm_final_project_2/helper/db_helper.dart';
import 'package:prac_tpm_final_project_2/views/loginpage.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController checkPasswordController = TextEditingController();
  bool _isPasswordVisible1 = false;
  bool _isPasswordVisible2 = false;
  void initState() {
    super.initState();
    _isPasswordVisible1 = false;
    _isPasswordVisible2 = false;
  }

  regisHandler() {
    bool isFilled = true;
    if (usernameController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Warning! Username can\'t empty!',
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          width: 300,
          duration: Duration(seconds: 2),
        ),
      );
      isFilled = false;
    } else if (passwordController.text == '') {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Warning! Password can\'t empty!',
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          width: 300,
          duration: Duration(seconds: 2),
        ),
      );
      isFilled = false;
    }
    return isFilled;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Register Page'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'Register',
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.people),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible1 = !_isPasswordVisible1;
                            });
                          },
                          icon: Icon(_isPasswordVisible1
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    obscureText: !_isPasswordVisible1,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: checkPasswordController,
                    decoration: InputDecoration(
                        hintText: 'Check Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible2 = !_isPasswordVisible2;
                            });
                          },
                          icon: Icon(_isPasswordVisible2
                              ? Icons.visibility
                              : Icons.visibility_off),
                        )),
                    obscureText: !_isPasswordVisible2,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shadowColor: Colors.amber,
                    ),
                    onPressed: () async {
                      if (checkPasswordController.text !=
                          passwordController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Warning! Password doesn\'t match!',
                              textAlign: TextAlign.center,
                            ),
                            behavior: SnackBarBehavior.floating,
                            width: 300,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      } else if (checkPasswordController.text ==
                          passwordController.text) {
                        if (regisHandler()) {
                          final String hashedPassword = BCrypt.hashpw(
                              passwordController.text, BCrypt.gensalt());
                          final int result =
                              await DatabaseHelper.instance.insertUser({
                            'username': usernameController.text,
                            'password': hashedPassword,
                          });
                          if (result > 0) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Register Success',
                                  textAlign: TextAlign.center,
                                ),
                                behavior: SnackBarBehavior.floating,
                                width: 300,
                                duration: Duration(seconds: 2),
                              ),
                            );
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Register Failed',
                                  textAlign: TextAlign.center,
                                ),
                                behavior: SnackBarBehavior.floating,
                                width: 300,
                                duration: Duration(seconds: 2),
                              ),
                            );
                          }
                        }
                      }
                    },
                    child: Text('Register'),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account?'),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text('Login'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
