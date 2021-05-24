import 'package:flutter/material.dart';

class SigninButton extends StatelessWidget {
  final IconData btnIcon;
  final String btnText;
  final Color btnColor;
  final dynamic onPressed;
  final double buttonHeight;

  const SigninButton({
    Key key,
    @required this.btnText,
    @required this.btnIcon,
    @required this.btnColor,
    @required this.onPressed,
    this.buttonHeight = 45.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        height: this.buttonHeight,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Icon(
                btnIcon,
                size: this.buttonHeight * 0.48, // 21
                color: Colors.white,
              ),
            ),
            CustomDivider(
              height: this.buttonHeight * 0.36,
              width: 1,
              color: Colors.grey[350],
              margin: EdgeInsets.only(right: 15),
            ),
            // SizedBox(width: 10),
            Expanded(
              child: Text(
                btnText,
                style: TextStyle(
                  fontSize: this.buttonHeight * 0.36, //16.5
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
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
  final EdgeInsets margin;

  const CustomDivider({
    Key key,
    @required this.width,
    @required this.height,
    this.color,
    this.radius,
    this.margin = EdgeInsets.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.width,
      height: this.height,
      margin: this.margin,
      decoration: BoxDecoration(
        color: this.color ?? Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(this.radius ?? 30),
      ),
    );
  }
}

class RoundedIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
