import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class SheetGrabbing extends StatelessWidget {
  final Color color;
  final bool reverse;

  const SheetGrabbing(
      {Key? key, this.color = Colors.white, this.reverse = false})
      : super(key: key);

  BorderRadius _getBorderRadius() {
    var radius = Radius.circular(25.0);
    return BorderRadius.only(
      topLeft: reverse ? Radius.zero : radius,
      topRight: reverse ? Radius.zero : radius,
      bottomLeft: reverse ? radius : Radius.zero,
      bottomRight: reverse ? radius : Radius.zero,
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        // boxShadow: [
        //   BoxShadow(
        //     blurRadius: 20,
        //     spreadRadius: 10,
        //     color: Colors.black.withOpacity(0.15),
        //   )
        // ],
        
        borderRadius: _getBorderRadius(),
      ),
      child: Transform.rotate(
        angle: reverse ? pi : 0,
        child: Stack(
          children: [
            
            Positioned(
              height:reverse?MediaQuery.of(context).size.height*0.2:MediaQuery.of(context).size.height*0.15,
              width: MediaQuery.of(context).size.width,
              child: ClipRect(
                child: BackdropFilter
                (
                  
                  filter: ImageFilter.blur(sigmaX: 5,sigmaY: 5),
                  child: Container(color: Colors.black.withOpacity(0.3)),
                ),
              ),
            ),
            Align(
              alignment: Alignment(0, -1),
              child: GrabbingIndicator(),
            ),
          ],
        ),
      ),
    );
  }
}

class GrabbingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        color: Colors.grey[400],
      ),
      height: 8,
      width: 50,
    );
  }
}
