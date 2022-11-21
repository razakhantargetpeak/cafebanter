import 'package:cafebanter/Utils/cafeBanterConstantColors.dart';
import 'package:cafebanter/Views/Admin/AddProducts.dart';
import 'package:cafebanter/Views/Admin/AdminOrders.dart';
import 'package:cafebanter/Views/Admin/homepage.dart';
import 'package:cafebanter/Views/CommingSoon.dart';
import 'package:cafebanter/Views/Customer/CartPage.dart';
import 'package:cafebanter/Views/Customer/cafeBanterHomePageView.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pandabar/pandabar.dart';

class BottomNavCustomer extends StatefulWidget {
  const BottomNavCustomer({super.key});

  @override
  State<BottomNavCustomer> createState() => _BottomNavCustomerState();
}

class _BottomNavCustomerState extends State<BottomNavCustomer> {
  String page = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: PandaBar(
        backgroundColor: Colors.white,
        buttonColor: CafeBanterColors.secondaryColor,
        buttonSelectedColor: CafeBanterColors.appMainColor,
        buttonData: [
          PandaBarButtonData(id: 'home', icon: Icons.home, title: 'Home'),
          PandaBarButtonData(
              id: 'explore', icon: Icons.explore, title: 'Explore'),
          PandaBarButtonData(
              id: 'notifications',
              icon: Icons.notifications,
              title: 'Notification'),
          PandaBarButtonData(
              id: 'cart', icon: Icons.shopping_cart, title: 'Cart'),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        fabColors: [
          CafeBanterColors.appMainColor,
          CafeBanterColors.secondaryColor
        ],
        fabIcon: Icon(
          FontAwesomeIcons.qrcode,
          color: Colors.white,
        ),
        onFabButtonPressed: () {},
      ),
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'home':
              return const CafeBanterHomePageView();
            case 'explore':
              return CommingSoon();
            case 'notifications':
              return CommingSoon();
            case 'cart':
              return CartPage();
            default:
              return Container();
          }
        },
      ),
    );
  }
}

class BottomNavAdmin extends StatefulWidget {
  const BottomNavAdmin({super.key});

  @override
  State<BottomNavAdmin> createState() => _BottomNavAdminState();
}

class _BottomNavAdminState extends State<BottomNavAdmin> {
  String page = 'home';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: PandaBar(
        backgroundColor: Colors.white,
        buttonColor: CafeBanterColors.secondaryColor,
        buttonSelectedColor: CafeBanterColors.appMainColor,
        buttonData: [
          PandaBarButtonData(id: 'home', icon: Icons.home, title: 'Grey'),
          PandaBarButtonData(
              id: 'products', icon: Icons.grid_3x3, title: 'Blue'),
          PandaBarButtonData(
              id: 'notification', icon: Icons.notifications, title: 'Red'),
          PandaBarButtonData(
              id: 'profile', icon: Icons.person, title: 'Yellow'),
        ],
        onChange: (id) {
          setState(() {
            page = id;
          });
        },
        fabColors: [
          CafeBanterColors.appMainColor,
          CafeBanterColors.secondaryColor
        ],
        onFabButtonPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddProducts()));
        },
      ),
      body: Builder(
        builder: (context) {
          switch (page) {
            case 'home':
              return AdminHomePage();
            case 'products':
              return AdminOrders();
            case 'notification':
              return CommingSoon();
            case 'profile':
              return CommingSoon();
            default:
              return Container();
          }
        },
      ),
    );
  }
}
