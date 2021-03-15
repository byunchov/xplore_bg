import 'package:flutter/material.dart';
import 'package:xplore_bg/models/state.dart';
import 'package:xplore_bg/widgets/state_tile.dart';

class StatesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 20,
        title: const Text('Области'),
        backgroundColor: Colors.cyan[700],
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
                    "https://firebasestorage.googleapis.com/v0/b/xplore-bulgaria-test.appspot.com/o/images%2Flocations%2Fbansko-ski-slopes.jpg?alt=media&token=51ad6ef7-ec37-42b9-9326-c521493e356e",
              ),
            ),
            SizedBox(height: 10),
            StateTile(
              stateModel: StateModel(
                name: "София",
                thumbnail:
                    "https://firebasestorage.googleapis.com/v0/b/xplore-bulgaria-test.appspot.com/o/images%2Flocations%2Fbansko-ski-slopes.jpg?alt=media&token=51ad6ef7-ec37-42b9-9326-c521493e356e",
              ),
            ),
            SizedBox(height: 10),
            StateTile(
              stateModel: StateModel(
                name: "Кюстендил",
                thumbnail:
                    "https://firebasestorage.googleapis.com/v0/b/xplore-bulgaria-test.appspot.com/o/images%2Flocations%2Fbansko-ski-slopes.jpg?alt=media&token=51ad6ef7-ec37-42b9-9326-c521493e356e",
              ),
            ),
            SizedBox(height: 10),
            StateTile(
              stateModel: StateModel(
                name: "Варна",
                thumbnail:
                    "https://firebasestorage.googleapis.com/v0/b/xplore-bulgaria-test.appspot.com/o/images%2Flocations%2Fbansko-ski-slopes.jpg?alt=media&token=51ad6ef7-ec37-42b9-9326-c521493e356e",
              ),
            ),
            SizedBox(height: 10),
            StateTile(
              stateModel: StateModel(
                name: "Бургас",
                thumbnail:
                    "https://firebasestorage.googleapis.com/v0/b/xplore-bulgaria-test.appspot.com/o/images%2Flocations%2Fbansko-ski-slopes.jpg?alt=media&token=51ad6ef7-ec37-42b9-9326-c521493e356e",
              ),
            ),
            SizedBox(height: 10),
            StateTile(
              stateModel: StateModel(
                name: "Смолян",
                thumbnail:
                    "https://firebasestorage.googleapis.com/v0/b/xplore-bulgaria-test.appspot.com/o/images%2Flocations%2Fbansko-ski-slopes.jpg?alt=media&token=51ad6ef7-ec37-42b9-9326-c521493e356e",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
