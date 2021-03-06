

import 'package:flutter/material.dart';
import  'package:nominatim_location_picker/nominatim_location_picker.dart';
import 'writePostData.dart';
import 'package:firebase_auth/firebase_auth.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key key}) : super(key: key);

  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  int _radioValue = 0;
  String PostLocation='';
  String description,name,bloodgroup,uid;
  FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser()  {

    User user=  _auth.currentUser;


    uid=user.uid;


  }


  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    });
  }

  Future getLocationWithNominatim() async {
    Map result = await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return NominatimLocationPicker(
            searchHint: 'Search Location',
            awaitingForLocation: "Loading....",
          );
        });
    if (result != null) {
      Map maplocation=result;

      print(result);

    } else {
      return;
    }
  }

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(

      child: Container(
        height: MediaQuery.of(context).size.height*0.8 ,
        decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
        topLeft: const Radius.circular(20.0),
        topRight: const Radius.circular(20.0),
        ),
        ),
      child: Padding(
        padding: const EdgeInsets.only(top:5,left: 12,right: 12,bottom: 3),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                textBaseline: TextBaseline.alphabetic,

                children: [
                  Padding(
                    padding: const EdgeInsets.only(top:20.0,right: 50),
                    child: Text(

                      'Post your Blood Request !',


                      style: TextStyle(
                        decoration: TextDecoration.underline,
                        textBaseline: TextBaseline.alphabetic,
                        fontSize: 15.0,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  RaisedButton(
                    padding:EdgeInsets.all(0),

                    color: Colors.blue,


                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                    onPressed: (){
                      Navigator.pop(context);
                      setState(() {
                        writePostData(neededbloodgroup: 'B+',uid:uid,description: description,Postname: name).PostRequests();
                      });


                    },

                    child:Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0,
                      ),


                    ),

                  ),
                ],
              ),
              Divider(

              ),

              TextField(
                onChanged: (val){
                  name=val;
                },

                decoration: InputDecoration(
                  labelText: 'Enter your Name',


                ),
              ),
              SizedBox(height: 20.0,),
              TextField(
                keyboardType: TextInputType.multiline,
                maxLines: 3,
                onChanged: (val){
                  description=val;
                },

                style: TextStyle(

                  fontSize: 20.0,
                ),
                decoration: InputDecoration(

                  labelText: 'Description',
                  alignLabelWithHint: true,


                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BloodGroupText(text: 'B+'),
                  Radio(
                    value: 0,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  BloodGroupText(text: 'O+'),
                   Radio(

                    value: 1,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  BloodGroupText(text: 'A+'),
                  Radio(
                    value: 2,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),
                  BloodGroupText(text: 'AB+'),
                  Radio(
                    value: 3,
                    groupValue: _radioValue,
                    onChanged: _handleRadioValueChange,
                  ),

                ],
              ),

            Row(

              children: <Widget>[
              SizedBox(width: 22.0,),
              BloodGroupText(text: 'B-'),
              Radio(
                value: 4,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              BloodGroupText(text: 'O-'),
              Radio(
                value: 5,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
                SizedBox(width: 12.0,),
              BloodGroupText(text: 'A-'),
              Radio(
                value: 6,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
              BloodGroupText(text: 'AB-'),
              Radio(
                value: 7,
                groupValue: _radioValue,
                onChanged: _handleRadioValueChange,
              ),
            ],
            ),
              TextField(
                style: TextStyle(
                  fontSize: 15.0,
                ),
                textInputAction: TextInputAction.go,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.add_location),
                  hintText: PostLocation,

                  hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0),
                  contentPadding:
                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                ),
                onTap: ()async {
                  await getLocationWithNominatim();

                },
              ),
            ],

          ),
        ),
      ),

        ),
    );


}
  }

class BloodGroupText extends StatelessWidget {
  BloodGroupText({this.text});
  final text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
    style: TextStyle(
      fontSize: 18.0,
    ),);
  }
}