import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:receive_the_product/Getx/Drawer/DrawerController.dart';
import 'package:receive_the_product/Getx/Drawer/MyDrawer.dart';
// Import the updated controller

class OP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MyDrawerController drawerController = Get.find<MyDrawerController>(); // Get the controller instance

    return Scaffold(
      appBar: AppBar(
        title: Text('Empty Page'),
      ),
      body: Center(
        child: Text(
          'This is an empty page',
          style: TextStyle(fontSize: 24),
        ),
      ),
      drawer: MyDrawer(), // Pass the drawer with the updated controller
    );
  }
}
