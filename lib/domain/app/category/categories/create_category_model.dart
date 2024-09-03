import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

import 'package:alpesportif_seller/domain/app/form/key_value_data.dart';

class CreateCategoryModel extends Equatable {
  final int categorySubGroupId;
  final String name;
  final String slug;
  final String description;
  final String metaTitle;
  final String metaDescription;
  final IList<KeyValueData> attribute;
  final int active;
  final String order;
  const CreateCategoryModel({
    required this.categorySubGroupId,
    required this.name,
    required this.slug,
    required this.description,
    required this.metaTitle,
    required this.metaDescription,
    required this.attribute,
    required this.active,
    required this.order,
  });

  CreateCategoryModel copyWith({
    int? categorySubGroupId,
    String? name,
    String? slug,
    String? description,
    String? metaTitle,
    String? metaDescription,
    IList<KeyValueData>? attribute,
    int? active,
    String? order,
  }) {
    return CreateCategoryModel(
      categorySubGroupId: categorySubGroupId ?? this.categorySubGroupId,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      metaTitle: metaTitle ?? this.metaTitle,
      metaDescription: metaDescription ?? this.metaDescription,
      attribute: attribute ?? this.attribute,
      active: active ?? this.active,
      order: order ?? this.order,
    );
  }

  String get attributesEndPoint =>
      attribute.map((data) => "attribute_ids[]=${data.key}").join('&');
  String get endpoint =>
      'category/create?category_sub_group_id=$categorySubGroupId&name=$name&slug=$slug&meta_title=$metaTitle&meta_description=$metaDescription&$attributesEndPoint&active=$active&order=$order';

  @override
  List<Object> get props {
    return [
      categorySubGroupId,
      name,
      slug,
      description,
      metaTitle,
      metaDescription,
      attribute,
      active,
      order,
    ];
  }

  @override
  String toString() {
    return 'CreateCategoryModel(categorySubGroupId: $categorySubGroupId, name: $name, slug: $slug, description: $description, metaTitle: $metaTitle, metaDescription: $metaDescription, attribute: $attribute, active: $active, order: $order)';
  }
}
