import 'package:ortamapp/pages/home_page.dart';
import 'package:ortamapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/widgets.dart';
import 'auth/login_page.dart';

class ProfilePage extends StatefulWidget {
  String userName;
  String email;
  ProfilePage({Key? key, required this.userName, required this.email}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 70,
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        title: const Text("Profil", style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white)),
      ),


      body: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.account_circle, size: 150, color: Colors.grey[700],),
            const SizedBox(height: 15,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("İsim-Soyisim:", style: TextStyle(fontSize: 17),),
                  const SizedBox(width: 10,),
                  Text(widget.userName, style: const TextStyle(fontSize: 17),),
                ],
              ),
            ),
            const Divider(height: 20,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Email:", style: TextStyle(fontSize: 17),),
                  const SizedBox(width: 10,),
                  Text(widget.email, style: const TextStyle(fontSize: 17),),
                ],
              ),
            ),


          ],
        ),
      ),
    ),


    );
  }
}

