import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:zcart_vendor/presentation/widget_for_all/color.dart';

class ChartDashBoardPage extends StatelessWidget {
  const ChartDashBoardPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Map<String, double> dataMap = {
      "Kousik": 51,
      "Tanvir": 20,
      "Sifat": 17,
      "Istiak": 12,
    };

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        toolbarHeight: 60.h,
        backgroundColor: MyColor.appbarColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(22.r),
          ),
        ),
        title: const Text('Dashboard'),
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.menu),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pie Chart',
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.h),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: PieChart(
                  dataMap: dataMap,
                  animationDuration: const Duration(seconds: 6),
                  chartLegendSpacing: 50,
                  chartRadius: MediaQuery.of(context).size.width / 2.5,
                  colorList: const [
                    Colors.green,
                    Colors.blue,
                    Colors.red,
                    Colors.orange
                  ],
                  initialAngleInDegree: 0,
                  chartType: ChartType.ring,
                  ringStrokeWidth: 25,
                  centerText: "Pie Chart",
                  legendOptions: const LegendOptions(
                    showLegendsInRow: false,
                    legendPosition: LegendPosition.right,
                    showLegends: true,
                    legendShape: BoxShape.circle,
                    legendTextStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  chartValuesOptions: const ChartValuesOptions(
                    showChartValueBackground: true,
                    showChartValues: true,
                    showChartValuesInPercentage: false,
                    showChartValuesOutside: false,
                    decimalPlaces: 2,
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                'Line Chart',
                style: TextStyle(
                  fontSize: 30.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 15.h),
//               Container(
//                 height: 500,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.withOpacity(0.5),
//                   borderRadius: BorderRadius.circular(20.r),
//                 ),
//                 child: Echarts(
//                   option: '''
//    {
//   title: {
//     text: 'Temperature Change'
//   },
//   tooltip: {
//     trigger: 'axis'
//   },
//   legend: {},
//   toolbox: {
//     show: true,
//     feature: {
//       dataZoom: {
//         yAxisIndex: 'none'
//       },
//       dataView: { readOnly: false },
//       magicType: { type: ['line', 'bar'] },
//       restore: {},
//       saveAsImage: {}
//     }
//   },
//   xAxis: {
//     type: 'category',
//     boundaryGap: false,
//     data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
//   },
//   yAxis: {
//     type: 'value',
//     axisLabel: {
//       formatter: '{value} °C'
//     }
//   },
//   series: [
//     {
//       name: 'Highest',
//       type: 'line',
//       data: [10, 11, 13, 11, 12, 12, 16],
//       markPoint: {
//         data: [
//           { type: 'max', name: 'Max' },
//           { type: 'min', name: 'Min' }
//         ]
//       },
//       markLine: {
//         data: [{ type: 'average', name: 'Avg' }]
//       }
//     },
//     {
//       name: 'Lowest',
//       type: 'line',
//       data: [1, -2, 2, 5, 3, 2, 0],
//       markPoint: {
//         data: [{ name: '周最低', value: -2, xAxis: 1, yAxis: -1.5 }]
//       },
//       markLine: {
//         data: [
//           { type: 'average', name: 'Avg' },
//           [
//             {
//               symbol: 'none',
//               x: '90%',
//               yAxis: 'max'
//             },
//             {
//               symbol: 'circle',
//               label: {
//                 position: 'start',
//                 formatter: 'Max'
//               },
//               type: 'max',
//               name: '最高点'
//             }
//           ]
//         ]
//       }
//     }
//   ]
// }
//   ''',
//                 ),
//               ),
            ],
          ),
        ),
      ),
    );
  }
}
