
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();
final  formaterDate = DateFormat.yMd();


class Expense {
  final String title;
  final double amount;
  final String id;
  final DateTime date;
  final Category category;

  String get formattedDate{
    return formaterDate.format(date);
  }

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
}

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.flight_takeoff,
  Category.leisure: Icons.movie,
  Category.work: Icons.work
};

enum Category { food, travel, leisure, work }
