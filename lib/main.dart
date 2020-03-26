
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:seller/pages/location.dart';
import 'package:seller/pages/register.dart';
import 'package:seller/pages/sellerlogin.dart';
import './pages/login_page.dart';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
FirebaseUser user;

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false,
      //home:LoginPage()));


      home: HomePage(null)));
}
String badd="Loading";
String curlat,curlon;
class HomePage extends StatefulWidget {

  final add;
  HomePage(this.add);

  @override
  _HomePageState createState() => _HomePageState();
}
Future<void> currentUser() async {
  user = await FirebaseAuth.instance.currentUser();
  print(user.email);
  print(user.uid);
  print(user.displayName);
  return user;
}
class _HomePageState extends State<HomePage> {

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress ;
  String u;
  String name="hello";
  String s="Login to view Status";
  FirebaseUser mCurrentUser;
  FirebaseAuth _auth;

  String _value = '';
  void _onClick(String value) => setState(() => _value = value);
  @override
  void initState(){
    super.initState();
    //getproducts();

    _getCurrentLocation();
    _getCurrentUser();
    print("Here outside async");
  }
  _getCurrentUser()async{
    _auth=FirebaseAuth.instance;
    mCurrentUser=await _auth.currentUser();
    print("Hello"+mCurrentUser.email.toString());
    name=mCurrentUser.email.toString();
    u=mCurrentUser.uid.toString();
    if(mCurrentUser.uid.toString()!=null){
      s="You are not a seller";
    }

  }

  _signOut() async {
    await _auth.signOut();
  }


  @override
  Widget build(BuildContext context) {


    return Scaffold(
        backgroundColor: Colors.blue,
      appBar: new AppBar(
            backgroundColor: Color(0xff104670),
            title: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                  children: <Widget>[
                    Row(
                      children:
                     <Widget>[
                      new IconButton(
                        icon: new Icon(Icons.place),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>new MyLocation()));
                          _getCurrentLocation();
                          currentUser();
                        },
                      ),
                       SingleChildScrollView(
                           child: Container(
                              child: new FlatButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>new MyLocation()));
                              }, child: Text(widget.add==null?badd:"${widget.add}",style: new TextStyle(fontSize: 15.0, color: Colors.white),))),)
                             //child: new FlatButton(onPre,new Text("${widget.add}",style: new TextStyle(fontSize: 15.0),)))),


                    ],
                  ),
              ],

            ),
                )
            ),
        //leading:new Text("hi"),


          ),




//      endDrawer: new Drawer(
//        child: new ListView(
//          children: <Widget>[
//            InkWell(
//              child: new UserAccountsDrawerHeader(
//
//
//                accountName: Text(name),
//                accountEmail: null,
//                currentAccountPicture: GestureDetector(
//                    child: new CircleAvatar(
//                      //backgroundImage: ImageProvider("images/men-jeans@2x.png"),
//                      backgroundColor: Colors.grey,
//                    )),
//                decoration: new BoxDecoration(color: Color(0xff104670)),
//              ),
//              onTap: (){
//                Navigator.push(context, MaterialPageRoute(builder: (context)=>new LoginPage()));
//              },
//            ),
//
//            InkWell(
//              onTap: () {},
//              child: ListTile(
//                title: Text('Men'),
//              ),
//            ),
//            InkWell(
//              onTap: () {},
//              child: ListTile(title: Text('Women')),
//            ),
//            InkWell(
//              onTap: () {
//                //Navigator.push(context, MaterialPageRoute(builder: (context)=>new electronics()));
//              },
//              child: ListTile(title: Text('Electronics')),
//            ),
//            InkWell(
//              onTap: () {},
//              child: ListTile(title: Text('Sports')),
//            ),
//            InkWell(
//              onTap: () {},
//              child: ListTile(title: Text('Books')),
//            ),
//            InkWell(
//              onTap: () {},
//              child: ListTile(title: Text('Home & Furniture')),
//            ),
//            InkWell(
//              onTap: () {},
//              child: ListTile(title: Text('Beauty & Personal Care')),
//            ),
//            Divider(),
//            Container(
//                color: Color(0xffaaaaaa),
//                child: new Column(
//                  children: <Widget>[
//                    InkWell(
//                      onTap: () {},
//                      child: ListTile(title: Text('My Orders')),
//                    ),
//                    InkWell(
//                      onTap: () {
//                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>new cart()));
//                      },
//                      child: ListTile(title: Text('My Cart')),
//                    ),
//                    InkWell(
//                      onTap: () {
//                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>new account()));
//                      },
//                      child: ListTile(title: Text('Account')),
//                    ),
//                    InkWell(
//                      onTap: () {},
//                      child: ListTile(title: Text('Notifications')),
//                    ),
//                    InkWell(
//                      onTap: () {},
//                      child: ListTile(title: Text('Budget')),
//                    ),
//                    InkWell(
//                      onTap: () {},
//                      child: ListTile(title: Text('Share')),
//                    ),
//                    InkWell(
//                      onTap: () {},
//                      child: ListTile(title: Text('Settings')),
//                    ),
//                    InkWell(
//                      onTap: () {
//                        _signOut();
//                        name="hi";
//                      },
//                      child: ListTile(title: Text('LOGOUT')),
//                    ),
//                    InkWell(
//                      onTap: () {},
//                      child: ListTile(title: Text('HELP')),
//                    )
//                  ],
//                )),
//          ],
//        ),
//      ),
        body: new ListView(

          children: <Widget>[
            new Image.asset('images/16x9@2x.png'),
            new Padding(padding: EdgeInsets.fromLTRB(0.0,50.0,0.0,0.0)),
            new Container(
              child:
              new OutlineButton(
                  child: new Text("SELLER LOGIN"),
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>new SellerLogin()));
                  },
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ),
            ),


            new Padding(padding: EdgeInsets.all(30.0)),

            new Text(s, textAlign: TextAlign.center,style: TextStyle(color: Colors.yellow,fontWeight: FontWeight.bold,fontSize: 22.0),),
            new Padding(padding: EdgeInsets.all(10.0)),
            Container(
              child: new OutlineButton(
                  child: new Text("APPLY FOR SELLER"),
                  onPressed: (u!=null)?(){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>new SellerRegister()));
                  }:null,
                  shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
              ),
            ),
          ],
        )

    );
  }

  _getCurrentLocation() {
    final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

    geolocator
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      curlat=_currentPosition.latitude.toString();
      curlon=_currentPosition.longitude.toString();

      Placemark place = p[0];

      setState(() {
        _currentAddress = "${place.locality}";
        print(place.locality);
      });
      badd=_currentAddress;
    } catch (e) {
      print(e);
    }
  }
}
