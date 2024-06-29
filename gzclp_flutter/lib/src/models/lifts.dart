import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';

part 'lifts.g.dart';

enum RepScheme {
  defaultScheme,
  modified;
}

abstract class Lift {
  String get name;
  int get weight;
  RepScheme get repScheme;
  BuiltList<int> get weightIncrements;
}

abstract class LiftWithWarmups extends Lift {
  int get warmupCount;
}

abstract class Tier1Lift implements Built<Tier1Lift, Tier1LiftBuilder>, LiftWithWarmups {
  Tier1Lift._();
  factory Tier1Lift([void Function(Tier1LiftBuilder) updates]) = _$Tier1Lift;
}

abstract class Tier2Lift implements Built<Tier2Lift, Tier2LiftBuilder>, LiftWithWarmups {
  Tier2Lift._();
  factory Tier2Lift([void Function(Tier2LiftBuilder) updates]) = _$Tier2Lift;
}

abstract class Tier3Lift implements Built<Tier3Lift, Tier3LiftBuilder>, Lift {
  Tier3Lift._();
  factory Tier3Lift([void Function(Tier3LiftBuilder) updates]) = _$Tier3Lift;
}
