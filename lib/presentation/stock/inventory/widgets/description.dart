import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:alpesportif_seller/models/inventory/inventory_details_model.dart'
    as idm;

class DescriptionTile extends StatelessWidget {
  final String description;
  final List<idm.Image>? images;
  const DescriptionTile({
    Key? key,
    required this.description,
    this.images,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (images != null && images!.isNotEmpty)
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Image.network(
                        images![index].path ?? "",
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                color: const Color(0xFF4D4D4D),
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
