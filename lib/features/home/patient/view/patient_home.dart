import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../widget/drawer.dart';
import '../widget/navibar.dart';

import '../widget/patient_home_page.dart';

class PatientHomeView extends StatelessWidget {
  const PatientHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const NaviBar(
        itsHome: true,
      ),
      drawerEdgeDragWidth: MediaQuery.sizeOf(context).width * 0.5,
      drawerScrimColor: Colors.transparent,
      drawerEnableOpenDragGesture: false,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.white,
      drawer: Padding(
        padding: const EdgeInsets.only(bottom: 60),
        child: Drawer(
          shadowColor: Colors.black,
          elevation: 20,
          surfaceTintColor: const Color.fromARGB(53, 178, 223, 219),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          backgroundColor: Colors.white,
          width: MediaQuery.sizeOf(context).width * 0.5,
          child: const PatientCustomDrawer(),
        ),
      ),
      appBar: AppBar(
        title: Image.asset(
          'assets/image/logo.png',
          width: 150,
        ),
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        centerTitle: true,
        elevation: 0,
        leading: Builder(builder: (context) {
          return IconButton(
            icon:
                const Icon(FontAwesomeIcons.barsStaggered, color: Colors.black),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          );
        }),
      ),
      body: const PatientHomeWidget(),
    );
  }
}


