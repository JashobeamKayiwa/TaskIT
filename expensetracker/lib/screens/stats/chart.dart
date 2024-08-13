import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class MyChart extends StatefulWidget {
  const MyChart({super.key});

  @override
  State<MyChart> createState() => _MyChartState();
}

class _MyChartState extends State<MyChart> {
  @override
  Widget build(BuildContext context) {
    return BarChart(
      mainBarChart(),
    );
  }

  BarChartGroupData makeGroupData(int x ,double y){
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
            gradient:LinearGradient(
            colors:[
            Theme.of(context).colorScheme.primary,
            Theme.of(context).colorScheme.secondary,
             Theme.of(context).colorScheme.tertiary,
           ],
           transform: const GradientRotation(pi / 4),
          ),

          width: 15,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 5,
            color: Colors.grey
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> showingGroupsM() => List.generate(8, (i){
    switch(i){
      case 0: 
      return makeGroupData(0,2);

      
      case 1: 
      return makeGroupData(1,3);

      case 2: 
      return makeGroupData(2,2);

      case 3: 
      return makeGroupData(3, 4.5);

      case 4: 
      return makeGroupData(4,3.8);

      case 5: 
      return makeGroupData(5, 1.5);

      case 6: 
      return makeGroupData(6,4);

      case 7: 
      return makeGroupData(7,3.8);

      default:
      return throw Error();
    }
  });
  

  BarChartData mainBarChart() {
    return BarChartData(
      titlesData:  FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: true,
          reservedSize: 38,
          getTitlesWidget: getTiles
          ),
        ),
        leftTitles:  AxisTitles(
          sideTitles: SideTitles(showTitles: true,
          reservedSize: 38,
          getTitlesWidget: leftTiles
          ),
          
        ),
        
      ),
      borderData: FlBorderData(show: true,),
      gridData: const FlGridData(show: true),
      barGroups: showingGroupsM(),
    );
  }

  Widget getTiles(double value, TitleMeta meta){
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
  Widget text;

  switch (value.toInt()) {
    case 0:
    text = const Text('01', style: style,);
      break;

    case 1:
    text = const Text('02', style: style,);
       break;
       

    case 2:
    text = const Text('03', style: style,);
       break;
       
    case 3:
    text = const Text('04', style: style,);
       break;
       
    case 4:
    text = const Text('05', style: style,);
      
    case 5:
    text = const Text('06', style: style,);
       break;
       
    case 6:
    text = const Text('07', style: style,);
       break;
       
    case 7:
    text = const Text('08', style: style,);
      
      break;
    default:
     text = const Text('?', style: style); 
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 16,
    child: text,
    );
  }

  Widget leftTiles(double value, TitleMeta meta){
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text;
    if (value == 0){
      text = 'UGX 1000';
    }
     else if (value == 1){
      text ='UGX 1500';
  }
    else if (value == 2){
      text ='UGX 2000';
  }
    else if (value == 3){
      text ='UGX 3000';
  }
    else if (value == 4){
      text ='UGX 4000';
  }
    else if (value == 5){
      text ='UGX 5000';
  }

   else if (value == 6){
      text ='UGX 2000';
  }

   else if (value ==7 ){
      text ='UGX 4500';
  }
  else {
    // Default case to handle unexpected values
    return const SizedBox();
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 0,
    child: Text(text, style: style,),);
  }
}