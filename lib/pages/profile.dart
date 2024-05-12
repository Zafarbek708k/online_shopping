import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 4.0, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){},
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundImage:
                          AssetImage("assets/images/circle_avatar.png"),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Mr User',
                              ),
                              SizedBox(width: 36),
                            ],
                          ),
                          Text(
                            '+998 99 777 55 22',
                          ),
                          Text(
                            'ID 0075',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                ListTile(
                  leading: ImageIcon(
                    const AssetImage("assets/images/Location.png"),
                    color: Colors.grey.shade700,
                  ),
                  title: const Text(
                    'Location',
                  ),
                  onTap: () {

                  },
                ),
                ListTile(
                  leading: ImageIcon(
                    const AssetImage("assets/images/Plagiarism Checker.png"),
                    color: Colors.grey.shade700,
                  ),
                  title: const Text(
                    'History',
                  ),
                  onTap: () {

                  },
                ),
                ListTile(
                  leading: ImageIcon(
                    const AssetImage("assets/images/Wallet.png"),
                    color: Colors.grey.shade700,
                  ),
                  title: const Text(
                    'Payment',
                  ),
                  onTap: () {

                  },
                ),
                ListTile(
                  leading: ImageIcon(const AssetImage("assets/images/Setting.png"),
                      color: Colors.grey.shade700),
                  title: const Text(
                    'Setting',
                  ),
                  onTap: () {
                  },
                ),

                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
