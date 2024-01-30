import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../routes/app_routes.dart';

class MainUserPageWidget extends StatefulWidget {
  const MainUserPageWidget({
    super.key,
  });

  @override
  State<MainUserPageWidget> createState() => _MainUserPageWidgetState();
}

class _MainUserPageWidgetState extends State<MainUserPageWidget> {
  bool isSwitch = false;
  final player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            children: [
              ListOfTilesWidget(
                iconLeading: Icons.account_box_rounded,
                text: 'Profile',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.userProfilePage);
                },
              ),
              const Divider(),
              ListOfTilesWidget(
                iconLeading: Icons.account_balance_wallet,
                text: 'Wallet',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.userWalletPage);
                },
              ),
              const Divider(),
              ListOfTilesWidget(
                iconLeading: Icons.add_location_rounded,
                text: 'Location',
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.userLocationPage);
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(
                  Icons.audiotrack_rounded,
                  size: 32,
                ),
                title: const Text(
                  'Sounds',
                  style: TextStyle(fontSize: 18),
                ),
                trailing: Switch(
                    value: isSwitch,
                    onChanged: (value) {
                      setState(() {
                        isSwitch = value;
                      });
                      if (value) {
                        playSound();
                      }
                    }),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        const CarouselWidget(),
      ],
    );
  }

  Future<void> playSound() async {
    String soundPath = 'sounds/click.mp3';
    await player.play(AssetSource(soundPath));
  }
}

class CarouselWidget extends StatefulWidget {
  const CarouselWidget({
    super.key,
  });

  @override
  State<CarouselWidget> createState() => _CarouselWidgetState();
}

class _CarouselWidgetState extends State<CarouselWidget> {
  final urlImages = [
    'assets/images/city.jpg',
    'assets/images/flamingo.jpg',
    'assets/images/mountain.jpg',
  ];
  final controller = CarouselController();
  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CarouselSlider.builder(
          carouselController: controller,
          itemCount: urlImages.length,
          itemBuilder: (context, index, realIndex) {
            final urlImage = urlImages[index];

            return buildImage(urlImage, index);
          },
          options: CarouselOptions(
            height: 250,
            onPageChanged: (index, reason) {
              setState(() {
                activeIndex = index;
              });
            },
          ),
        ),
        const SizedBox(
          height: 32,
        ),
        buildIndicator(),
      ],
    );
  }

  Widget buildImage(String urlImage, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      color: Colors.grey,
      child: Image.asset(
        urlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        onDotClicked: animateToSlide,
      );

  void animateToSlide(int index) => controller.animateToPage(index);
}

class ListOfTilesWidget extends StatelessWidget {
  final IconData iconLeading;
  final String text;
  final VoidCallback onTap;

  const ListOfTilesWidget({
    super.key,
    required this.iconLeading,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        iconLeading,
        size: 32,
      ),
      title: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
