import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meetbook/Config/Utils/values.dart';
import 'package:meetbook/Modules/onboarding/Classes/onboarding_class.dart';
import 'package:meetbook/Modules/widgets/custom_button.dart';
import 'package:meetbook/Modules/widgets/spaces.dart';
import 'package:meetbook/Rootes/root_page.dart';

class OnboardingUI extends StatefulWidget {
  const OnboardingUI({super.key});

  @override
  State<OnboardingUI> createState() => _OnboardingUIState();
}

class _OnboardingUIState extends State<OnboardingUI> {
  late int currentIndexPage;
  late int pageLength;

  OnboardingClass controller = OnboardingClass();

  @override
  void initState() {
    super.initState();
    currentIndexPage = 0;
    pageLength = 3;
  }
  @override
  Widget build(BuildContext context) {
    double marginFromSafeArea = 24;
    var heightOfScreen = MediaQuery.of(context).size.height - marginFromSafeArea;

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: heightOfScreen * 0.6,
                  child: PageView(
                    children: <Widget>[
                      _buildOnboard(imageUrl: ImagePath.RDV),
                      _buildOnboard(imageUrl: ImagePath.RDV2),
                      _buildOnboard(imageUrl: ImagePath.PASSPORT),
                    ],
                    onPageChanged: (value) {
                      setState(() => currentIndexPage = value.toInt());
                    },
                  ),
                ),
                Container(
                  height: heightOfScreen * 0.1,
                  child: DotsIndicator(
                    dotsCount: pageLength,
                    position: currentIndexPage,
                    decorator: DotsDecorator(
                      color: AppColors.grey,
                      activeColor: AppColors.violetShade1,
                    ),
                  ),
                ),
                Container(
                  height: heightOfScreen * 0.3,
                  child: _buildButtons(context: context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOnboard({required String imageUrl}) {
    var widthOfScreen = MediaQuery.of(context).size.width;
    var heightOfScreen = MediaQuery.of(context).size.height - 24;
    //var textTheme = Theme.of(context).textTheme;

    return Container(
      margin: const EdgeInsets.only(top: Sizes.MARGIN_16),
      child: Stack(
        children: <Widget>[
          Image.asset(
            ImagePath.TWINKLE,
            width: widthOfScreen,
            height: heightOfScreen * 0.4,
          ),
          Container(
            height: heightOfScreen * 0.6,
            child: Column(
              children: <Widget>[
                Image.asset(
                  imageUrl,
                  width: widthOfScreen,
                  height: heightOfScreen * 0.4,
                ),
                SpaceH8(),
                ListBody(
                  mainAxis: Axis.vertical,
                  children: <Widget>[
                    const Text(
                      StringConst.START,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SpaceH8(),
                    const Text(
                      StringConst.JOIN,
                      textAlign: TextAlign.center,
                    ),
                    SpaceH8(),
                    Text(
                      StringConst.GRATUIT,
                      textAlign: TextAlign.center,
                    ),
                    SpaceH8(),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons({required BuildContext context}) {
    var textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: Sizes.MARGIN_48),
      child: Column(
        children: <Widget>[
          CustomButton(
            title: StringConst.LOGIN,
            textStyle: textTheme.button!.copyWith(color: AppColors.violetShade1),
            color: AppColors.white,
            borderSide: Borders.primaryBorder,
            onPressed: () {
              if(controller.local.read("user_id_connect") !=null)
              {
                Get.offAllNamed(Routes.WELCOME);
              }
              else
              {
                Get.toNamed(Routes.LOGIN);
              }
            },
          ),
          SpaceH30(),
          CustomButton(
            title: StringConst.CREATE_COMPTE,
            onPressed: () {
              Get.toNamed(Routes.REGISTER);
            },
            textStyle: TextStyle(
              color: Colors.white
            ),
          ),
        ],
      ),
    );
  }
}