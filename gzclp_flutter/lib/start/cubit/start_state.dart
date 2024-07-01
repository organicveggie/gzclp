part of 'start_cubit.dart';

final class StartState extends Equatable {
  const StartState({
    this.pageIndex = 0,
  });

  final int pageIndex;

  @override
  List<Object> get props => [pageIndex];
}
