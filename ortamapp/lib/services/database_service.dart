import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  searchByDomain(String groupName, String userDomain) async {
    return groupCollection
        .where("groupName", isEqualTo: groupName)
        .where("adminDomain", isEqualTo: userDomain)
        .get();
  }

  // var olup olmadığını bilmek için boolean değeri döndürme
  Future<bool>isUserJoined(String groupName,String groupId, String userName) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    if(groups.contains("${groupId}_$groupName")){
      return true;
    }
    else{
      return false;
    }
  }
  final String? uid;
  DataBaseService({this.uid});
  //collecitons lar için referans
  final CollectionReference userCollection = FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection = FirebaseFirestore.instance.collection("groups");
  // userdata kaydetme
  Future savingUserdata(String fullname, String email ) async{
    return await userCollection.doc(uid).set({
      "fullName": fullname,
      "email": email,
      "groups": [],
      "profilePic": "",
      "uid": uid,
    });
  }
  // user dataların alınması
  Future gettingUserData (String email) async {
    QuerySnapshot snapshot = await userCollection.where("email", isEqualTo: email).get();
    return snapshot;
  }
  // kullanıcnın grupları
  getUserGroups() async {
    return userCollection.doc(uid).snapshots();
  }
  // grup oluşturma
  Future createGroup(String userName, String id, String groupName, String adminEmail,String category) async {
    String adminEmailDomain = adminEmail.substring(adminEmail.indexOf('@') + 1); // Adminin e-posta alan adını al
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "adminDomain":adminEmailDomain,
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": "",
      "category":category,
    });
    await groupDocumentReference.update({
      "members":FieldValue.arrayUnion(["${uid}_$userName"]),
      "groupId": groupDocumentReference.id,
    });
    DocumentReference userDocumentRefence = userCollection.doc(uid);
    // removed await here check once
    return await userDocumentRefence.update({
      "groups":FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }
  //mesajları çekme bölümü
  getChats(String groupId){
    return groupCollection.doc(groupId).collection("messages").orderBy("time").snapshots();
  }
  Future getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return documentSnapshot['admin'];
  }
  //get members
  getGroupMembers(groupId) async {
    return groupCollection.doc(groupId).snapshots();
  }

  // gruba katıl/bekle arasında geçiş yapma
  Future toggleGroupJoin(String groupId, String userName, String groupName) async {
    //doc
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];
    //grubun kullanıcısı varsa, onları kaldır veya yeniden katıl
    if(groups.contains("${groupId}_$groupName")){
      await userDocumentReference.update({
        "groups":FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members":FieldValue.arrayRemove(["${uid}_$userName"])
      });
    }
    else{
      await userDocumentReference.update({
        "groups":FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members":FieldValue.arrayUnion(["${uid}_$userName"])
      });
    }
  }
  // send message
  sendMessage(String groupId, Map<String, dynamic> chatMessageData) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessageData);
    groupCollection.doc(groupId).update({
      "recentMessage":chatMessageData['message'],
      "recentMessageSender":chatMessageData['sender'],
      "recentMessageTime":chatMessageData['time'].toString(),
    });
  }
}