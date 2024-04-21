import 'package:chat_wave/Screen/dashboard/screens/messageScreens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(navController1());
    return Scaffold(
      bottomNavigationBar: Obx(
        ()  => NavigationBar(
        
          height: 60,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index)=> controller.selectedIndex.value = index,
          destinations:
          [
        
            NavigationDestination(icon: Icon(Icons.message), label: "Message"),
            NavigationDestination(icon: Icon(Icons.call), label: "Calls"),
            NavigationDestination(icon: Icon(Icons.contact_page_rounded), label: "Contact"),
            NavigationDestination(icon: Icon(Icons.settings), label: "Setting"),
          ],
        ),
      ),

      body: Obx( ()=> controller.screens[controller.selectedIndex.value]),








    );
  }
}

class navController1 extends GetxController{

  final Rx<int> selectedIndex =0.obs;

  final screens = [  const MessageScreen(),
    Container(color: Colors.yellow,),
    Container(color: Colors.pink,),
    Container(color: Colors.blue,),];
}
