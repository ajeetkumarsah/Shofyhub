import 'package:equatable/equatable.dart';

class Link extends Equatable {
  final String? url;
  final String? label;
  final bool? active;

  const Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };

  @override
  List<Object?> get props => [
        url,
        label,
        active,
      ];
}
