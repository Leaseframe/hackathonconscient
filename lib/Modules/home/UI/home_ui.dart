import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meetbook/Config/Api/my_api.dart';
import 'package:meetbook/Config/palette/palette.dart';
import 'package:meetbook/Modules/widgets/discount_banner.dart';
import 'package:meetbook/Modules/widgets/nav_bars.dart';
import 'package:meetbook/Modules/widgets/shimmer_meet.dart';
// import 'package:meetbook/Modules/widgets/shimmer_meet.dart';
import 'package:meetbook/Modules/widgets/text_custom.dart';
import 'package:http/http.dart' as http;

class HomeUI extends StatefulWidget {
  const HomeUI({super.key});

  @override
  State<HomeUI> createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {

  final rdvKey = GlobalKey<FormState>();
  TextEditingController dateDeb= TextEditingController();
  TextEditingController heures = TextEditingController();
  TextEditingController dateFin = TextEditingController();
  TextEditingController heures_fin = TextEditingController();

  final local = GetStorage();
  
  List DataCreneau = [];

  Future<bool> infoCreneau() async {

    var res = await CallApi().getDatas('getCreneau.php');

      if(res.statusCode == 200){

        var dataRespCa = jsonDecode(res.body);

        DataCreneau = dataRespCa;

      }
      else
      {
        DataCreneau = [];
      }

    return Future.value(true);
  }

  Rdv_send(creneau_id) async {
    if(rdvKey.currentState!.validate())
    { 
      showLoading();

      var users_id = local.read("user_id_connect");

      var data = {"dateDeb": dateDeb.text,"heureDeb": heures.text,"dateFin":dateFin.text,"heurFin":heures_fin.text,"users_id":users_id,"creneau_id":creneau_id};
      Uri url  = Uri.parse("https://www.leaseframe.com/hackathon/add_rdv.php");
      var resp = await http.post(url , body: data);
      var respbody = jsonDecode(resp.body);

      if(respbody['status'] == 'success')
      {
        hideLoading();
        Get.back();
        showErrorDialog(description: "Votre Rendez-vous est en attente de confirmation. Veuillez consculter la liste de vos RDV!");
      }
      else
      {
        hideLoading();
        showErrorDialog(description: "Désolé une erreur technique est survenue réessayer svp!");
      }
    }
  }

  showLoading({String title = "Encours de traitement...."}) {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            height: 40,
            child: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
                const SizedBox(
                  width: 20,
                ),
                Text(
                  title,
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  hideLoading(){
    Get.back();
    if(Get.isBottomSheetOpen!)
    {
      Get.back();
    }
  }

  showErrorDialog({String title = "Oops Error",String description = "Veuillez saisir vos identifiants"}) {
    Get.dialog(
      Dialog(
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: Get.textTheme.headline6,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () {
                  if (Get.isDialogOpen!) Get.back();
                },
                child: const Text("Ok"),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
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
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/images/RDV3.png",
                        ),
                        alignment: Alignment.topCenter,
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 5.0),
              const DiscountBanner(),
              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left:8.0),
                    child: TextCustom(text: 'Créneaux disponibles', fontSize: 14, fontWeight: FontWeight.w600,),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: const Row(
                      children: [
                        // TextCustom(text: 'Voir tout', fontSize: 14 ),
                        SizedBox(width: 5.0),
                        Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xff006CF2))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0,),
              Container(
                height: 130,
                child: FutureBuilder(
                    future: infoCreneau(),
                    builder: (context, snapshot) {
                      return !snapshot.hasData
                      ? const Column(
                          children: [
                            ShimmerMeetBook(),
                            SizedBox(height: 10.0),
                            ShimmerMeetBook(),
                            SizedBox(height: 10.0),
                          ],
                        )
                      : ListView.builder(
                        itemCount: DataCreneau.length,
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        itemBuilder: (context,index){
                          return Row(
                            children: [
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(25),
                                    bottomRight: Radius.circular(25),
                                    bottomLeft: Radius.circular(25),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: getProportionateScreenWidth(5)),
                                  child: SizedBox(
                                    width: getProportionateScreenWidth(120),
                                    child: GestureDetector(
                                      onTap: () {
                                        Get.bottomSheet(
                                                    Container(
                                                      height: 450,
                                                      child: Column(
                                                        children: [
                                                          const Center(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(20.0),
                                                              child: Text(
                                                                "Prise de RDV",
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
                                                                key: rdvKey,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                      
                                                                      Material(
                                                                              elevation: 10.0,
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                              child: TextFormField(
                                                                                controller: dateDeb,
                                                                                validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
                                                                                keyboardType: TextInputType.text,
                                                                                decoration: InputDecoration(
                                                                                  border:
                                                                                  const OutlineInputBorder(borderSide: BorderSide.none),
                                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                                      vertical: 20 * 0.75,
                                                                                      horizontal: 20),
                                                                                  fillColor: Colors.white,
                                                                                  hintText: 'Ex : 2023-06-16',
                                                                                  suffixIcon: Icon(
                                                                                    Icons.calendar_month,
                                                                                    size: 25.0,
                                                                                    color: Colors.black.withOpacity(0.4),
                                                                                  ),
                                                                                  labelText: "Date début"
                                                                                ),
                                                                              ),
                                                                            ),
                                                                      SizedBox(height: 10,),
                                                                      Material(
                                                                              elevation: 10.0,
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                              child: TextFormField(
                                                                                controller: heures,
                                                                                validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
                                                                                keyboardType: TextInputType.text,
                                                                                decoration: InputDecoration(
                                                                                  border:
                                                                                  const OutlineInputBorder(borderSide: BorderSide.none),
                                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                                      vertical: 20 * 0.75,
                                                                                      horizontal: 20),
                                                                                  fillColor: Colors.white,
                                                                                  hintText: 'Ex : 12h-30',
                                                                                  suffixIcon: Icon(
                                                                                    Icons.lock_clock,
                                                                                    size: 25.0,
                                                                                    color: Colors.black.withOpacity(0.4),
                                                                                  ),
                                                                                  labelText: "Heure début"
                                                                                ),
                                                                              ),
                                                                            ), 
                                                                            SizedBox(height: 10,),  
                                                                    Material(
                                                                              elevation: 10.0,
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                              child: TextFormField(
                                                                                controller: dateFin,
                                                                                validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
                                                                                keyboardType: TextInputType.text,
                                                                                decoration: InputDecoration(
                                                                                  border:
                                                                                  const OutlineInputBorder(borderSide: BorderSide.none),
                                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                                      vertical: 20 * 0.75,
                                                                                      horizontal: 20),
                                                                                  fillColor: Colors.white,
                                                                                  hintText: 'Ex : 2023-06-19',
                                                                                  suffixIcon: Icon(
                                                                                    Icons.calendar_month,
                                                                                    size: 25.0,
                                                                                    color: Colors.black.withOpacity(0.4),
                                                                                  ),
                                                                                  labelText: "Date Fin"
                                                                                ),
                                                                              ),
                                                                            ),
                                                                      SizedBox(height: 10,),
                                                                      Material(
                                                                              elevation: 10.0,
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                              child: TextFormField(
                                                                                controller: heures_fin,
                                                                                validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
                                                                                keyboardType: TextInputType.text,
                                                                                decoration: InputDecoration(
                                                                                  border:
                                                                                  const OutlineInputBorder(borderSide: BorderSide.none),
                                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                                      vertical: 20 * 0.75,
                                                                                      horizontal: 20),
                                                                                  fillColor: Colors.white,
                                                                                  hintText: 'Ex : 18h-30',
                                                                                  suffixIcon: Icon(
                                                                                    Icons.lock_clock,
                                                                                    size: 25.0,
                                                                                    color: Colors.black.withOpacity(0.4),
                                                                                  ),
                                                                                  labelText: "Heure Fin"
                                                                                ),
                                                                              ),
                                                                            ),
                                                                        
                                                                      SizedBox(height: 20,),
                                                                      MaterialButton(
                                                                        onPressed: (){
                                                                          Rdv_send(DataCreneau[index]['id_creneau']);
                                                                        },
                                                                        color: Color(0xFF25257E),
                                                                        child: Text(
                                                                            "Prendre RDV",
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
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 2.5,
                                            child: Container(
                                              padding: EdgeInsets.all(getProportionateScreenWidth(10)),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF979797).withOpacity(0.1),
                                                borderRadius: BorderRadius.circular(15),
                                              ),
                                              child: const Icon(
                                                Icons.calendar_today,
                                                size: 30,
                                              )
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            DataCreneau[index]['date_creneau'],
                                            style: TextStyle(color: Colors.black),
                                            maxLines: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 0),
                                            child: ElevatedButton.icon(
                                              onPressed: () {
                                                 Get.bottomSheet(
                                                    Container(
                                                      height: 450,
                                                      child: Column(
                                                        children: [
                                                          const Center(
                                                            child: Padding(
                                                              padding: EdgeInsets.all(20.0),
                                                              child: Text(
                                                                "Prise de RDV",
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
                                                                key: rdvKey,
                                                                child: Column(
                                                                  children: <Widget>[
                                                                      
                                                                      Material(
                                                                              elevation: 10.0,
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                              child: TextFormField(
                                                                                controller: dateDeb,
                                                                                validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
                                                                                keyboardType: TextInputType.text,
                                                                                decoration: InputDecoration(
                                                                                  border:
                                                                                  const OutlineInputBorder(borderSide: BorderSide.none),
                                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                                      vertical: 20 * 0.75,
                                                                                      horizontal: 20),
                                                                                  fillColor: Colors.white,
                                                                                  hintText: 'Ex : 2023-06-16',
                                                                                  suffixIcon: Icon(
                                                                                    Icons.calendar_month,
                                                                                    size: 25.0,
                                                                                    color: Colors.black.withOpacity(0.4),
                                                                                  ),
                                                                                  labelText: "Date début"
                                                                                ),
                                                                              ),
                                                                            ),
                                                                      SizedBox(height: 10,),
                                                                      Material(
                                                                              elevation: 10.0,
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                              child: TextFormField(
                                                                                controller: heures,
                                                                                validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
                                                                                keyboardType: TextInputType.text,
                                                                                decoration: InputDecoration(
                                                                                  border:
                                                                                  const OutlineInputBorder(borderSide: BorderSide.none),
                                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                                      vertical: 20 * 0.75,
                                                                                      horizontal: 20),
                                                                                  fillColor: Colors.white,
                                                                                  hintText: 'Ex : 12h-30',
                                                                                  suffixIcon: Icon(
                                                                                    Icons.lock_clock,
                                                                                    size: 25.0,
                                                                                    color: Colors.black.withOpacity(0.4),
                                                                                  ),
                                                                                  labelText: "Heure début"
                                                                                ),
                                                                              ),
                                                                            ),   
                                                                            SizedBox(height: 10,),
                                                                    Material(
                                                                              elevation: 10.0,
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                              child: TextFormField(
                                                                                controller: dateFin,
                                                                                validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
                                                                                keyboardType: TextInputType.text,
                                                                                decoration: InputDecoration(
                                                                                  border:
                                                                                  const OutlineInputBorder(borderSide: BorderSide.none),
                                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                                      vertical: 20 * 0.75,
                                                                                      horizontal: 20),
                                                                                  fillColor: Colors.white,
                                                                                  hintText: 'Ex : 2023-06-19',
                                                                                  suffixIcon: Icon(
                                                                                    Icons.calendar_month,
                                                                                    size: 25.0,
                                                                                    color: Colors.black.withOpacity(0.4),
                                                                                  ),
                                                                                  labelText: "Date Fin"
                                                                                ),
                                                                              ),
                                                                            ),
                                                                      SizedBox(height: 10,),
                                                                      Material(
                                                                              elevation: 10.0,
                                                                              color: Colors.white,
                                                                              borderRadius: BorderRadius.circular(30.0),
                                                                              child: TextFormField(
                                                                                controller: heures_fin,
                                                                                validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
                                                                                keyboardType: TextInputType.text,
                                                                                decoration: InputDecoration(
                                                                                  border:
                                                                                  const OutlineInputBorder(borderSide: BorderSide.none),
                                                                                  contentPadding: const EdgeInsets.symmetric(
                                                                                      vertical: 20 * 0.75,
                                                                                      horizontal: 20),
                                                                                  fillColor: Colors.white,
                                                                                  hintText: 'Ex : 18h-30',
                                                                                  suffixIcon: Icon(
                                                                                    Icons.lock_clock,
                                                                                    size: 25.0,
                                                                                    color: Colors.black.withOpacity(0.4),
                                                                                  ),
                                                                                  labelText: "Heure Fin"
                                                                                ),
                                                                              ),
                                                                            ),
                                                                        
                                                                      SizedBox(height: 20,),
                                                                      MaterialButton(
                                                                        onPressed: (){
                                                                          Rdv_send(DataCreneau[index]['id_creneau']);
                                                                        },
                                                                        color: Color(0xFF25257E),
                                                                        child: Text(
                                                                            "Prendre RDV",
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
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: const Color.fromARGB(255, 170, 14, 3),
                                                minimumSize: const Size(double.infinity, 30),
                                                shape: const RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(25),
                                                    bottomRight: Radius.circular(25),
                                                    bottomLeft: Radius.circular(25),
                                                  ),
                                                ),
                                              ),
                                              icon: const Icon(
                                                Icons.calendar_today,
                                                color: Colors.white,
                                              ),
                                              label: Text(DataCreneau[index]['heure_creneau'],style: TextStyle(color: Colors.white),),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: getProportionateScreenWidth(10)),
                            ],
                          );
                        }
                      );
                    },
                  ) 
              ),

              const SizedBox(height: 5.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left:8.0),
                    child: TextCustom(text: 'Rendez-vous A venir', fontSize: 14, fontWeight: FontWeight.w600,),
                  ),
                  GestureDetector(
                    onTap: () {

                    },
                    child: const Row(
                      children: [
                        // TextCustom(text: 'Voir tout', fontSize: 14 ),
                        SizedBox(width: 5.0),
                        Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Color(0xff006CF2))
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
                            
            ],
          )
        ),
      )
    );
  }
}