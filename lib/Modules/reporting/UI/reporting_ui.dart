import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetbook/Modules/reporting/Classes/reporting_class.dart';
import 'package:meetbook/Modules/widgets/identity_card.dart';
import 'package:meetbook/Modules/widgets/nav_bars.dart';
import 'package:meetbook/Modules/widgets/shimmer_meet.dart';

class ReportingUI extends GetView<ReportingClass>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      drawer: const NavBars(),
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 15.0,
                backgroundColor: const Color.fromARGB(255, 236, 236, 236),
                child: CircleAvatar(
                  radius: 20.0,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: const AssetImage("assets/images/paf.jpg"),
                ),
              ),
            ),
            const Text(
              "MeetBook",
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications,
              size: 20,
              color: Colors.white,
            ),
            onPressed: () async {
             
            }
          ),
          const SizedBox(width: 10,),
        ],
        backgroundColor: Color.fromARGB(255, 221, 65, 3),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: Get.height *0.6,
                child: FutureBuilder(
                    future: controller.infoRDV(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                      ? const Column(
                          children: [
                            ShimmerMeetBook(),
                            SizedBox(height: 10.0),
                            ShimmerMeetBook(),
                            SizedBox(height: 10.0),
                            ShimmerMeetBook(),
                            SizedBox(height: 10.0),
                          ],
                        )
                      : ListView.builder(
                        itemCount: controller.DataRdv.length,
                        scrollDirection: Axis.vertical,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        itemBuilder: (context,index){
                          return IdentityCard(
                              number: 1,
                              title: "Du ${controller.DataRdv[index]['date_debut']} au ${controller.DataRdv[index]['date_fin']}",
                              body: "Heure début : ${controller.DataRdv[index]['heure_debut']} , Heure fin : ${controller.DataRdv[index]['heure_fin']}",
                              //hasRecommended: true,
                          );
                        }
                      );
                    },
                  ) 
              ),
            ],
          )
        ),
      )
    );
  }

  
}