import 'package:final_project_tpm_prac/views/loginpage.dart';
// import 'package:final_project_tpm_prac/views/registerpage.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: SafeArea(child: 
       Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.book, size: 300,),
            SizedBox(height: 50,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 50),
                primary: Colors.black,
                shadowColor: Colors.amber
                 
              ),
              onPressed: (){
                Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => LoginPage())
                );
              }, child: Text('Get Started')),
            // SizedBox(height: 100,)
          ],
        
        ),
       )
       ),
      
      );
  }
}