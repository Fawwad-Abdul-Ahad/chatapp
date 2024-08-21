import 'package:chatapp/Screens/home_screen.dart';
import 'package:chatapp/Screens/signup_screen.dart';
import 'package:chatapp/provider/firebase_ogin_provider.dart';
import 'package:chatapp/services/chat_services2.dart';
import 'package:chatapp/widget/snackbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:chatapp/constants/colors.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

void despose(){
  super.dispose();
  emailController.dispose();
  passController.dispose();
}

  void loginUsers ()async{
  bool isLoading = false;
  String res = await AuthService().loginUser(
    // name: nameController1.text,
    email: emailController.text,
    pass: passController.text
  );

  if(res == 'success'){
    setState((){
      isLoading = true;
    });
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const HomeScreen()),
  );
  }
  else{
    setState(() {
      isLoading = true;
    });
    //show the snackbar error message
   showSnackbar(context); 
  }
}  
  
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 500,
                width: 400,
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(90),
                      bottomRight: Radius.circular(90)),
                ),
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.only(
                      top: 60,
                    ),
                    child: Column(
                      children: [
                        Image.asset("assets/images/logowhite.png"),
                        const SizedBox(
                          height: 12,
                        ),
                        const Text(
                          'Deliver Favourite Food',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
              top: 220,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  height: 450,
                  width: 350,
                  margin: const EdgeInsets.only(left: 20, right: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 15,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 22),
                    child: Column(
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10.0),
                          child: TextFormField(
                            controller: emailController,
                            decoration: InputDecoration(
                                hintText: "example@gmail.com",
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                ),
                                fillColor:
                                    const Color.fromARGB(22, 210, 210, 210),
                                filled: true,
                                prefixIcon: const Icon(Icons.email_sharp),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(140, 117, 117, 117),
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                )),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10.0),
                          child: TextFormField(
                             
                            controller: passController,
                            decoration: InputDecoration(
                                hintText: "password",
                                hintStyle: const TextStyle(color: Colors.grey),
                                fillColor:
                                    const Color.fromARGB(22, 210, 210, 210),
                                filled: true,
                                prefixIcon: const Icon(Icons.lock),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: Color.fromARGB(140, 117, 117, 117),
                                  ),
                                  borderRadius: BorderRadius.circular(6),
                                )),
                            obscureText: true,
                          ),
                        ),
                        Container(
                          height: 20,
                          width: double.infinity,
                          child: const Text(
                            "Forget Password?",
                            style: TextStyle(fontWeight: FontWeight.w400),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                       
                            
                           Container(
                            width: 320,
                            height: 60,
                            child: ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        primaryColor),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                loginUsers();
                                // value.emailController.clear();
                                // value.passController.clear();
                              },
                              child: const Center(
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
        
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        Text(
                          "Or",
                          style: TextStyle(fontSize: 16, color: primaryColor),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/images/fblogo.png"),
                            const SizedBox(
                              width: 18,
                            ),
                            Image.asset("assets/images/googlelogo.png"),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              )),
          Positioned(
              bottom: 50,
              left: 110,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Don't have an account?",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()),

                      );
                    },
                    child: Text(
                      "REGISTER",
                      style: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}