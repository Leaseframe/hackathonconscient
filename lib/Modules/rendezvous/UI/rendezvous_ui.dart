import 'dart:convert';

import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetbook/Config/Api/my_api.dart';
import 'package:meetbook/Config/Utils/values.dart';
import 'package:meetbook/Modules/rendezvous/Classes/rendezvous_class.dart';
import 'package:meetbook/Modules/widgets/custom_button.dart';
import 'package:meetbook/Modules/widgets/nav_bars.dart';
import 'package:meetbook/Modules/widgets/spaces.dart';

class RendezvousUI extends StatefulWidget {
  const RendezvousUI({super.key});

  @override
  State<RendezvousUI> createState() => _RendezvousUIState();
}

class _RendezvousUIState extends State<RendezvousUI> with SingleTickerProviderStateMixin {
  RendezvousClass controller = RendezvousClass();
  final formKey = GlobalKey<FormState>();
  TextEditingController name_field = TextEditingController();
  TextEditingController tel_field = TextEditingController();
  TextEditingController mdp_field = TextEditingController();
  TextEditingController mdpConf_field = TextEditingController();

  late TextEditingController _applyleavecontroller;
  String applyleavevalue_Changed = '';
  String applyleavevalueTo_Validate = '';
  String applyleavevalue_Saved = '';

  late Animation animation, delayedAnimation, muchDelayedAnimation, LeftCurve;
  late AnimationController animationController;

  List prodList = [];
  String? myProd;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //SystemChrome.setEnabledSystemUIOverlays([]);
    _applyleavecontroller =
        TextEditingController(text: DateTime.now().toString());

    animationController =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastOutSlowIn));

    delayedAnimation = Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.2, 0.5, curve: Curves.fastOutSlowIn)));

    muchDelayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController,
        curve: Interval(0.3, 0.5, curve: Curves.fastOutSlowIn)));

    
  }

  @override
  void didChangeDependencies() async {

    infoCreneau();

    super.didChangeDependencies();
  }

  infoCreneau() async {

    var res = await CallApi().getDatas('getCreneau.php');

    if(res.statusCode == 200){

      var resData = jsonDecode(res.body);

      prodList = resData;

      print(prodList);

    }
    else
    {
      prodList = [];
    }

  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  } 

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
      body: SafeArea(
        child: Container(
          child: ListView(
            children: <Widget>[
              Container(
                height: Get.height * 0.9,
                child: Form(
                      key: formKey,
                      child: Container(
                        height: Get.height * 0.9,
                        color: Colors.white,
                        child: ListView(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
                          children: [
                            Material(
                                  elevation: 10.0,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.0),
                                  child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                        value: myProd,
                                        iconSize: 30,
                                        icon: (null),
                                        style: const TextStyle(
                                          color: Colors.black54,
                                          fontSize: 16,
                                        ),
                                        hint: const Text('Sélèctionner un créneau'),
                                        onChanged: (String? newValu) {
                                          setState(() {
                                            myProd = newValu;
                                          });
                                        },
                                        items: prodList.map((item) {
                                              return DropdownMenuItem(
                                                child: Text(item['heure_creneau']),
                                                value: item['heure_creneau'].toString(),
                                              );
                                          }).toList(),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 40,),
                            Padding(
                              padding: const EdgeInsets.only(top: 13,),
                              child: Container(
                              padding: const EdgeInsets.only(
                                left: 10,
                              ),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Row(
                                children: [
                                  Transform(
                                    transform: Matrix4.translationValues(
                                    muchDelayedAnimation.value * Get.width, 0, 0),
                                    child: Container(
                                      width: Get.width * 0.75,
                                      child: DateTimePicker(
                                        type: DateTimePickerType.date,
                                        dateMask: 'dd/MM/yyyy',
                                        controller: _applyleavecontroller,
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                        calendarTitle: "Date du Viol",
                                        confirmText: "Confirmer",
                                        enableSuggestions: true,
                                        onChanged: (val) => setState(() => applyleavevalue_Changed = val),
                                        validator: (val) {
                                        setState(() => applyleavevalueTo_Validate = val!);
                                          return null;
                                        },
                                        onSaved: (val) => setState(() => applyleavevalue_Saved = val!),
                                      ),
                                    ),
                                  ),
                                  Transform(
                                    transform: Matrix4.translationValues(
                                        delayedAnimation.value * Get.width, 0, 0),
                                      child: const Icon(
                                        Icons.calendar_today,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            SpaceH16(),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_48),
                              child: CustomButton(
                                title:"Vérifier",
                                textStyle: TextStyle(
                                  color: Colors.white
                                ),
                                onPressed: (){
                                  
                                },
                              ),
                            ),
                            SpaceH16(),
                          ],
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}