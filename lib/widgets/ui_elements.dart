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
