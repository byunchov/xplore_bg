import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:xplore_bg/widgets/ui_elements.dart';

class BlankPage extends StatelessWidget {
  final String heading;
  final IconData icon;
  final String shortText;
  final bool divider;
  final Widget customAction;

  const BlankPage({
    Key key,
    @required this.heading,
    this.icon,
    this.shortText,
    this.divider = false,
    this.customAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            this.icon == null
                ? Container()
                : Column(
                    children: [
                      Icon(
                        icon ?? Feather.image,
                        size: 96,
                        color: Colors.grey[500],
                      ),
                      SizedBox(height: 15),
                    ],
                  ),
            Text(
              heading ?? 'Heading',
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600),
            ),
            // SizedBox(height: divider ? 10 : 5),
            divider
                ? CustomDivider(
                    width: MediaQuery.of(context).size.width * 0.55,
                    height: 2.5,
                    margin: EdgeInsets.symmetric(vertical: 10),
                  )
                : SizedBox(height: 5),
            // SizedBox(height: divider ? 10 : 0),
            Text(
              shortText ?? '',
              textAlign: TextAlign.center,
              softWrap: true,
              maxLines: 2,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey[500],
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            this.customAction == null ? Container() : this.customAction,
          ],
        ),
      ),
    );
  }
}
