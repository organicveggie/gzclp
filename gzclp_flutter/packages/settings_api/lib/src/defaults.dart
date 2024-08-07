import 'package:built_collection/built_collection.dart';

import 'models/exercise.dart';

final defaultTier1Exercises = BuiltSet<Exercise>.of([
  Exercise.byName('Bench Press'),
  Exercise.byName('Deadlift'),
  Exercise.byName('Overhead Press'),
  Exercise.byName('Squat'),
]);

final defaultTier2Exercises = BuiltSet<Exercise>.of([
  Exercise.byName('Bench Press'),
  Exercise.byName('Barbell Row'),
  Exercise.byName('Close Grip Bench Press'),
  Exercise.byName('Deadlift'),
  Exercise.byName('Front Squat'),
  Exercise.byName('Incline Bench'),
  Exercise.byName('Legs Up Bench'),
  Exercise.byName('Overhead Press'),
  Exercise.byName('Paused Bench Press'),
  Exercise.byName('Squat'),
  Exercise.byName('Sumo Deadlift'),
]);

final defaultTier3Exercises = BuiltSet<Exercise>.of([
  Exercise.byName('Bicep Curls'),
  Exercise.byName('Cable Crunch'),
  Exercise.byName('Cable Row'),
  Exercise.byName('Calf Raises'),
  Exercise.byName('Chest Flyes'),
  Exercise.byName('Chest-Supported Row'),
  Exercise.byName('Close-Grip Pulldown'),
  Exercise.byName('DB Batwing Row'),
  Exercise.byName('DB Curls'),
  Exercise.byName('DB Hammer Curl'),
  Exercise.byName('DB Row'),
  Exercise.byName('DB Seated Press'),
  Exercise.byName('Dips (Weighted)'),
  Exercise.byName('Dips (Assisted)'),
  Exercise.byName('Dumbbell Pullover'),
  Exercise.byName('EZ Bar Curl'),
  Exercise.byName('EZ Bar Curl (Reverse)'),
  Exercise.byName('EZ Bar Pullover'),
  Exercise.byName('Face Pulls (Cable)'),
  Exercise.byName('Flat DB Bench'),
  Exercise.byName('Glute Pull Through'),
  Exercise.byName('Goblet Squat'),
  Exercise.byName('Good Mornings'),
  Exercise.byName('Hammer Curl'),
  Exercise.byName('Hip Thrust'),
  Exercise.byName('Incline DB Bench Press'),
  Exercise.byName('Lateral Raises'),
  Exercise.byName('Lat Pulldowns'),
  Exercise.byName('Leg Curls'),
  Exercise.byName('Leg Extensions'),
  Exercise.byName('Leg Press'),
  Exercise.byName('Lunges'),
  Exercise.byName('Machine Pull-Over'),
  Exercise.byName('Machine Side Raise'),
  Exercise.byName('Rack Pull'),
  Exercise.byName('Rear Delt Flye'),
  Exercise.byName('Reverse Curls'),
  Exercise.byName('Romanian DL'),
  Exercise.byName('Seated DB Press'),
  Exercise.byName('Shrugs'),
  Exercise.byName('Side DB Raise'),
  Exercise.byName('Side Lateral'),
  Exercise.byName('Skull Crusher'),
  Exercise.byName('Split Squat'),
  Exercise.byName('Step Ups'),
  Exercise.byName('Tricep Extention'),
  Exercise.byName('Tricep Pushdowns (bar)'),
  Exercise.byName('Tricep Pushdowns (strap)'),
  Exercise.byName('Upright Row'),
  Exercise.byName('Weighted Hyperextensions'),
]);
