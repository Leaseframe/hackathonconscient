
import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetbook/Config/Utils/values.dart';
import 'package:meetbook/Modules/finalisationcode/Classes/finalisation_class.dart';
import 'package:meetbook/Modules/widgets/custom_button.dart';
import 'package:meetbook/Modules/widgets/spaces.dart';
import 'package:meetbook/Modules/widgets/text_field_frave.dart';
import 'package:http/http.dart' as http;
import 'package:meetbook/Rootes/root_page.dart';
import 'package:path_provider/path_provider.dart';

class FinalisationUI extends StatefulWidget {
  const FinalisationUI({super.key});

  @override
  State<FinalisationUI> createState() => _FinalisationUIState();
}

class _FinalisationUIState extends State<FinalisationUI> {
  FinalisationClass controller = FinalisationClass();

  List roleList = [
    "client",
    "administrateur",
    "employé"
  ];
  String? roles;

  final formKey = GlobalKey<FormState>();
  TextEditingController name_field = TextEditingController();
  TextEditingController tel_field = TextEditingController();
  TextEditingController mdp_field = TextEditingController();
  TextEditingController mdpConf_field = TextEditingController();

  File? fichiers2 ;

  Future getFile2() async {

    FilePickerResult? result_file2 = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ["jpg","jpeg","gif","png","JPG","JPEG","GIF","PNG"],
    );

    if (result_file2 != null) {

      showLoading();
      
      PlatformFile files2 = result_file2.files.first;

      fichiers2 = await saveFilePermanently2(files2);

      Future.delayed(Duration(milliseconds: 2000), () {
          hideLoading();
          showErrorDialog(title: "Success!", description: "Photo de profile Téléchargée avec succèss !");
      });

    } else {
      return ;
    } 
  }

  Future<File> saveFilePermanently2(PlatformFile file2) async {
    final appStorage_2 = await getApplicationDocumentsDirectory();
    final newFile2 = File('${appStorage_2.path}/${file2.name}');
    return File(file2.path!).copy(newFile2.path);
  }

  Finaliser(id_users,files) async {

    if(formKey.currentState!.validate() && files != null)
    { 
      showLoading();

      String base64_file2 = base64Encode(fichiers2!.readAsBytesSync());
      String fichierName2 = fichiers2!.path.split('/').last;

      var data = {"name_field": name_field.text,"tel_field": tel_field.text,"mdp_field": mdp_field.text,"mdpConf_field": mdpConf_field.text,'id_user':id_users,"roles":roles,"images_user" : fichierName2, "file64_file" : base64_file2};
      Uri url  = Uri.parse("https://www.leaseframe.com/hackathon/finalisationcompte.php");
      var resp = await http.post(url , body: data);
      var respbody = jsonDecode(resp.body);

      if(respbody['status'] == 'success')
      {

        Future.delayed(const Duration(milliseconds: 2000),(){
            hideLoading();
            controller.local.write("user_id_connect", id_users);
            Get.offAllNamed(Routes.WELCOME);
        });

      }
      else if(respbody['status'] == 'err_mdp')
      {
        hideLoading();
        showErrorDialog(description: "Désolé les deux mot de passe ne concordent pas!");       
      }
      else
      {
        hideLoading();
        showErrorDialog(description: "Désolé une erreur technique est survenue lors de la connexion réessayer svp!");
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
    var data = Get.arguments;
    final DataDoc  = data;

    return Scaffold(
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
                            
                            GestureDetector(
                              onTap: getFile2,
                              child: Container(
                                height: 190,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  color: Color(0xfff3f3f3),
                                  borderRadius: BorderRadius.circular(12.0)
                                ),
                                child: const Icon(Icons.wallpaper_rounded, size: 80),
                              ),
                            ),
                                          
                            const SizedBox(height: 20.0),
                            TextFormFrave(
                              controller: name_field, 
                              prefixIcon: const Icon(Icons.add),
                              hintText: 'Name Complet',
                              keyboardType: TextInputType.text,
                              validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
                            ),
                                          
                            const SizedBox(height: 20.0),
                            TextFormFrave(
                              controller: tel_field, 
                              prefixIcon: const Icon(Icons.add),
                              hintText: 'Téléphone',
                              keyboardType: TextInputType.number,
                              validator: (value){
                                String patttern = r'(^(?:[+])?[0-9]{7,14}$)';
                                RegExp regExp =  RegExp(patttern);
                                if (value!.isEmpty) {
                                  return 'Svp entrer un numéro de téléphone !';
                                }
                                else if (!regExp.hasMatch(value)) {
                                  return 'Numéro Invalide.Il doit commencer par un +code pays';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20,),
                            Container(
                              margin: const EdgeInsets.only(left: 23,right: 23),
                              child: Material( 
                                elevation: 10.0,
                                color: Color(0xfff5f5f5),
                                borderRadius: BorderRadius.circular(30.0),
                                child: DropdownButtonHideUnderline(
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButton<String>(
                                      value: roles,
                                      iconSize: 30,
                                      icon: (null),
                                      style: const TextStyle(
                                        color: Colors.black54,
                                        fontSize: 16,
                                      ),
                                      hint: const Text("Sélèctionner un role... "),
                                      onChanged: (newValue) {
                                        setState(() {
                                          roles = newValue;
                                        });
                                      },
                                      items: roleList.map((item) {
                                        return DropdownMenuItem(
                                          child: Text(item),
                                          value: item.toString(),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                                          
                            const SizedBox(height: 20.0),
                            TextFormFrave(
                              controller: mdp_field, 
                              prefixIcon: const Icon(Icons.add),
                              hintText: 'Mot de passe',
                              keyboardType: TextInputType.text,
                              isPassword: true,
                              validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
                            ),
                                          
                            const SizedBox(height: 20.0),
                            TextFormFrave(
                              controller: mdpConf_field, 
                              prefixIcon: const Icon(Icons.add),
                              hintText: 'Confirmer le mot de passe',
                              keyboardType: TextInputType.text,
                              isPassword: true,
                              validator: (e)=>e!.isEmpty?"Veuillez remplir ce champ":null,
                            ),
                        
                                            // 
                                            // SpaceH16(),
                                            // IdentityCard(
                                            //   number: 2,
                                            //   title: "Passport",
                                            //   body: "Required Passport For Non Citizens",
                                            // ),
                            SpaceH16(),
                            Container(
                              margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_48),
                              child: CustomButton(
                                title:"Terminer",
                                textStyle: TextStyle(
                                  color: Colors.white
                                ),
                                onPressed: (){
                                  Finaliser(DataDoc,fichiers2);
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
