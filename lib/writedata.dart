import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';

class writeData{

  writeData({this.name,this.phone,this.uid,this.age,this.bloodgroup});
  String phone,name,uid,age,bloodgroup;

  FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference collectionReference = FirebaseFirestore.instance.collection('data');



  Future <void > writeDonorData(){
    collectionReference.doc(uid).set({
      'name':name,
      'phone' :phone,
      'gender' :'',
      'age':age,
      'bloodgroup':bloodgroup,

    });

  }
List UserProfileList=[];





  Future getUsersList() async {
    List VolunteersList=[];

    try {
      await collectionReference.get().then((querySnapshot) {
        querySnapshot.docs.forEach((element) {
          VolunteersList.add(element.data());
        });
      });
      print('done');
      return VolunteersList;
    }catch(e){
      print(e.toString());
      print(' cant');
    return null;
    }




  }




}
