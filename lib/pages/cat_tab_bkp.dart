/* import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class CategotiesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double _cardRadius = 10;
    final double _cardHeight = 150;
    final double _categotyIconCircle = 40;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CategoryCard(
              cardHeight: _cardHeight,
              cardRadius: _cardRadius,
              title: "Природни забележителности",
              categotyIconCircle: _categotyIconCircle,
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: CategoryCard(
                    cardHeight: _cardHeight,
                    cardRadius: _cardRadius,
                    title: "Култура и изкуство",
                    categotyIconCircle: _categotyIconCircle,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: CategoryCard(
                    cardHeight: _cardHeight,
                    cardRadius: _cardRadius,
                    title: "Изторически забележителности",
                    categotyIconCircle: _categotyIconCircle,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: CategoryCard(
                    cardHeight: _cardHeight,
                    cardRadius: _cardRadius,
                    title: "Маршрути и екопътеки",
                    categotyIconCircle: _categotyIconCircle,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: CategoryCard(
                    cardHeight: _cardHeight,
                    cardRadius: _cardRadius,
                    title: "Селски и Еко туризъм",
                    categotyIconCircle: _categotyIconCircle,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: CategoryCard(
                    cardHeight: _cardHeight,
                    cardRadius: _cardRadius,
                    title: "Забавления",
                    categotyIconCircle: _categotyIconCircle,
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  child: CategoryCard(
                    cardHeight: _cardHeight,
                    cardRadius: _cardRadius,
                    title: "Артакциони",
                    categotyIconCircle: _categotyIconCircle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
 */
