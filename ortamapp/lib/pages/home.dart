import 'package:iconsax/iconsax.dart';
import 'package:ortamapp/pages/home_page.dart';
import 'package:ortamapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/widgets.dart';
import 'auth/login_page.dart';

class Home extends StatefulWidget {
  String userName;
  String email;
  Home({Key? key, required this.userName, required this.email}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(

          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 200),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(Icons.format_paint, size: 150, color: Colors.grey[700],),
              const SizedBox(height: 15,),
              const SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("Bu sayfa yapım aşamasındadır", style: TextStyle(fontSize: 17),),
                    SizedBox(width: 10,),
                    Text(":(", style: TextStyle(fontSize: 17),),
                  ],
                ),
              ),
              const Divider(height: 20,),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                ),
              ),
              const SizedBox(height: 200,),
            ],
          ),
        ),
      ),

    );
  }
}

