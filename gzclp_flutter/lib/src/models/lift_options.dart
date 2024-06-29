import 'package:built_value/built_value.dart';

part 'lift_options.g.dart';

abstract class LiftOption implements Built<LiftOption, LiftOptionBuilder> {
  LiftOption._();
  factory LiftOption([void Function(LiftOptionBuilder) updates]) = _$LiftOption;

  String get name;
}
