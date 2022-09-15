import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/onboarding_item.dart';
import 'package:restaurant_app/ui/onBoarding/login_page.dart';
import 'package:restaurant_app/widget/on_boarding_content.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget{
  static const routName = "/on_boarding";
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  late PageController _pageController;
  bool onLastPage = false;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Expanded(
                child: PageView.builder(
                  onPageChanged:(index) {
                    setState(() {
                      onLastPage = (index == 2);
                    });
                  },
                  itemCount: onBoardItem.length,
                    controller: _pageController,
                    itemBuilder: (context, index) => OnBoardContent(
                      image: onBoardItem[index].image,
                      tittle: onBoardItem[index].tittle,
                      description: onBoardItem[index].description,
                    )
                ),
              ),
            ),
            Container(
              alignment: const Alignment(0,0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    child: const Text("Skip"),
                    onTap: () {
                      _pageController.jumpToPage(2);
                    },
                  ),
                  //indicator
                  SmoothPageIndicator(
                      controller: _pageController,
                      count: 3
                  ),
                  onLastPage
                    ?GestureDetector(
                        child: const Text(
                            "Done",
                        ),
                        onTap: () {
                          Navigator.pushReplacementNamed(context, LoginPage.rootName);
                        },
                      )
                    :GestureDetector(
                        child: const Text(
                          "Next",
                        ),
                        onTap: () {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 500),
                              curve: Curves.easeIn
                          );
                        },
                      )
                ],
              )
            ),

          ]
        )
      )
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
