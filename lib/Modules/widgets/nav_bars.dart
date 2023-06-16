import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetbook/Modules/widgets/card_item_profile.dart';
import 'package:meetbook/Modules/widgets/divider_line.dart';

class NavBars extends StatelessWidget {
  const NavBars({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text(
              "MeetBook",
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic
              ),
            ), 
            accountEmail: const Text(
              "service.meetbook@gmail.com",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic
              ),
            ),
            currentAccountPicture: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 50.0,
                backgroundColor: const Color.fromARGB(255, 236, 236, 236),
                child: CircleAvatar(
                  radius: 40.0,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: const AssetImage("assets/images/paf.jpg"),
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 170, 14, 3),
              image: DecorationImage(
                image: AssetImage("assets/images/passport.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                height: 250,
                width: Get.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.0)
                ),
                child: Column(
                  children: [
                    CardItemProfile(
                      text: 'Mes RDV', 
                      borderRadius: BorderRadius.circular(50.0),
                      icon: Icons.calendar_month,
                      backgroundColor: Color(0xffFFCD3A),
                      onPressed: () => {

                      },
                    ),
                    DividerLine(size: size),
                    CardItemProfile(
                      text: 'Reporting', 
                      borderRadius: BorderRadius.circular(50.0),
                      icon: Icons.report,
                      backgroundColor: const Color(0xffFFCD3A),
                      onPressed: () => {

                      },
                    ),
                    DividerLine(size: size),
                    CardItemProfile(
                      text: 'Créneaux', 
                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30.0)),
                      icon: Icons.calendar_today,
                      backgroundColor: const Color(0xff02406F),
                      onPressed: () {

                      },
                    ),
                    CardItemProfile(
                      text: 'Partager', 
                      borderRadius: BorderRadius.circular(50.0),
                      icon: Icons.share,
                      backgroundColor: Color(0xffFFCD3A),
                      onPressed: () => {

                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5.0),
              CardItemProfile(
                text: 'Déconnexion', 
                borderRadius: BorderRadius.circular(50.0),
                icon: Icons.power_settings_new_sharp,
                backgroundColor: Colors.red,
                onPressed: () {},
              ),
              const SizedBox(
                height: 5,
              ),
              Material(
                borderRadius: BorderRadius.circular(500),
                child: InkWell(
                  borderRadius: BorderRadius.circular(500),
                  splashColor: Colors.black45,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.arrow_back, color: Colors.white),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'v1.0.1',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        fontSize: 20,
                        color: Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}