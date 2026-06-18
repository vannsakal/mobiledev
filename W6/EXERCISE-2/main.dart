import 'package:flutter/material.dart';
import 'package:projects/W6-Start/EXERCISE-2/data/profile_data.dart';

import 'ui/screens/profile.dart';
 
void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ProfileApp(profileData: ronanProfile),
  ));
}
