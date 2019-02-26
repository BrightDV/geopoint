import 'package:flutter/foundation.dart';

enum GeoSerieType { group, line, polygon }

/// A class to hold information about a serie of [GeoPoint]
class GeoSerie {
  GeoSerie({@required this.name, @required this.type, this.id})
      : assert(name != null),
        assert(type != null);

  final String name;
  final int id;
  GeoSerieType type;

  /// The type of the serie as a string
  String get typeStr => _typeToString();

  /// Make a [GeoSerie] from json data
  GeoSerie.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        id = json["id"] {
    type = _typeFromString(json["type"]);
  }

  /// [json] the json data to build from

  /// Make a [GeoSerie] from name and serie type
  GeoSerie.fromNameAndType(
      {@required this.name, String typeStr, this.type, this.id})
      : assert(typeStr != null || type != null) {
    if (type != null) this.type = _typeFromString(typeStr);
  }

  /// [name] the name of the [GeoSerie]
  /// [typeStr] the type of the serie: group, line or polygon
  /// [id] the id of the serie

  /// get a json map from this [GeoSerie]
  Map<String, String> toMap({bool withId: true}) {
    /// [withId] include the id in the result
    Map<String, String> json = {
      "name": "$name",
      "type": "${_typeToString(type)}",
    };
    if (withId) {
      json["id"] = "${this.id}";
    }
    return json;
  }

  GeoSerieType _typeFromString(String typeStr) {
    GeoSerieType res;
    switch (typeStr) {
      case "group":
        res = GeoSerieType.group;
        break;
      case "line":
        res = GeoSerieType.line;
        break;
      case "polygon":
        res = GeoSerieType.polygon;
    }
    return res;
  }

  String _typeToString([GeoSerieType st]) {
    GeoSerieType t;
    (st != null) ? t = st : t = type;
    String res;
    switch (t) {
      case GeoSerieType.group:
        res = "group";
        break;
      case GeoSerieType.line:
        res = "line";
        break;
      case GeoSerieType.polygon:
        res = "polygon";
    }
    return res;
  }
}
