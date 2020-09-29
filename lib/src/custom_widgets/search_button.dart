import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton({@required this.icon ,@required this.onPressed ,this.color : Colors.white70,this.iconSize:30,this.width : 60,this.height :50,this.borderRadius:2.0});
  final IconData icon;
  final Color color;
  final double borderRadius ;
  final double height ;
  final double width ;
  final double iconSize;
  final VoidCallback onPressed ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width ,
      child: RaisedButton(
        child: Center(child: Icon(icon,size: iconSize,color: Colors.black54,)),
        elevation: 5 ,
        color: color,
        disabledColor: color,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(borderRadius)),


        ),

      ),
    ) ;
  }
}
