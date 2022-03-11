import 'package:firebase_login/constraints.dart';
import 'package:firebase_login/models/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pie_chart/pie_chart.dart';
import '../../../constraints.dart';


class UserProfile extends StatelessWidget {
  final User user;
  // Map<String, double> dataMap = {
  //   "Flutter": 5,
  //   "React": 3,
  //   "Xamarin": 2,
  //   "Ionic": 2,
  // };

  UserProfile(this.user);

  Map<String,double> upDataMap ()
  {
    Map<String,double> tmpData = Map();
    Map<String,dynamic> dataMap = user.appUsageMaps;
    dataMap.forEach((key, value) {
      tmpData[key] = value[0] + (value[1]/60);
    });
    return tmpData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('User Profile'),
        backgroundColor: kPrimaryLightColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 85,
                  backgroundColor: Color.fromRGBO(17, 0, 255, 1),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(user.image),
                  ),
                ),
//                Container(
//                  width: 160,
//                  height: 160,
//                  padding: EdgeInsets.all(2.0),    //border radius
//                  child: CircleAvatar(
//                    backgroundImage: NetworkImage(user.image),
//                  ),
//                  decoration: BoxDecoration(
//                    color: Colors.amber,       //border color
//                    shape: BoxShape.circle,
//                  ),
//                ),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  child: Card(
                    color: kPrimaryLightColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'NAME',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            user.name,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    elevation: 8,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    color: kPrimaryLightColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'CONTACT DETAILS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          CardRow(user.phone, Icons.phone),
                          CardRow(user.email, Icons.email),
                          CardRow(user.address, Icons.location_on),
                        ],
                      ),
                    ),
                    elevation: 8,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    color: kPrimaryLightColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'PERSONAL DETAILS',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          CardRow(user.date, Icons.cake),
                          CardRow(user.age.toString(), Icons.person_outline),
                        ],
                      ),
                    ),
                    elevation: 8,
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Card(
                    color: kPrimaryLightColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: PieChart(

                        dataMap: upDataMap (),
                        chartType: ChartType.ring,
                        legendOptions: LegendOptions(
                          legendTextStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          ),
                        ),
                      ),
                    ),
                    elevation: 8,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class CardRow extends StatelessWidget {
  final String content;
  final IconData icon;

  CardRow(
      this.content,
      this.icon,
      );


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: <Widget>[
          Icon(icon, size: 32,color: Colors.grey,),
          SizedBox(width: 12,),
          Flexible(
            child: Text(
              content,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
