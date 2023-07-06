import 'package:ortamapp/helper/helper_function.dart';
import 'package:ortamapp/pages/auth/login_page.dart';
import 'package:ortamapp/pages/profile_page.dart';
import 'package:ortamapp/pages/groups_page.dart';
import 'package:ortamapp/pages/home.dart';
import 'package:ortamapp/pages/leaderboard_page.dart';
import 'package:ortamapp/services/database_service.dart';
import 'package:ortamapp/widgets/group_tile.dart';
import 'package:ortamapp/widgets/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:iconsax/iconsax.dart';


final controller = PersistentTabController(initialIndex: 0);
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

String hexColor = "#005CDF";
Color backgColor = Color(int.parse(hexColor.substring(1, 7), radix: 16) + 0xFF000000);

class _HomePageState extends State<HomePage> {
  int index = 0;
  String userName = "";
  String email ="";
  AuthService authService = AuthService();
  Stream? groups;
  bool _isLoading = false;
  String groupName = "";
  List<String> categoryList = ['Bilim', 'Eğlence', 'Gez', 'Sanat', 'Spor', 'Teknoloji'];
  String selectedCategory=" ";
  @override
  void initState() {
    super.initState();
    gettingUserData();
  }

  // string manipulation

  String getId(String res){
    return res.substring(0,res.indexOf("_"));
  }
  String getName(String res){
    return res.substring(res.indexOf("_")+1);
  }

  gettingUserData() async {
    await HelperFunction.getUserNameFromSF().then((value){
      setState(() {
        userName = value!;
      });
    });
    await HelperFunction.getUserEmailFromSF().then((val) => {
      setState((){
        email = val!;
      })
    });
    //getting the list of snapshot in our stream
    await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid).getUserGroups().then((snapshot){
      setState(() {
        groups = snapshot;
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 70,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          title:  Text("ORTAM", style: GoogleFonts.fredoka(textStyle: const TextStyle(fontSize: 40, fontWeight: FontWeight.w500),), ),
        ),

      body: IndexedStack(
        index: index,
        children:  [
          Home(userName: userName, email: email),
          GroupsPage(userName: userName, email: email),
          groupList(),
          LeaderBoardPage(userName: userName, email: email),
          ListView(
              padding: const EdgeInsets.symmetric(vertical: 50),
              children:<Widget> [
                Icon(Icons.account_circle, size: 150, color: Colors.grey[700],),
                const SizedBox(height: 15,),
                Text(userName, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(height: 30,),
                const Divider(height: 2,),
                ListTile(
                  onTap: (){},
                  selectedColor: Theme.of(context).primaryColor,
                  selected: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  leading: const Icon(Icons.group),
                  title: const Text("Gruplar", style: TextStyle(color: Colors.black),),
                ),
                ListTile(
                  onTap: (){
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => ProfilePage(userName: userName, email: email)));
                  },
                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  leading: const Icon(Icons.person_pin),
                  title: const Text("Profil", style: TextStyle(color: Colors.black),),
                ),
                ListTile(
                  onTap: () async {
                    showDialog(barrierDismissible: false, context: context, builder: (context){
                      return AlertDialog(
                        title: const Text("Çıkış Yap"),
                        content: const Text("Çıkış yapmak istediğinizden emin misiniz ☹️"),
                        actions: [
                          IconButton(onPressed: (){
                            Navigator.pop(context);
                          },
                            icon: const Icon(Icons.cancel, color: Colors.red,),
                          ),
                          IconButton(onPressed: () async {
                            await authService.signOut();
                            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const LoginPage()), (route) => false);
                          },
                            icon: const Icon(Icons.exit_to_app, color: Colors.green,),
                          ),
                        ],
                      );
                    });
                  },

                  contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("Çıkış", style: TextStyle(color: Colors.black),),
                ),

              ],
            ),



        ],
      ),


      //bottom bar başlangıç
      bottomNavigationBar: BottomNavigationBar(
        type : BottomNavigationBarType.fixed,
        //label isimlerini aç/kapa
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: Theme.of(context).primaryColor,
        currentIndex: index,
        onTap: (int newindex) {
          setState(() {
            index = newindex;
          });
        },
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white70,
            icon: Icon(Iconsax.home5,size: 40,),
            activeIcon: Icon(Iconsax.home5, color: Colors.white , size: 40,),
            label: "Anasayfa",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white70,
            icon: Icon(Iconsax.discover5,size: 40, ),
            activeIcon: Icon(Iconsax.discover5, color: Colors.white , size: 40,),
            label: "Keşfet",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white70,
            icon: Icon(Iconsax.message_text5, size: 60,),
            activeIcon: Icon(Iconsax.message_text5, color: Colors.white , size: 60,),
            label: "Gruplarım",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white70,
            icon: Icon(Iconsax.cup5, size: 40, ),
            activeIcon: Icon(Iconsax.cup5, color: Colors.white , size: 40,),
            label: "Sıralama",
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white70,
            icon: Icon(Icons.settings, size: 40, ),
            activeIcon: Icon(Icons.settings, color: Colors.white , size: 40,),
            label: "Ayarlar",
          ),

        ],

      ),


    //floatingactionbutton

    );
  }


  popUpDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        String selectedCategory = categoryList[0]; // Initialize selected category

        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text("Bir grup oluştur", textAlign: TextAlign.left),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isLoading == true
                      ? Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor))
                      : TextField(
                    onChanged: (val) {
                      setState(() {
                        groupName = val;
                      });
                    },
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<String>(
                    value: selectedCategory,
                    items: categoryList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: const Text("İPTAL"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (groupName != "") {
                      setState(() {
                        _isLoading = true;
                      });

                      await DataBaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                          .createGroup(userName, FirebaseAuth.instance.currentUser!.uid, groupName, email, selectedCategory)
                          .whenComplete(() {
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.of(context).pop();
                        showSnakbar(context, Colors.green, "Grubunuz başarılı bir şekilde oluşturuldu.😍");
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                  child: const Text("OLUŞTUR"),
                ),
              ],
            );
          },
        );
      },
    );
  }

  groupList(){
//hata var düzelt

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (){
          popUpDialog(context);
        },
        elevation: 0,
        label: const Text('Grup Oluştur'),
        backgroundColor: Theme.of(context).primaryColor,
        icon: const Icon(Iconsax.add_circle5, color: Colors.white,),
      ),
      body: Container(
        child: StreamBuilder(stream: groups,
          builder: (context, AsyncSnapshot snapshot,){
            if(snapshot.hasData){
              if(snapshot.data['groups'] != null){
                if(snapshot.data['groups'].length != 0){
                  return ListView.builder(
                    itemCount: snapshot.data['groups'].length,
                    itemBuilder: (context,index){
                      int reveseIndex = snapshot.data['groups'].length - index - 1;
                      return GroupTile(
                          groupName: getName(snapshot.data['groups'][reveseIndex].toUpperCase()), groupId: getId(snapshot.data['groups'][reveseIndex]), userName: snapshot.data['fullName']);
                    },
                  );
                }else{
                  return noGroupWidget();
                }
              }
              else{
                return noGroupWidget();
              }
            }
            else{
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,

                ),
              );}
          },

        ),
      ),
    );
  }



  noGroupWidget(){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
              onTap: (){
                popUpDialog(context);
              },
              child: Icon(Icons.add_circle, color: Colors.grey[700], size: 75,)),
          const SizedBox(height: 20,),
          const Text("Herhangi bir gruba katılmadınız, bir grup oluşturmak için ekle simgesine dokunun veya bir gruba katılabilirsiniz."
            , textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}