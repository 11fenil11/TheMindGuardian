import 'package:flutter/material.dart';

class User {
  final String name;
  final String email;
  final String date;
  final int age;
  final String address;
  final String phone;
  final String image;
  final Map<String,dynamic> appUsageMaps; //change------------
  User(
      this.name,
      this.email,
      this.phone,
      this.date,
      this.age,
      this.image,
      this.address,
      this.appUsageMaps //change-----------------------------
  );
}