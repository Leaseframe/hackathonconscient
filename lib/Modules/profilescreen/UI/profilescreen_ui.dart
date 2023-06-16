import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetbook/Modules/profilescreen/Classes/profilescreen_class.dart';
import 'package:meetbook/Modules/widgets/card_item_profile.dart';
import 'package:meetbook/Modules/widgets/divider_line.dart';
import 'package:meetbook/Modules/widgets/text_custom.dart';

class ProfileScreenUI extends GetView<ProfileScreenClass>{
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return ListView(
      padding: const EdgeInsets.only(top: 35.0, bottom: 20.0),
      children: [
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
                text: 'Information Personnelle', 
                borderRadius: BorderRadius.circular(50.0),
                icon: Icons.person_outline_rounded,
                backgroundColor: const Color(0xff7882ff),
                onPressed: () {

                },
              ),
              DividerLine(size: size),
              CardItemProfile(
                text: 'Mes Rendez-vous', 
                borderRadius: BorderRadius.circular(50.0),
                icon: Icons.calendar_month,
                backgroundColor: const Color(0xffFFCD3A),
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
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: TextCustom(text: 'Générale', fontSize: 17, color: Colors.grey,),
        ),
        const SizedBox(height: 10.0),
        Container(
          height: 153,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0)
          ),
          child: Column(
            children: [
                CardItemProfile(
                  text: 'Changer mon mail', 
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30.0)),
                  backgroundColor: const Color(0xff2EAA9B),
                  icon: Icons.mail,
                  onPressed: (){
                    Get.bottomSheet(
                                          Container(
                                            height: 380,
                                            child: Column(
                                              children: [
                                                const Center(
                                                  child: Padding(
                                                    padding: EdgeInsets.all(20.0),
                                                    child: Text(
                                                      "Modification votre mail",
                                                      style: TextStyle(fontSize: 20,color: Color(0xff1E1C61), fontWeight: FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(10),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.white,
                                                    ),
                                                    padding: const EdgeInsets.all(5),
                                                    width: Get.width * 2,
                                                    margin: const EdgeInsets.only(left: 5,right: 5),
                                                    child: Form(
                                                      key: controller.keyChangeMail,
                                                      child: Column(
                                                        children: <Widget>[
                                                
                                                            Column(
                                                              children: [
                                                                Container(
                                                                  padding: const EdgeInsets.only(left: 30),
                                                                  child: const Row(
                                                                    children: [
                                                                      Text(
                                                                          "Email",
                                                                          style: TextStyle(fontSize: 20,color: Color(0xFF929395), fontWeight: FontWeight.bold),
                                                                        ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                const SizedBox(height: 10,),
                                                                Container(
                                                                  margin: const EdgeInsets.only(left: 23,right: 23),
                                                                  child: Material(
                                                                    elevation: 10.0,
                                                                    color: Colors.white,
                                                                    borderRadius: BorderRadius.circular(30.0),
                                                                    child: TextFormField(
                                                                      controller: controller.email_field,
                                                                      validator: (value) {
                                                                        String pattern =
                                                                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                                                        RegExp regex = RegExp(pattern);
                                                                        if (value!.isEmpty) {
                                                                          return 'Veuillez remplir ce champ';
                                                                        } else if(!regex.hasMatch(value)) {
                                                                          return 'Email invalide';
                                                                        }
                                                                        else{
                                                                          return null;
                                                                        }
                                                                      },
                                                                      keyboardType: TextInputType.number,
                                                                      decoration: InputDecoration(
                                                                        border:
                                                                        const OutlineInputBorder(borderSide: BorderSide.none),
                                                                        contentPadding: EdgeInsets.symmetric(
                                                                            vertical: 20 * 0.75,
                                                                            horizontal:20),
                                                                        fillColor: Colors.white,
                                                                        hintText: "Ex : example@gmail.com",
                                                                        suffixIcon: Icon(
                                                                          Icons.phone,
                                                                          size: 25.0,
                                                                          color: Colors.black.withOpacity(0.4),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),    
                                                          SizedBox(
                                                              height: Get.height * 0.02,
                                                            ),
                                                            MaterialButton(
                                                              onPressed: (){
                                                                //controller.ChangeMails();
                                                              },
                                                              color: Color(0xFF25257E),
                                                              child: Text(
                                                                  "Modifier",
                                                                style: Theme.of(context).textTheme.button!.copyWith(
                                                                  color: Colors.white
                                                                ),
                                                              ),
                                                            )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          persistent: true,
                                          isDismissible: false,
                                          isScrollControlled: true,
                                          enableDrag: false,
                                          backgroundColor: Colors.white,
                                          elevation: 1,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                    );
                  },
                ),
                DividerLine(size: size),
                CardItemProfile(
                  text: 'Changer de mot de passe',
                  borderRadius: BorderRadius.zero,
                  backgroundColor: const Color(0xffE87092),
                  icon: Icons.security,
                  onPressed: () {},
                ),
                DividerLine(size: size),
            ],
          ),
        ),
        const SizedBox(height: 15.0),
        const Padding(
          padding: EdgeInsets.only(left: 25.0),
          child: TextCustom(text: 'Personelle', fontSize: 17, color: Colors.grey,),
        ),
        const SizedBox(height: 10.0),
        Container(
          height: 320,
          width: size.width,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0)
          ),
          child: Column(
            children: [
                
                DividerLine(size: size),
                CardItemProfile(
                  text: 'Aide',
                  backgroundColor: const Color(0xff4772e6),
                  icon: Icons.help_outline,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30.0)),
                  onPressed: (){},
                ),
                DividerLine(size: size),
                CardItemProfile(
                  text: 'A propos de nous',
                  backgroundColor: const Color.fromARGB(255, 230, 95, 71),
                  icon: Icons.info_outline_rounded,
                  borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30.0)),
                  onPressed: (){},
                ),

            ],
          ),
        ),
        const SizedBox(height: 25.0),
        CardItemProfile(
          text: 'Déconnexion', 
          borderRadius: BorderRadius.circular(50.0),
          icon: Icons.power_settings_new_sharp,
          backgroundColor: Colors.red,
          onPressed: () {},
        ),
      ],
    );
  }

}