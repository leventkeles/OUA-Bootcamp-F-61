import 'package:ortamapp/helper/helper_function.dart';
import 'package:ortamapp/pages/auth/login_page.dart';
import 'package:ortamapp/pages/home_page.dart';
import 'package:ortamapp/services/auth_service.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../widgets/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}
String hexColor = "#005CDF";
Color backgColor = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

String hexColor2 = "#023F96";
Color buttonColor = Color(int.parse(hexColor2.substring(1, 7), radix: 16) + 0xFF000000);

class _RegisterPageState extends State<RegisterPage> {

  bool _isLoading = false;
  final formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String fullName = "";
  AuthService authService = AuthService();
  @override
  // This function saves the email input and accepts a nullable string
  void saveEmail(String? value) {
    // If the value is not null, assign it to the email variable
    if (value != null) {
      email = value;
    }
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgColor,
        body: _isLoading ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor,)) : SingleChildScrollView(
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
                        labelStyle: const TextStyle(

                          color: Colors.white,
                        ),
                        fillColor: Colors.white,
                        labelText: "Ad-Soyad",
                        prefixIcon: Icon(Icons.person,color: Colors.white,)
                    ),
                    onChanged: (val){
                      setState(() {
                        fullName = val;
                      });
                    },
                    validator: (val){
                      if(val!.isNotEmpty){
                        return null;
                      }else{
                        return "İsim boş bırakılamaz";
                      }
                    },
                  ),

                  const SizedBox(height: 20,),

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
                        labelStyle: const TextStyle(

                          color: Colors.white,
                        ),
                        fillColor: Colors.white,
                        labelText: "E-Posta",
                        prefixIcon: Icon(Icons.email,color: Colors.white,)
                    ),
                    onChanged: (val){
                      setState(() {
                        email = val;
                      });
                    },
                    validator: (val){
                      // Check if the email is valid and contains .edu.
                      bool isValid = RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+").hasMatch(val!);
                      bool hasEdu = val.contains(".edu.");
                      // Return an error message if either condition is false.
                      if (!isValid) {
                        return "Lütfen geçerli bir e-posta adresi giriniz";
                      } else if (!hasEdu) {
                        return "Lütfen üniversite mail adresinizi giriniz";
                      } else {
                        return null;
                      }
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
                        prefixIcon: Icon(Icons.lock,color: Colors.white,)
                    ),
                    validator: (val){
                      if(val!.length < 6){
                        return "Parola en az 6 karakterli olmalı.";
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
                        child: Text("KAYIT OL", style: TextStyle(fontSize: 16, color: Colors.white),),
                      ),
                      onPressed: (){
                        register();
                      },
                    ),
                  ),
                  const SizedBox( height: 60,),
                  Text.rich(
                      TextSpan(
                        text: "Mevcut hesabın var mı? ",
                        style: const TextStyle(color: Colors.white70, fontSize: 14),
                        children: <TextSpan>[
                          TextSpan(
                              text: "Giriş Yap",
                              style: const TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                nextScreen(context, const LoginPage());
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
  register() async {
    if(formKey.currentState!.validate() ){

      setState(() {
        _isLoading = true;
      });

      await authService.registerUserWithEmailandPassword(fullName, email, password).then((value) async {
        if(value == true) {
          // saving the shared preference state
          await HelperFunction.saveUserLoggedInStatus(true);
          await HelperFunction.saveUserNameSF(fullName);
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