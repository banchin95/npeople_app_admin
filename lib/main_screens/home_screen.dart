import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olkdelivery_admin_web_portal/riders/all_blocked_riders_screen.dart';
import 'package:olkdelivery_admin_web_portal/riders/all_verified_riders_screen.dart';
import 'package:olkdelivery_admin_web_portal/sellers/all_blocked_sellers_screen.dart';
import 'package:olkdelivery_admin_web_portal/sellers/all_verified_sellers_screen.dart';
import '../authentication/login_screen.dart';
import '../users/all_blocked_users_screen.dart';
import '../users/all_verified_users_screen.dart';



class HomeScreen extends StatefulWidget
{
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen>
{
  String timeText = "";
  String dateText = "";


  String formatCurrentLiveTime(DateTime time)
  {
    return DateFormat("hh:mm:ss a").format(time);
  }

  String formatCurrentDate(DateTime date)
  {
    return DateFormat("dd MMMM, yyyy").format(date);
  }

  getCurrentLiveTime()
  {
    final DateTime timeNow = DateTime.now();
    final String liveTime = formatCurrentLiveTime(timeNow);
    final String liveDate = formatCurrentDate(timeNow);

    if(this.mounted)
    {
      setState(() {
        timeText = liveTime;
        dateText = liveDate;
      });
    }
  }

  @override
  void initState()
  {
    super.initState();

    //time
    timeText = formatCurrentLiveTime(DateTime.now());

    //date
    dateText = formatCurrentDate(DateTime.now());

    Timer.periodic(const Duration(seconds: 1), (timer)
    {
      getCurrentLiveTime();
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors:
              [
                Colors.blueGrey,
                Colors.blue,
              ],
              begin: FractionalOffset(0, 0),
              end: FractionalOffset(1, 0),
              stops: [0, 1],
              tileMode: TileMode.clamp,
            ),
          ),
        ),
        title: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: <TextSpan>
            [
              TextSpan(text: "OLK", style: TextStyle(color: Colors.white, fontSize: 25,fontFamily: "Righteous", letterSpacing: 3, fontWeight: FontWeight.bold,),),
              TextSpan(text: "DELIVERY", style: TextStyle(color: Colors.orange, fontSize: 25,fontFamily: "Righteous", letterSpacing: 3, fontWeight: FontWeight.bold,),),
              TextSpan(text: " \nADMIN", style: TextStyle(color: Colors.yellowAccent, fontSize: 25,fontFamily: "Righteous", letterSpacing: 3, fontWeight: FontWeight.bold,),),
            ]
          ),
        )
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                timeText + "\n" + dateText,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //users activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add, color: Colors.white, size: 20,),
                  label: Text(
                    "Проверенные пользователи".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                      fontFamily: "Jost",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    primary: Colors.green,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllVerifiedUsersScreen()));
                  },
                ),

                const SizedBox(width: 20,),

                //block
                ElevatedButton.icon(
                  icon: const Icon(Icons.block_flipped, color: Colors.white,),
                  label: Text(
                    "Заблокированные пользователи".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                      fontFamily: "Jost",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    primary: Colors.redAccent,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllBlockedUsersScreen()));
                  },
                ),
              ],
            ),

            //sellers activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add, color: Colors.white,),
                  label: Text(
                    "Проверенные продавцы".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                      fontFamily: "Jost",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    primary: Colors.green,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllVerifiedSellersScreen()));
                  },
                ),

                const SizedBox(width: 20,),

                //block
                ElevatedButton.icon(
                  icon: const Icon(Icons.block_flipped, color: Colors.white,),
                  label: Text(
                    "Заблокированные продавцы".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                      fontFamily: "Jost",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    primary: Colors.redAccent,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllBlockedSellersScreen()));
                  },
                ),
              ],
            ),

            //riders activate and block accounts button ui
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //active
                ElevatedButton.icon(
                  icon: const Icon(Icons.person_add, color: Colors.white,),
                  label: Text(
                    "Проверенные курьеры".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                      fontFamily: "Jost",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    primary: Colors.green,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllVerifiedRidersScreen()));
                  },
                ),

                const SizedBox(width: 20,),

                //block
                ElevatedButton.icon(
                  icon: const Icon(Icons.block_flipped, color: Colors.white,),
                  label: Text(
                    "Заблокированные курьеры".toUpperCase(),
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      letterSpacing: 3,
                      fontFamily: "Jost",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(40),
                    primary: Colors.redAccent,
                  ),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (c)=> const AllBlockedRidersScreen()));
                  },
                ),
              ],
            ),

            //logout button
            ElevatedButton.icon(
              icon: const Icon(Icons.logout, color: Colors.white,),
              label: Text(
                "Выйти".toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  letterSpacing: 3,
                  fontFamily: "Jost",
                ),
              ),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(40),
                primary: Colors.blueGrey,
              ),
              onPressed: ()
              {
                FirebaseAuth.instance.signOut();
                Navigator.push(context, MaterialPageRoute(builder: (c)=> const LoginScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
