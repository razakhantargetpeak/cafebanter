import 'package:animated_page_reveal/animated_page_reveal.dart';
import 'package:cafebanter/Utils/cafeBanterConstantColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class OnboardigView extends StatefulWidget {
  const OnboardigView({super.key});

  @override
  State<OnboardigView> createState() => _OnboardigViewState();
}

class _OnboardigViewState extends State<OnboardigView> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: AnimatedPageReveal(
        children: [
          PageViewModel(
            title: 'Choose your place',
            description:
                'Pick the right destination according to the season because it is a key factor for a successful trip',
            color: const Color(0xff195932),
            imageAssetPath: "assets/cafeBanter.png",
            iconAssetPath: "",
            titleStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            descriptionStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          PageViewModel(
            title: 'Book your flight',
            description:
                'Found a flight that matches your destination and schedule? \nBook it just a few taps',
            color: const Color(0xff19594E),
            imageAssetPath: 'assets/images/flight.png',
            iconAssetPath: 'assets/images/planicon.png',
            titleStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            descriptionStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
          ),
          PageViewModel(
            title: 'Explore the world',
            description:
                'Easily discover new places and share them with your friends. \nMaybe you will plan together your next trip?',
            color: const Color(0xff193A59),
            imageAssetPath: 'assets/images/explore.png',
            iconAssetPath: 'assets/images/searchicon.png',
            titleStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            descriptionStyle: const TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Colors.white,
            ),
            
          ),

        ],

      ),
    );
  }
}
