import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorsapp/screens/auth/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../screens/user/mainPage.dart';
import '../screens/doctor/mainpage.dart';
import '../screens/auth/firebaseAuth.dart';
import '../widget/snackbar.dart';

class Reception {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  userReception() async {

    if(auth.currentUser != null){
      if(!auth.currentUser!.emailVerified){
        auth.currentUser!.sendEmailVerification();
        alertSnackbar("Your email is not verified\n An verification email is sent on your email\nPlease confirm your email\nNote: You can find email in spam if not in inbox!");
        Get.to(()=>SignIn());
      }else{
        String type = await getType(auth.currentUser!.uid);

        if(type == "doctor"){
          Get.offAll(()=>DoctorMainPage());
        }else if(type == "user"){
          Get.offAll(()=>MainPage());
        }else{
          Get.offAll(() => SignIn());
        }
      }
    }else{
      Get.offAll(() => FireBaseAuth());
    }
  }

  Future<String> getType(String uid) async {
    String type = "";
    try {
      type = await firestore
          .collection("doctors")
          .doc(auth.currentUser!.uid)
          .get()
          .then((value) => value['userType'].toString());
    } catch (e) {
      try {
        type = await firestore
            .collection("users")
            .doc(auth.currentUser!.uid)
            .get()
            .then((value) => value['userType'].toString());
      } catch (e) {

      }}
    print(type);
    return type;
  }
}
