import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_fare/layout/driver_pay_fare/cubit/cubit.dart';
import 'package:pay_fare/layout/driver_pay_fare/cubit/states.dart';
import 'package:pay_fare/shared/components/components.dart';
import 'package:pay_fare/shared/styles/colors.dart';

class DriverNotificationsScreen extends StatelessWidget {
  var ScanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverCubit, DriverStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seats ',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,

                      color: Colors.black,
                      // fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Container(
                    //color: defaultColor,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        crossAxisCount: 3,
                        reverse: true,
                        mainAxisSpacing: 1.0,
                        crossAxisSpacing: 1.0,
                        childAspectRatio: 1 / 0.7,
                        children: List.generate(
                          14,
                          (index) => buildGridProducts(index, context),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Divider(thickness: 2, indent: 30, endIndent: 30),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: defaultButton(
                        radius: 30,
                        width: 180,
                        function: () {
                          DriverCubit.get(context).chair.clear();
                         DriverCubit.get(context).getChairData(int.parse('${DriverCubit.get(context).driverModel!.car!.id}'));
                         // print(double.parse('${DriverCubit.get(context).driverModel!.amount}'));
                          //  navigateTo(context, widget);
                          DriverCubit.get(context).RestChairs(id: int.parse('${DriverCubit.get(context).driverModel!.car!.id}'));
                          DriverCubit.get(context).getCarTripsData(int.parse('${DriverCubit.get(context).driverModel!.car!.id}'));
                        },
                        text: 'reset',
                        isUberCase: true),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildGridProducts(int index, context) => Container(
        //color:defaultColor,
        child: Column(
          children: [
            Image.asset(
              'assets/images/car.png',
              height: 50,
              width: double.infinity,
              color: DriverCubit.get(context).chair[13-index]['status'] ==1 ? Colors.green : Colors.grey[600],
            ),
            Text('chair ${14 - index}'),
          ],
        ),
      );
}
