import 'package:objectbox/objectbox.dart';

@Entity()
class MotorCycle {
  @Id()
  int motorcycleId;

  @Unique()
  final String serialNumber;

  final String name;

  final String releaseYear;

  MotorCycle(
      {this.motorcycleId = 0,
      required this.serialNumber,
      required this.name,
      required this.releaseYear});
}
