import 'package:flutter/material.dart';
import 'dart:async';
import 'package:usage_stats/usage_stats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_login/constraints.dart';

class appusage extends StatefulWidget {
  @override
  _appusageState createState() => _appusageState();
}

//Change----Firsebase
class _appusageState extends State<appusage> {
  final _auth = FirebaseAuth.instance;
  final _firestore = Firestore.instance;
  FirebaseUser loggedInUser;


  List<EventUsageInfo> events = [];
  Map<String, UsageInfo> aggUsageS = Map();
  Map<String,dynamic> appStatsPush= Map();
  @override
  void initState() {
    super.initState();
    getCurrentUser();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      initUsage();
    });
  }

  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    }catch(e){
      print(e);
    }
  }


  void getAppStats() async {
    DateTime endDate = new DateTime.now();
    // DateTime startDate = DateTime(2020, 1, 1, 0, 0, 0);
    DateTime startDate = endDate.subtract(Duration(days: 7));

    //------------------Final Push---------------------------Start
    final QuerySnapshot qSnap = await Firestore.instance.collection('users').document(loggedInUser.uid).collection("AppUsageStats").getDocuments();
    final int collLength = qSnap.documents.length;
    // print("Length of Collection  $collLength");
    // appStatsPush.forEach((key, value)=> print("${key} : ${value}"));
    // print("Length of Document \n");
    if(collLength == 0)
      {
        // print("It is EMPTYyYYYYyYy");
        _firestore
            .collection("users").document(loggedInUser.uid).collection("AppUsageStats").add({
          // 'Apps' : {'Instagram':[23,8],'Facebook':[13,2],'Whatsapp':[10,2],'LinkedIn':[0,30]},
          "Apps" : appStatsPush,
          'endDate' : Timestamp.fromDate(endDate),
          'startDate' : Timestamp.fromDate(startDate),
        });
      }
    else
      {
        // print("It is Not EMPTYyYYYYyYy");
        // DocumentSnapshot orderData = AppUsageStatsSnapshot.data.documents[index];
        final QuerySnapshot qSnap = await Firestore.instance.collection('users').document(loggedInUser.uid).collection("AppUsageStats").getDocuments();
        final String firstDocid = qSnap.documents[0].documentID;
        // print("AppUsage ma Document id ${firstDocid}");//change-------------------------------
        // print(firstDocid);
        // print(loggedInUser.uid);
        // print(_firestore.collection("users").document(loggedInUser.uid).collection("AppUsageStats").);
        _firestore
            .collection("users").document(loggedInUser.uid).collection("AppUsageStats").document(qSnap.documents[0].documentID).updateData({
          // 'Apps' : {'Instagram':[23,8],'Facebook':[13,2],'Whatsapp':[10,2],'LinkedIn':[0,30]},
          "Apps" : appStatsPush,
          'endDate' : Timestamp.fromDate(endDate),
          'startDate' : Timestamp.fromDate(startDate),
        });
      }


    //------------------Final Push---------------------------End
  }


  Future<void> initUsage() async {
    UsageStats.grantUsagePermission();
    DateTime endDate = new DateTime.now();
    // DateTime startDate = DateTime(2020, 1, 1, 0, 0, 0);
    DateTime startDate = endDate.subtract(Duration(days: 7));

    // print("EndDate ${endDate}");
    // print("startDate ${startDate}");

    List<EventUsageInfo> queryEvents =
    await UsageStats.queryEvents(startDate, endDate);
    Map<String, UsageInfo> aggUsageStat = await UsageStats.queryAndAggregateUsageStats(startDate, endDate);
    Map<String,dynamic> appStatsPush= Map();

    this.setState(() {
      events = queryEvents.reversed.toList();
      aggUsageS = aggUsageStat;
      appStatsPush = appStatsPush;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> pcname = ['com.instagram.android', 'com.linkedin.android', 'com.whatsapp',
      'com.facebook.katana','com.activision.callofduty.shooter','com.google.android.youtube','com.twitter.android','com.snapchat.android','com.spotify.music'];

    Map<String,String> appName = {'com.instagram.android': 'Instagram', 'com.linkedin.android': 'LinkedIn', 'com.whatsapp': 'Whatsapp',
      'com.facebook.katana':'Facebook','com.activision.callofduty.shooter':'Call Of Duty','com.google.android.youtube':'Youtube','com.twitter.android':'Twitter',
      'com.snapchat.android':'Snapchat', 'com.spotify.music' : 'Spotify'
    };

    Map<String, int> map1 = {'com.instagram.android': 1, 'com.linkedin.android': 1, 'com.whatsapp': 1,
      'com.facebook.katana':1,'com.activision.callofduty.shooter':1,'com.google.android.youtube':1,'com.twitter.android':1,
      'com.snapchat.android':1,'com.spotify.music':1
    };

    // Map<String,int> outPut_app = Map();
    //Common---User name(1)----strt date(1)----enddate(1)-----
    //map<string,pair<int,int>>  ----appname---hr,mn----
    //dynamic Needed- Change-----------------------------------------------------------------------
    Map<String, double> dataMap = {
      "Flutter": 5,
      "React": 3,
      "Xamarin": 2,
      "Ionic": 2,
    };
    //dynamic Needed- Change-----------------------------------------------------------------------

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false, //Yellow and WHite UI change
        appBar: AppBar(
          title: const Text("App Usage Statistics"),
          backgroundColor: kPrimaryLightColor,
        ),
        body: Container(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    // title: Text(events[index].packageName),
                    title: Text(appName[pcname[index]],style: TextStyle(color: Colors.white),),
                    subtitle: Text((() {


                      if(map1[pcname[index]]==1 ){
                        int hrs=0,mns=0;
                        try{
                          hrs = DateTime.fromMillisecondsSinceEpoch(int.parse(aggUsageS[pcname[index]].totalTimeInForeground)).hour;
                          mns = DateTime.fromMillisecondsSinceEpoch(int.parse(aggUsageS[pcname[index]].totalTimeInForeground)).minute;
                        }catch(e){
                          hrs = 5;
                          mns = 30;
                        }

                        hrs = hrs - 5;
                        mns = mns - 30;
                        if(mns<0)
                        {
                          mns = mns + 60;
                          hrs = hrs - 1;
                        }
                        DateTime endDate = new DateTime.now();
                        // DateTime startDate = DateTime(2020, 1, 1, 0, 0, 0);
                        DateTime startDate = endDate.subtract(Duration(days: 7));

                        appStatsPush[appName[pcname[index]]] = [hrs,mns];

                        // print(index);
                        if(index == pcname.length - 1)
                          {
                            // print(index);
                            getAppStats();            //Change------------
                          }
                        String str = "From ${startDate.day}/${startDate.month}/${startDate.year} to ${endDate.day}/${endDate.month}/${endDate.year} ";
                        return str+"\nWeekly Usage Time : (${hrs} hours, ${mns} minutes)";

                      }
                      return "ho";
                    })(),style: TextStyle(color: Colors.grey),),

                  );

                },
                separatorBuilder: (context, index) => Divider(),
                // itemCount: events.length
                itemCount: pcname.length
            )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            initUsage();
          },
          child: Icon(
            Icons.refresh,
            color: kPrimaryColor,
          ),
          mini: true,
        ),
      ),
    );

  }
}