import 'package:flutter/material.dart';
import 'package:toonflix/%08services/api_service.dart';
import 'package:toonflix/models/webtoon_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<WebtoonModel> webtoons = [];
  bool isLoading = true;

  void waitForWebtoons() async {
    webtoons = await ApiService.getTodaysToons();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    waitForWebtoons();
  }

  @override
  Widget build(BuildContext context) {
    print(webtoons);
    print(isLoading);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.green,
        title: const Text("웹툰",
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }
}
