import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerMeetBook extends StatelessWidget{

  const ShimmerMeetBook({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey
        ),
      ),
    );
  }
}