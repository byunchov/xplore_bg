import 'package:flutter/material.dart';
import 'package:xplore_bg/models/state.dart';
import 'package:xplore_bg/widgets/state_tile.dart';
import 'package:easy_localization/easy_localization.dart';

class StatesPage extends StatefulWidget {
  @override
  _StatesPageState createState() => _StatesPageState();
}

class _StatesPageState extends State<StatesPage>
    with AutomaticKeepAliveClientMixin<StatesPage> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.all(20),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        children: [
          StateTile(
            stateModel: StateModel(
              name: "Благоевград",
              thumbnail:
                  "https://static.bnr.bg/gallery/e4/e42490f218581383ceb5be0fe100447e.jpeg",
            ),
          ),
          SizedBox(height: 15),
          StateTile(
            stateModel: StateModel(
              name: "София",
              thumbnail:
                  "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/33/fc/c5/sofia.jpg?w=1100&h=600&s=1",
            ),
          ),
          SizedBox(height: 15),
          StateTile(
            stateModel: StateModel(
              name: "Кюстендил",
              thumbnail:
                  "https://static.standartnews.com/storage/thumbnails/inner_article/7815/4147/7035/a3dc72b590136f935b335b98f1e97df4.jpg",
            ),
          ),
          SizedBox(height: 15),
          StateTile(
            stateModel: StateModel(
              name: "Варна",
              thumbnail:
                  "https://trud.bg/public/images/articles/2020-07/%D0%B2%D0%B0%D1%80%D0%BD%D0%B022_6175783433033857334_original.jpg",
            ),
          ),
          SizedBox(height: 15),
          StateTile(
            stateModel: StateModel(
              name: "Бургас",
              thumbnail:
                  "https://blog.esky.bg/wp-content/uploads/2020/07/istock-1018199162.jpg",
            ),
          ),
          SizedBox(height: 15),
          StateTile(
            stateModel: StateModel(
              name: "Смолян",
              thumbnail:
                  "https://www.smolyan.bg/media/content_files/file/image/%D0%A2%D0%A3%D0%A0%D0%98%D0%97%D0%AA%D0%9C/0_%20%D0%97%D0%90%D0%93%D0%9B%D0%90%D0%92%D0%9D%D0%90/3.jpg",
            ),
          ),
        ],
      ),
    );
  }
}

class StatesPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // elevation: 10,
        title: const Text('menu_states').tr(),
        // backgroundColor: Colors.cyan[700],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(15),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          children: [
            StateTile(
              stateModel: StateModel(
                name: "Благоевград",
                thumbnail:
                    "https://static.bnr.bg/gallery/e4/e42490f218581383ceb5be0fe100447e.jpeg",
              ),
            ),
            SizedBox(height: 15),
            StateTile(
              stateModel: StateModel(
                name: "София",
                thumbnail:
                    "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/15/33/fc/c5/sofia.jpg?w=1100&h=600&s=1",
              ),
            ),
            SizedBox(height: 15),
            StateTile(
              stateModel: StateModel(
                name: "Кюстендил",
                thumbnail:
                    "https://static.standartnews.com/storage/thumbnails/inner_article/7815/4147/7035/a3dc72b590136f935b335b98f1e97df4.jpg",
              ),
            ),
            SizedBox(height: 15),
            StateTile(
              stateModel: StateModel(
                name: "Варна",
                thumbnail:
                    "https://trud.bg/public/images/articles/2020-07/%D0%B2%D0%B0%D1%80%D0%BD%D0%B022_6175783433033857334_original.jpg",
              ),
            ),
            SizedBox(height: 15),
            StateTile(
              stateModel: StateModel(
                name: "Бургас",
                thumbnail:
                    "https://blog.esky.bg/wp-content/uploads/2020/07/istock-1018199162.jpg",
              ),
            ),
            SizedBox(height: 15),
            StateTile(
              stateModel: StateModel(
                name: "Смолян",
                thumbnail:
                    "https://www.smolyan.bg/media/content_files/file/image/%D0%A2%D0%A3%D0%A0%D0%98%D0%97%D0%AA%D0%9C/0_%20%D0%97%D0%90%D0%93%D0%9B%D0%90%D0%92%D0%9D%D0%90/3.jpg",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
