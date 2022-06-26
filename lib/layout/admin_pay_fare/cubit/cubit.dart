import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_fare/layout/admin_pay_fare/cubit/states.dart';
import 'package:pay_fare/models/car_model/post_car_model.dart';
import 'package:pay_fare/models/driver_model/post_driver_miodel.dart';
import 'package:pay_fare/models/owner_model/owner_model.dart';
import 'package:pay_fare/models/station_model.dart';
import 'package:pay_fare/models/trafic_model/trafic_model.dart';
import 'package:pay_fare/modules/admin_pay_fare/Arranging/admin_Arranging_screen.dart';
import 'package:pay_fare/modules/admin_pay_fare/add_driver/add_driver_screen.dart';
import 'package:pay_fare/modules/admin_pay_fare/home/admin_home_screen.dart';
import 'package:pay_fare/modules/admin_pay_fare/reports/admin_reports_screen.dart';
import 'package:pay_fare/modules/admin_pay_fare/ticket_price/ticket_price_screen.dart';
import 'package:pay_fare/shared/network/end_points.dart';
import 'package:pay_fare/shared/network/remote/dio_helper.dart';

class AdminCubit extends Cubit<AdminStates> {
  AdminCubit() : super(AdminInitialState());

  static AdminCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;
  List<Widget> bottomScreen = [
    AdminHomeScreen(),
    AdminArrangingScreen(),
    AdminAddDriverScreen(),
    AdminTicketPriceScreen(),
    AdminReportsScreen(),
  ];

  List<String> titles = [
    'Home',
    'Arranging',
    'Add driver',
    'Ticket Price',
    'Reports',
  ];

  void changeBottomNave(index) {
    currentIndex = index;
    emit(AdminChangeBottomNaveState());
  }

  List<String> station = [];
  List <Map<String,dynamic>> stationnew = [];

  List<String> from = [];
  List<String> to = [];
  String? valueStation;
  String? valueFrom;
  String? valueTo;
  String? valueOwner;
  List<String> owner = [];

  StationModel? stationModel;
  void getStationData() {
    DioHelper.getData(url: STATION).then((value) {
      station.clear();
      for (var item in value.data) {
        //print(item['id']);
        stationModel = StationModel.fromJson(item);
        stationnew.add(item);
        station.add(stationModel!.name.toString());
      }
      //StationModel stm1 =  StationModel.fromJson(stationnew[0]);
      //print(stm1.id);


      emit(AdminSuccessStationState(stationModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AdminErrorStationState());
    });
  }

  OwnerModel? ownerModel;
  void getOwnerData() {
    DioHelper.getData(url: OWNER).then((value) {
      owner.clear();
      for (var item in value.data) {
        //print(item['id']);
        ownerModel = OwnerModel.fromJson(item);
        //stationnew.add(item);
        owner.add(ownerModel!.fullName.toString());
        print(owner);
      }
      //StationModel stm1 =  StationModel.fromJson(stationnew[0]);
      //print(stm1.id);


      emit(AdminSuccessOwnerState(ownerModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AdminErrorOwnerState());
    });
  }

  TraficModel? traficmodel;
  void getTrafficData() {
    DioHelper.getData(url: TRAFFIC).then((value) {
      from.clear();
      to.clear();
      for (var item in value.data) {
        //print(item['id']);
        traficmodel = TraficModel.fromJson(item);
        //stationnew.add(item);
        from.add(traficmodel!.from.toString());
        to.add(traficmodel!.to.toString());
        print(from);
        print(to);
      }
      //StationModel stm1 =  StationModel.fromJson(stationnew[0]);
      //print(stm1.id);


      emit(AdminSuccessTrafficState(traficmodel!));
    }).catchError((error) {
      print(error.toString());
      emit(AdminErrorTrafficState());
    });
  }

  void onChangedDropdownMenuFrom(value) {
    valueFrom = value;
    emit(onChangedDropdownMenuState());
  }

  void onChangedDropdownMenuTo(value) {
    valueTo = value;
    emit(onChangedDropdownMenuState());
  }

  void onChangedDropdownMenuStation(value) {
    valueStation = value;
    emit(onChangedDropdownMenuState());
  }

  void onChangedDropdownMenuOwner(value) {
    valueOwner = value;
    emit(onChangedDropdownMenuState());
  }

  List pricies = [
    {
      "cityfrom": "mansoura",
      "cityto": "cairo",
      "price": 10,
    },
    {
      "cityfrom": "mansoura",
      "cityto": "Alex",
      "price": 22,
    },
    {
      "cityfrom": "mansoura",
      "cityto": "tanta",
      "price": 33,
    },
    {
      "cityfrom": "mansoura",
      "cityto": "Giza",
      "price": 44,
    },
    {
      "cityfrom": "mansoura",
      "cityto": "6 octobar",
      "price": 38,
    },
  ];

  void changePrice(index, value) {
    pricies[index]["price"] = value;
    emit(changePriceState());
  }


  PostDriver? postDriverModel;
  void driverRegister({
    required String name,
    required String username,
    required String phone,
    required String liceNum,
  })
  {

    DioHelper.postData(url: POSTDRIVER,
        data:{
          'liceNum':liceNum,
          'user':{
            'name':name,
            'userName':username,
            'phone':phone,
          }
        }
    ).then((value){
      print(value.data);
      postDriverModel = PostDriver.fromJson(value.data);

      emit(AdminPostDriverSuccessState(postDriverModel!));
    }).catchError((error){

      emit(AdminPostDriverErrorState(error.toString()));
      print('error is = ${error.toString()}');
    });
  }

  PostCarModel? postCarModel;
  void PostCar({
    required String carPlateNum,
    required String carCapacity,
    required String qrCode,
  })
  {

    DioHelper.postData(url: POSTCAR,
        data:{
          'carPlateNum':carPlateNum,
          'carCapacity':carCapacity,
          'qrCode':qrCode,
        }
    ).then((value){
      print(value.data);
      postCarModel = PostCarModel.fromJson(value.data);

      emit(AdminPostCarSuccessState(postCarModel!));
    }).catchError((error){

      emit(AdminPostCarErrorState(error.toString()));
      print('error is = ${error.toString()}');
    });
  }

}
