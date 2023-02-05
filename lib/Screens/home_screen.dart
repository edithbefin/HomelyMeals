import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:rentalapp/widgets/adshowcaselistview_widget.dart';

import 'package:rentalapp/widgets/appbar_widget.dart';

import 'package:rentalapp/widgets/loading_widget.dart';
import 'package:rentalapp/widgets/locationbar_widget.dart';

import '../resources/cloudfirestore_methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget>? catagoryApartment;
  List<Widget>? catagoryHouse;
  List<Widget>? catagoryHostel;
  List<Widget>? catagoryPayingGuest;

  @override
  void initState() {
    super.initState();
    getData();
    getName();
  }

  void getData() async {
    List<Widget> tempApartment =
        await CloudFirestoreClass().getProductsFromCatagory("Non-veg");
    List<Widget> tempHouse =
        await CloudFirestoreClass().getProductsFromCatagory("Veg");
    List<Widget> tempHostels =
        await CloudFirestoreClass().getProductsFromCatagory("Snacks");
    List<Widget> tempPayingGuests =
        await CloudFirestoreClass().getProductsFromCatagory("Cakes");
    log("success");
    if (!mounted) {
      return;
    }
    setState(() {
      catagoryApartment = tempApartment;
      catagoryHouse = tempHouse;
      catagoryHostel = tempHostels;
      catagoryPayingGuest = tempPayingGuests;
    });
  }

  void getName() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: AppBarWidget(),
          title: const Text('Homely Meals'),
        ),
        body: catagoryApartment != null &&
                catagoryHouse != null &&
                catagoryHostel != null &&
                catagoryPayingGuest != null
            ? Stack(
                children: [
                  SingleChildScrollView(
                    child: Column(
                      children: [
                        const LocationBar(),
                        //const HorizontalListViewBar(),
                        AdsListViewShowcaseWidget(
                            title: 'Non-Veg', children: catagoryApartment!),
                        AdsListViewShowcaseWidget(
                            title: 'Veg', children: catagoryHouse!),
                        AdsListViewShowcaseWidget(
                            title: 'Snacks', children: catagoryHostel!),
                        AdsListViewShowcaseWidget(
                            title: 'Cakes', children: catagoryPayingGuest!),
                      ],
                    ),
                  ),
                ],
              )
            : const LoadingWidget());
  }
}
