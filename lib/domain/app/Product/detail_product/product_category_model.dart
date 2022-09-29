import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  const Categories({
    required this.name,
  });

  final String name;

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        name: json["4"],
      );

  Map<String, dynamic> toJson() => {
        "4": name,
      };

  factory Categories.init() => const Categories(name: '');

  @override
  List<Object?> get props => [name];
}
