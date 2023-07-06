import 'package:ortamapp/pages/home_page.dart';
import 'package:ortamapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/widgets.dart';
import 'auth/login_page.dart';

class LeaderBoardPage extends StatefulWidget {
  String userName;
  String email;
  LeaderBoardPage({Key? key, required this.userName, required this.email}) : super(key: key);

  @override
  State<LeaderBoardPage> createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sıralama Tablosu'),
        elevation: 0,
        centerTitle: true,
        toolbarHeight: 50,
        backgroundColor: Colors.blueAccent,
      ),

      body:

      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 170),
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

