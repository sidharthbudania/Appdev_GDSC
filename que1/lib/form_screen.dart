import 'package:flutter/material.dart';

class Formscreen extends StatefulWidget{

  @override
  State<Formscreen> createState() => _FormScreenState();
}

class UserDetails {
  String? username;
  String? password;
  String? email;
  String? rollNo;
}

class _FormScreenState extends State<Formscreen>{

final _formfield=GlobalKey<FormState>();
bool passtoggle=true;

 final userDetails = UserDetails();
  final TextEditingController username_Controller = TextEditingController();
  final TextEditingController password_Controller = TextEditingController();
  final TextEditingController email_Controller = TextEditingController();
  final TextEditingController rollNo_Controller = TextEditingController();

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Form page"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 60),
        child:Form(
          key: _formfield,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "asset/image/logo.png",
              height: 100,
              width: 100,
            ),
            SizedBox(height: 50),
            
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: rollNo_Controller,
              decoration: InputDecoration(
                labelText: "Roll no",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.add_card),
              ),
              onChanged: (value){
                userDetails.rollNo=value;
              },
            ),

            SizedBox(height: 20),

            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: username_Controller,
              decoration: InputDecoration(
                labelText: "User name",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.verified_user),
              ),
              onChanged: (value) {
            userDetails.username = value;
          },
            ),

            SizedBox(height: 20),
            
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: email_Controller,
              decoration: InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
                
              ),
              validator: (value){

                 bool emailvalid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
             
                if(value.isEmpty){
                  return "Enter Email";
                }
  
                else if(!emailvalid){
                  return "Enter valid email";
                }
              },

            onChanged: (value) {
            userDetails.email = value;
          },

            ),

            SizedBox(height: 20),
             TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: password_Controller,
              obscureText: passtoggle,
              decoration: InputDecoration(
                labelText: "Password",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.lock),
                suffixIcon: InkWell(
                  onTap: (){
                 
                  setState(() {
                    passtoggle=!passtoggle;
                
                  });
                  },

                child: Icon(passtoggle ? Icons.visibility : Icons.visibility_off) ,

  

                )
              ),
              validator: (value){
                if(value!.isEmpty){
                  return "Enter Password";
                }
                else if(password_Controller.text.length < 6){
                  return "Password length is too short (should be greater than 6)";
                }
              },

            onChanged: (value) {
            userDetails.email = value;
          },
            ),

         SizedBox(height: 60),
        InkWell(
          onTap: () {
            if (_formfield.currentState!.validate()) {
              email_Controller.clear();
              password_Controller.clear();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LogInPage(userDetails: userDetails),
                ),
              );
            }
          },
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Center(
              child: Text(
                "Log In",
                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),

        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dont have an account ?",
              style: TextStyle(fontSize: 17),
              ),
          
          TextButton(onPressed: (){}, child: Text("Sign Up",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),))
          ],

        )
          ],
        )
        )
        ),

      ),
    );
  }
}
class LogInPage extends StatelessWidget {
  final UserDetails userDetails;

  const LogInPage({Key? key, required this.userDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log In'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${userDetails.username ?? 'N/A'}'),
            Text('Password: ${userDetails.password ?? 'N/A'}'),
            Text('Email: ${userDetails.email ?? 'N/A'}'),
            Text('Roll No: ${userDetails.rollNo ?? 'N/A'}'),
            SizedBox(height: 25),
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Log Out',
                  style: TextStyle(color: Colors.red), 
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
