import 'package:final_project_tpm_prac/views/loginpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordVisible = false;
  void initState() {
    super.initState();
    _isPasswordVisible = false;
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
                    decoration: InputDecoration(
                      hintText: 'Username',
                      prefixIcon: Icon(Icons.people),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Check Password',
                      prefixIcon: Icon(Icons.lock),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(_isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off),
                      )
                    ),
                    obscureText: !_isPasswordVisible,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      shadowColor: Colors.amber,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
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
