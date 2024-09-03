import 'package:clean_api/clean_api.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:search_choices/search_choices.dart';
import 'package:alpesportif_seller/domain/app/form/key_value_data.dart';

class MultipleKeyValueSelector extends HookWidget {
  final IList<KeyValueData> allData;
  final IList<KeyValueData> initialData;
  final String title;
  final void Function(IList<KeyValueData> selectedData) onSelect;
  const MultipleKeyValueSelector(
      {Key? key,
      required this.title,
      required this.allData,
      required this.onSelect,
      this.initialData = const IListConst([])})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<List<int>> selectedItems = useState([]);

    useEffect(() {
      final idList = initialData.map((element) => element.key).toIList();

      final initIndexes = allData
          .asMap()
          .where((index, value) => idList.contains(value.key))
          .keys
          .toList();
      selectedItems.value = initIndexes;
      return null;
    }, []);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: SearchChoices<KeyValueData>.multiple(
        underline: const SizedBox.shrink(),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 10),
        items: List<DropdownMenuItem<KeyValueData>>.from(
            allData.map<DropdownMenuItem<KeyValueData>>(
                (e) => DropdownMenuItem<KeyValueData>(
                      value: e,
                      child: Text(
                        e.value,
                        textDirection: TextDirection.rtl,
                      ),
                    ))),
        selectedItems: selectedItems.value,
        hint: Text(
          title,
        ),
        searchHint: title,
        onChanged: (List<int> value) {
          selectedItems.value = value;
          final selectedData =
              value.map((element) => allData[element]).toIList();
          Logger.i(selectedData);
          onSelect(selectedData);
        },
        closeButton: (selectedItems) {
          return (selectedItems.isNotEmpty
              ? "Save ${selectedItems.length == 1 ? '"${allData[selectedItems.first].value}"' : '(${selectedItems.length})'}"
              : "Save without selection");
        },
        isExpanded: true,
      ),
    );
  }
}
