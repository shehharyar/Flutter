
import 'package:meals_app_updated/data/dummy_data.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final mealsProvider = Provider((ref){
    return dummyMeals;
  }
 );