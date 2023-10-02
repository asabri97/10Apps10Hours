import 'dart:async';

import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:confetti/confetti.dart';

class CountdownTimerApp extends StatefulWidget {
  const CountdownTimerApp({super.key});

  @override
  State<CountdownTimerApp> createState() => _CountdownTimerAppState();
}

class _CountdownTimerAppState extends State<CountdownTimerApp> {
  late Timer timer;
  int totalTime = 0;
  var minute = 0;
  var seconds = 0;
  AudioCache player = AudioCache();
  ConfettiController confettiController =
      ConfettiController(duration: const Duration(seconds: 2));

  void playSound() async {
    final player = AudioPlayer();
    await player.play(AssetSource('assets/sound.wav'));
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    timer = Timer.periodic(oneSecond, (timer) {
      totalTime = minute * 60 + seconds;
      setState(() {
        if (totalTime < 1) {
          timer.cancel();
          playSound();
          confettiController.play();
        } else {
          totalTime -= 1;
          minute = (totalTime / 60).floor();
          seconds = totalTime % 60;
        }
      });
    });
  }

  void setMinutes(int? value) {
    setState(() {
      minute = value ?? minute;
    });
  }

  void setSeconds(int? value) {
    setState(() {
      seconds = value ?? seconds;
    });
  }

  @override
  void dispose() {
    confettiController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primarySwatch: Colors.deepPurple),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purpleAccent,
          title: const Text('Countdown Timer'),
        ),
        body: Stack(
          children: [
            Center(
              child: Text(
                '$minute:$seconds',
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child: ConfettiWidget(confettiController: confettiController),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            int tempMinute = minute;
            int tempSeconds = seconds;
            showDialog(
              context: context,
              builder: (context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return SimpleDialog(
                      contentPadding: const EdgeInsets.all(15),
                      children: [
                        const Text('Set your time'),
                        DropdownButton<int>(
                            value: tempMinute,
                            icon: const Text('Minute'),
                            items: List.generate(60, (index) {
                              return DropdownMenuItem(
                                value: index,
                                child: Text(index.toString()),
                              );
                            }),
                            onChanged: (int? value) {
                              setState(() {
                                tempMinute = value ?? tempMinute;
                              });
                            }),
                        DropdownButton<int>(
                            value: tempSeconds,
                            icon: const Text('Seconds'),
                            items: List.generate(60, (index) {
                              return DropdownMenuItem(
                                value: index,
                                child: Text(index.toString()),
                              );
                            }),
                            onChanged: (int? value) {
                              setState(() {
                                tempSeconds = value ?? tempSeconds;
                              });
                            }),
                        const SizedBox(
                          height: 15,
                        ),
                        OutlinedButton(
                            onPressed: () {
                              setMinutes(tempMinute);
                              setSeconds(tempSeconds);
                              startTimer();
                              Navigator.of(context).pop();
                            },
                            child: const Text('Start'))
                      ],
                    );
                  },
                );
              },
            );
          },
          child: const Icon(Icons.alarm_add_outlined),
        ),
      ),
    );
  }
}
