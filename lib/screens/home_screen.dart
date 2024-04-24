import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:toonflix/%08services/api_service.dart';
import 'package:toonflix/models/webtoon_model.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future<List<WebtoonModel>> webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 10,
          backgroundColor: Colors.green,
          title: const Text("웹툰",
              style: TextStyle(color: Colors.white, fontSize: 20)),
        ),
        body: FutureBuilder(
          future: webtoons,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: makeList(snapshot),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Failed to load data"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ));
  }

  ListView makeList(AsyncSnapshot<List<WebtoonModel>> snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        var webtoon = snapshot.data![index];
        return Webtton(
            title: webtoon.title, thumb: webtoon.thumb, id: webtoon.id);
      },
    );
  }
}
