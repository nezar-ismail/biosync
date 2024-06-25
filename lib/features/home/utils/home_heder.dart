import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/database/local_database.dart';
import '../../../core/database/local_user_model.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    var homeDataBox = Hive.box('LocalUserModel');
    return ValueListenableBuilder(
      valueListenable: homeDataBox.listenable(),
      builder: (context, Box<dynamic> box, widget) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width * 0.2,
              height: MediaQuery.sizeOf(context).width * 0.2,
              decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black38,
                    blurRadius: 5,
                    spreadRadius: 1,
                    offset: Offset(1, 1),
                    // Shadow position
                  ),
                ],
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    LocalDataBase.getIPAddress() +
                        LocalUserModel.getUserImage(),
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Hello, ',
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      LocalUserModel.getUserType() == 'patient'
                          ? '${LocalUserModel.getUserName().toUpperCase()}👋'
                          : 'Dr.${LocalUserModel.getUserName().toUpperCase()}👋', // User name updated dynamically
                      maxLines: 1,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
