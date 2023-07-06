import 'package:ortamapp/pages/home_page.dart';
import 'package:ortamapp/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/widgets.dart';
import 'auth/login_page.dart';
import 'package:ortamapp/pages/search_page.dart';
import 'package:iconsax/iconsax.dart';
import 'dart:math';
import 'package:flutter/cupertino.dart';
String hexColor = "#005CDF";
Color backgColor = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class StickyColors {
  static final List colors = [
    const Color(0xff4df0b5),
    const Color(0xff68c0ff),
    const Color(0xffff7676),
    const Color(0xffb868f6),
  ];
}
final _random = Random();
class GroupsPage extends StatefulWidget {

  String userName;
  String email;
  GroupsPage({Key? key, required this.userName, required this.email}) : super(key: key);

  @override
  State<GroupsPage> createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {

  List colors = [Colors.red, Colors.green, Colors.yellow];
  Random random = Random();
  int colorindex = 0;
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grupları Keşfet'),
        elevation: 0,
        actions: [
          IconButton(
              onPressed:(){ nextScreen(context, const SearchPage());},
              icon: const Icon(Icons.search,  )),
          // Text('Grup arama'),

        ],
        centerTitle: true,
        toolbarHeight: 50,

      ),

      body:

      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(

          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(

            children: [
              const SizedBox(height: 20,),
              category(),
              const SizedBox(height: 20,),
              category(),
              const SizedBox(height: 20,),
              category(),
            ],
          ),
        ),
      ),

    );
  }

  message(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: const Column(
        children: [

          SizedBox(height: 20,),
          Text("Kategoriler kısmı yapım aşamasındadır, dilerseniz arama butonunu kullanarak grup arayabilirsiniz :)"
            , textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

}

category(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      ElevatedButton(
        style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: StickyColors.colors[_random.nextInt(4)], fixedSize: const Size(160,160),),
        onPressed: () {  },
        child: const Wrap(
          children: <Widget>[
            Icon(Iconsax.game5, color: Colors.white,size: 30),
            SizedBox(width: 10),
            Text("Oyun",style:  TextStyle(fontSize: 30,color: Colors.white),),
          ],
        ),

      ),
      ElevatedButton(
        style: ElevatedButton.styleFrom(elevation: 0,backgroundColor: StickyColors.colors[_random.nextInt(4)], fixedSize: const Size(160, 160),),
        onPressed: () {  },
        child: const Wrap(
          children: <Widget>[
            Icon(Iconsax.game5, color: Colors.white,size: 30),
            SizedBox(width: 10),
            Text("Oyun",style:  TextStyle(fontSize: 30,color: Colors.white),),

          ],
        ),

      ),

    ],
  );

}

