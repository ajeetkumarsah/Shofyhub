import 'package:equatable/equatable.dart';

class Links extends Equatable {
  final String? first;
  final String? last;
  final dynamic prev;
  final String? next;

  const Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };

  @override
  List<Object?> get props => [
        first,
        last,
        prev,
        next,
      ];
}
