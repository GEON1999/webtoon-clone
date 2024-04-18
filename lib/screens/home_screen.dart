import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeSCreen extends StatefulWidget {
  const HomeSCreen({super.key});

  @override
  State<HomeSCreen> createState() => _HomeSCreenState();
}

class _HomeSCreenState extends State<HomeSCreen> {
  static const initailSec = 1500;
  int totalSeconds = initailSec;
  int totalPomodoros = 0;
  bool isRunning = false;
  late Timer timer;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      timer.cancel();
      setState(() {
        totalPomodoros++;
        isRunning = false;
        totalSeconds = 1500;
      });
    } else {
      setState(() {
        totalSeconds--;
      });
    }
  }

  void onStopPressed() {
    timer.cancel();
    setState(() {
      totalSeconds = initailSec;
      isRunning = false;
    });
  }

  void onPressed() {
    if (isRunning == true) {
      setState(() {
        isRunning = false;
      });
      timer.cancel();
    } else {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        onTick,
      );
      setState(() {
        isRunning = true;
      });
    }
  }

  String timeFormat() {
    var duration = Duration(seconds: totalSeconds);
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        children: [
          Flexible(
              flex: 1,
              child: Container(
                alignment: Alignment.bottomCenter,
                child: Text(timeFormat(),
                    style: TextStyle(
                        color: Theme.of(context).cardColor,
                        fontSize: 89,
                        fontWeight: FontWeight.w600)),
              )),
          Flexible(
              flex: 2,
              child: Row(children: [
                // center
                IconButton(
                    iconSize: 150,
                    color: Theme.of(context).cardColor,
                    onPressed: () {
                      onPressed();
                    },
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outline
                        : Icons.play_circle_outline)),
                IconButton(
                    iconSize: 150,
                    color: Theme.of(context).cardColor,
                    onPressed: () {
                      onStopPressed();
                    },
                    icon: const Icon(Icons.stop_circle_outlined))
              ])),
          Flexible(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(40)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Pomodoros',
                            style: TextStyle(
                                fontSize: 20,
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                                fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '$totalPomodoros',
                            style: TextStyle(
                                fontSize: 58,
                                color: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .color,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
