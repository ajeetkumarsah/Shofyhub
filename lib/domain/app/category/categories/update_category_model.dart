import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:zcart_seller/domain/app/form/key_value_data.dart';

class UpdateCategoryModel extends Equatable {
  final int id;
  final int categorySubGroupId;
  final String name;
  final String slug;
  final String description;
  final IList<KeyValueData> attributes;
  final int active;
  const UpdateCategoryModel({
    required this.id,
    required this.categorySubGroupId,
    required this.name,
    required this.slug,
    required this.description,
    required this.attributes,
    required this.active,
  });

  UpdateCategoryModel copyWith({
    int? id,
    int? categorySubGroupId,
    String? name,
    String? slug,
    String? description,
    IList<KeyValueData>? attributes,
    bool? active,
  }) {
    return UpdateCategoryModel(
      id: id ?? this.id,
      categorySubGroupId: categorySubGroupId ?? this.categorySubGroupId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      attributes: attributes ?? this.attributes,
      active: this.active,
    );
  }

  String get attributesEndPoint =>
      attributes.map((data) => "attribute_ids[]=${data.key}").join('&');
  String get endpoint =>
      'category/$id/update?category_sub_group_id=$categorySubGroupId&name=$name&slug=$slug&description=$description&attribute_ids[]=$attributesEndPoint&active=$active';

  @override
  String toString() {
    return 'UpdateCategoryModel(id: $id, categorySubGroupId: $categorySubGroupId, name: $name, slug: $slug, description: $description, attributes: $attributes, active: $active)';
  }

  @override
  List<Object> get props {
    return [
      id,
      categorySubGroupId,
      name,
      slug,
      description,
      attributes,
      active,
    ];
  }
}
