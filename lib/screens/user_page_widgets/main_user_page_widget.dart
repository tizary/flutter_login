import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart';
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
        )
      ],
    );
  }

  Future<void> playSound() async {
    String soundPath = 'sounds/click.mp3';
    await player.play(AssetSource(soundPath));
  }
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
