import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:receive_product/Getx/Drawer/DrawerController.dart';
import 'package:receive_product/Getx/Drawer/MyDrawer.dart';
import 'package:receive_product/Getx/auth_controller.dart';
import 'package:receive_product/Getx/routes.dart';
// Import the updated controller



class OP extends StatefulWidget {
  const OP({Key? key}) : super(key: key);

  @override
  State<OP> createState() => _OPState();
}

class _OPState extends State<OP> {
  final MyDrawerController drawerController = Get.find<MyDrawerController>(); // Get the controller instance
  final AuthController authController = Get.find<AuthController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
 // ini();
  }
  @override
  Widget build(BuildContext context) {
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

  // void ini() async{
  //   await Future.delayed(Duration(seconds: 2));
  //   bool user = await authController.checkVerificationStatus();
  //
  //   if (user) {
  //     //Get.offAllNamed(Routes.home);
  //     print('ok');
  //   } else {
  //     authController.clearUser();
  //     Get.offAllNamed(Routes.login);
  //   }
  //
  // }
}


