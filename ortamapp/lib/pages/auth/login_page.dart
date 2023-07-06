import 'package:ortamapp/pages/auth/register_page.dart';
import 'package:ortamapp/services/auth_service.dart';
import 'package:ortamapp/services/database_service.dart';
import 'package:ortamapp/widgets/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../helper/helper_function.dart';
import '../home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}
String hexColor = "#005CDF";
Color backgColor = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

String hexColor2 = "#023F96";
Color buttonColor = Color(int.parse(hexColor2.substring(1, 7), radix: 16) + 0xFF000000);


class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  bool _isLoading = false;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgColor,
        body: _isLoading ? Center( child: CircularProgressIndicator(color: Theme.of(context).primaryColor,) ,) : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 80),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget> [
                Image.asset("assets/login_logo.png", width: 200, height: 200,),
                const SizedBox(height: 20,),
                Text("ORTAM", style: GoogleFonts.fredoka(textStyle: const TextStyle(color: Colors.white,fontSize: 40, fontWeight: FontWeight.w500),), ),
                const SizedBox(height: 80,),
                TextFormField(
                    decoration: textInputDecoration.copyWith(
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 2,color: Colors.white),
                        ),
                        disabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 2,color: Colors.white),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 2,color: Colors.white),
                        ),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2,)
                        ),
                        fillColor: Colors.white,
                        labelStyle: const TextStyle(
                          color: Colors.white,
                        ),
                      labelText: "E-Posta",
                      prefixIcon: const Icon(Icons.email,color: Colors.white,)
                    ),
                  onChanged: (val){
                    setState(() {
                      email = val;
                    });
                  },
                  validator: (val){
                    return RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+").hasMatch(val!) ? null : "Lütfen geçerli bir mail giriniz";
                  },
                ),
                const SizedBox(height: 15,),
                TextFormField(
                  obscureText: true,
                  decoration: textInputDecoration.copyWith(
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2,color: Colors.white),
                      ),
                      disabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2,color: Colors.white),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        borderSide: BorderSide(width: 2,color: Colors.white),
                      ),
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(width: 2,)
                      ),
                      labelStyle: const TextStyle(

                        color: Colors.white,
                      ),
                      fillColor: Colors.white,
                      labelText: "Parola",
                      prefixIcon: const Icon(Icons.lock,color: Colors.white,)
                  ),
                  validator: (val){
                    if(val!.length < 6){
                      return "Parola en az 6 karakterden oluşmalıdır.";
                    }
                    else{
                      return null;
                    }
                  },
                  onChanged: (val){
                    setState(() {
                      password = val;
                    });
                  },
                ),
                const SizedBox(height: 20,),

                SizedBox(
                  width: double.infinity,
                  height: 60.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(

                        backgroundColor: buttonColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(1.0),
                      child: Text("GİRİŞ YAP", style: TextStyle(fontSize: 16, color: Colors.white),),
                    ),
                    onPressed: (){
                      login();
                    },
                  ),
                ),
                const SizedBox( height: 120,),
                Text.rich(
                  TextSpan(
                    text: "Bir hesabın yok mu? ",
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    children: <TextSpan>[
                      TextSpan(
                        text: "Kayıt Ol",
                        style: const TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()..onTap = () {
                            nextScreen(context, const RegisterPage());
                        }
                      )
                    ],
                  )
                )

              ],
            ),
          ),
        ),
      )
    );
  }

  login() async {
    if(formKey.currentState!.validate() ){

      setState(() {
        _isLoading = true;
      });

      await authService.loggingWithUserNameandPassword(email, password).then((value) async {
        if(value == true) {

          QuerySnapshot snapshot =  await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid).gettingUserData(email);

          // saving the values to our shared preference

          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserNameSF(
            snapshot.docs[0]['fullName']
          );
          await HelperFunction.saveUserEmailSF(email);

          nextScreenReplace(context, const HomePage());
        }
        else{
          setState(() {
            showSnakbar(context, Colors.red, value);
            _isLoading = false;
          });
        }
      });

    }
  }
}