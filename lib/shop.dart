import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final firestore = FirebaseFirestore.instance;
final auth = FirebaseAuth.instance;

class Shop extends StatefulWidget {
  const Shop({Key? key}) : super(key: key);

  @override
  State<Shop> createState() => _ShopState();
}

class _ShopState extends State<Shop> {

  getDate() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: "kim@test.com",
        password: "123456",
      );
    } catch (e) {
      print("error : ${e}");
    }
    // print(auth.currentUser?.uid);
    if(auth.currentUser?.uid == null){
      print('로그인 안됨');
    } else{
      print('로그인 됨');
    }

    //   var result = await auth.createUserWithEmailAndPassword(
    //     email: "kim@test.com",
    //     password: "123456",
    //   );
    //   // result.user?.updateDisplayName('yeom');
    //   print(result.user);
    // } catch (e) {
    //   print(e);
    // }
    try {
      var result = await firestore.collection('product').get();

      for (var doc in result.docs) {
        print(doc['name']);
      }
    } catch (e){
      print(e);
    }

  }
  @override
  void initState() {
    super.initState();
    getDate();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child:Text('샵페이지임'),
    );
  }
}
