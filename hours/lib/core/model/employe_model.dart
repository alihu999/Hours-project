import 'package:hive/hive.dart';
part 'employe_model.g.dart';

@HiveType(typeId: 0)
class Employe extends HiveObject {
  @HiveField(0)
  late String firstName;

  @HiveField(1)
  late String lastName;

  @HiveField(2)
  late String status;
}
