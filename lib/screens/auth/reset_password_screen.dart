import 'package:doctorsapp/screens/auth/signIn.dart';
import 'package:doctorsapp/widget/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ResetPasswordScreen extends StatefulWidget {
  static const String screenId = 'reset_password_screen';
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              ResetForm(),
            ]),
      ),
    );
  }
}

class ResetForm extends StatefulWidget {
  const ResetForm({
    Key? key,
  }) : super(key: key);

  @override
  State<ResetForm> createState() => _ResetFormState();
}

class _ResetFormState extends State<ResetForm> {
  late final TextEditingController _emailController;
  late final FocusNode _emailNode;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController = TextEditingController();
    _emailNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _emailNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Please Enter your email for forgot password"),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  focusNode: _emailNode,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your Email',
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                      contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8))),
                ),
                const SizedBox(
                  height: 25,
                ),
                MaterialButton(onPressed: (){
                  FirebaseAuth.instance
                      .sendPasswordResetEmail(
                      email: _emailController.text)
                      .then((value) {
                    snackbar("Done", "An email is sent to ${_emailController.text} to change the password");
                    Get.to(()=>SignIn());
                  });
                },child: Text("Send Reset Link",style: TextStyle(color: Colors.white),),color: Colors.tealAccent,),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
