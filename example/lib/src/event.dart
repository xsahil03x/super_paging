import 'package:objectbox/objectbox.dart';

@Entity()
class Event {
  @Id()
  int id = 0;

  @Index()
  @Property(type: PropertyType.date)
  final DateTime timestamp;
  
  final String name;
  
  Event({
    required this.timestamp,
    required this.name
  });
}