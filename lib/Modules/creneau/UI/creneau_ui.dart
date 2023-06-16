import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:meetbook/Modules/creneau/Classes/creneau_class.dart';
import 'package:meetbook/Modules/widgets/nav_bars.dart';

class CreneauUI extends GetView<CreneauClass>{
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
      body: Center(
        child: Text("Créneau")
      ),
    );
  }

}