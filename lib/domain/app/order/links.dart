// To parse this JSON data, do
//
//     final links = linksFromMap(jsonString);

import 'dart:convert';

Links linksFromMap(String str) => Links.fromMap(json.decode(str));

String linksToMap(Links data) => json.encode(data.toMap());

class Links {
    Links({
        required this.first,
        required this.last,
    });

    String first;
    String last;

    factory Links.fromMap(Map<String, dynamic> json) => Links(
        first: json["first"],
        last: json["last"],
    );

    Map<String, dynamic> toMap() => {
        "first": first,
        "last": last,
    };
}
