import 'package:flutter/material.dart';

class SigninButton extends StatelessWidget {
  final IconData btnIcon;
  final String btnText;
  final Color btnColor;
  final dynamic onPressed;

  const SigninButton({
    Key key,
    @required this.btnText,
    @required this.btnIcon,
    @required this.btnColor,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: 45,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              btnIcon,
              size: 21,
              color: Colors.white,
            ),
            SizedBox(width: 10),
            Text(
              btnText,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onTap: onPressed,
    );
  }
}

class CustomDivider extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final double radius;

  const CustomDivider({
    Key key,
    @required this.width,
    @required this.height,
    this.color,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(radius ?? 30),
      ),
    );
  }
}
