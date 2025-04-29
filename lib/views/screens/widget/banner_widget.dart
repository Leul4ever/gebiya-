import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

  class _BannerWidgetState extends State<BannerWidget > {
 final FirebaseFirestore _firestore = FirebaseFirestore.instance;
 final List<String>_bannerList = [];
 get banners(){
  return _firestore.collection('banners').get().then((value) {
    for (var element in value.docs) {
      _bannerList.add(element.data()['image']);
    }
  });
 }



  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}