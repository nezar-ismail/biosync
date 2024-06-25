import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../../../../core/utils/header_back.dart';
import '../../../../cubits/edit_image/edit_user_image_cubit.dart';
import '../../model/profile_container_info.dart';
import 'user_info_container.dart';
import 'user_photo.dart';
import 'user_profile_path.dart';

class UserProfileList extends StatelessWidget {
  const UserProfileList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var userProfileBox = Hive.box('LocalUserModel');
    return ValueListenableBuilder(
      valueListenable: userProfileBox.listenable(),
      builder: (context, Box<dynamic> box, widget) {
        // Here you dynamically create the containerInfoList based on the latest box data
        var containerInfoList = [
          ProfileContainerInfoModel(
            userInfo: box.get('userName',
                defaultValue: 'Default User'), // Adjust keys as necessary
            title: 'User Name',
            isEditable: true,
            isPassword: false,
          ),
          ProfileContainerInfoModel(
            userInfo: box.get('userPhone',
                defaultValue: '+962'), // Adjust keys as necessary
            title: '+962',
            isEditable: true,
            isPassword: false,
          ),
          ProfileContainerInfoModel(
            userInfo: box.get('userGender',
                defaultValue: 'Gender'), // Adjust keys as necessary
            title: 'Gender',
            isEditable: false,
            isPassword: false,
          ),
          ProfileContainerInfoModel(
            userInfo: box.get('userEmail',
                defaultValue: 'Email'), // Adjust keys as necessary
            title: 'Email',
            isEditable: false,
            isPassword: false,
          ),
          ProfileContainerInfoModel(
            userInfo: '*********',
            title: 'Password',
            isEditable: true,
            isPassword: true,
          ),
        ];

        return Scaffold(
          body: SafeArea(
            child: CustomScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              slivers: <Widget>[
                // Additional widgets here
                const SliverToBoxAdapter(
                  child: HeaderWithBack(
                      txt: 'Profile',
                      txtColor: Colors.black,
                      iconColor: Colors.black),
                ),
                //*** User Photo ***/
                SliverToBoxAdapter(
                  child: BlocListener<UserImageCubit, EditUserImageState>(
                    listener: (context, state) {
                      if (state is UserImageLoaded) {
                        imageFile = state.file;
                      }
                    },
                    child: const UserPhoto(),
                  ),
                ),

                ///****/
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return UserInfoContainer(
                          textModels: containerInfoList[index]);
                    },
                    childCount: containerInfoList.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
