import 'package:chatting/services/auth/auth_service.dart';
import 'package:chatting/components/my_textfeil.dart';
import 'package:flutter/material.dart';

class Loginpage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  Loginpage({super.key, required this.ontap});

  final void Function()? ontap;

  //login function
  void login(BuildContext context) async {
    debugPrint("Login button pressed");
    // auth service
    final authService = AuthService();
    
    //try to login
    try {
      await authService.signInWithEmailAndPassword(emailController.text, passwordController.text);
      debugPrint("Login Successful: ${emailController.text}");
    }
    //catch error
    catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Column(
                children: [
                  Icon(
                    Icons.all_inclusive_outlined,
                    size: 40,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  //welcome back message
                  Text("Welcome Back, you have been missed",style: TextStyle(color: Theme.of(context).colorScheme.primary),),
                ],
              ),
            ),
            //email text field
            Mytextfeild(
              hint: "Email",
              isPassword: false,
              controller: emailController,
            ),
            //password text field
            Mytextfeild(
              hint: "Password",
              isPassword: true,
              controller: passwordController,
            ),
            //login button
            SizedBox(
              width: 340,
              height: 50,
              child:ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:  Theme.of(context).colorScheme.primary,
                  foregroundColor:  Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Removes the border radius
                  ),
                ),
                onPressed: () => login(context),
                child: const Text("Login"),
              ),
              //child: MyButton(title: "Login", onTap: () => login(context))
              ),
            //register text
            GestureDetector(
              onTap: ontap,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a Member? ",
                      style: TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
                    Text(
                      "Register Now",
                      style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}