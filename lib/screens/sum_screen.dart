import 'dart:ffi';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class Problem {
  int num1;
  int num2;
  int ans;

  Problem(this.num1, this.num2, this.ans);
}

class SumScreen extends StatefulWidget {
  const SumScreen({super.key});

  @override
  State<SumScreen> createState() => _SumScreenState();
}

class _SumScreenState extends State<SumScreen> {
  final ansController = TextEditingController();
  int _currentIndex = 0;
  var problems = [];
  late var _interstitialAd;

  final BannerAd myBanner = BannerAd(
    adUnitId: "ca-app-pub-3940256099942544/6300978111",
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );

  @override
  void initState() {
    super.initState();
    myBanner.load();

    int totalSums = 10;
    var rng = Random();

    for (int i = 0; i < totalSums; i++) {
      int num1 = rng.nextInt(10);
      int num2 = rng.nextInt(10);
      print(num1);
      print(num2);
      problems.add(Problem(num1, num2, num1 + num2));
    }
    print(problems);
  }

  @override
  void dispose() {
    super.dispose();
    ansController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              problems[_currentIndex].num1.toString(),
              style: TextStyle(fontSize: 80),
            ),
            const Text(
              '+            ',
              style: TextStyle(fontSize: 50),
            ),
            Text(
              problems[_currentIndex].num2.toString(),
              style: TextStyle(fontSize: 80),
            ),
            Divider(height: 5),
            Padding(
              padding: const EdgeInsets.fromLTRB(150, 0, 150, 0),
              child: TextField(
                cursorWidth: 3,
                style: const TextStyle(fontSize: 80),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                controller: ansController,
                onSubmitted: (text) {},
              ),
            ),
            IconButton(
                onPressed: () {
                  InterstitialAd.load(
                      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
                      request: AdRequest(),
                      adLoadCallback: InterstitialAdLoadCallback(
                        onAdLoaded: (InterstitialAd ad) {
                          // Keep a reference to the ad so you can show it later.
                          _interstitialAd = ad;
                        },
                        onAdFailedToLoad: (LoadAdError error) {
                          print('InterstitialAd failed to load: $error');
                        },
                      ));
                  _interstitialAd.show();

                  // if (int.parse(ansController.text) ==
                  //     problems[_currentIndex].ans) {
                  //   setState(() {
                  //     _currentIndex = _currentIndex + 1;
                  //   });
                  // } else {}
                },
                icon: const Icon(Icons.navigate_next_rounded)),
            Container(width: 900, height: 200, child: AdWidget(ad: myBanner))
          ],
        ),
      ),
    );
  }
}
