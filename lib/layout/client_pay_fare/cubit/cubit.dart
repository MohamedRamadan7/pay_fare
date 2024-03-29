import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_fare/layout/client_pay_fare/cubit/states.dart';
import 'package:pay_fare/models/car_model/get_chair_model.dart';
import 'package:pay_fare/models/car_model/qr_code.dart';
import 'package:pay_fare/models/client_model/client_history_model.dart';
import 'package:pay_fare/models/client_model/client_login_model.dart';
import 'package:pay_fare/models/client_model/client_send_balance_model.dart';
import 'package:pay_fare/models/client_model/client_wallet_model.dart';
import 'package:pay_fare/models/client_model/payfare_model.dart';
import 'package:pay_fare/modules/pay_fare/help/help_screen.dart';
import 'package:pay_fare/modules/pay_fare/home/home_screen.dart';
import 'package:pay_fare/modules/pay_fare/profile/profile_screen.dart';
import 'package:pay_fare/modules/pay_fare/scan/scan_screen.dart';
import 'package:pay_fare/modules/pay_fare/wallet/walet_screen.dart';
import 'package:pay_fare/shared/components/constants.dart';
import 'package:pay_fare/shared/network/end_points.dart';
import 'package:pay_fare/shared/network/local/cache_helper.dart';
import 'package:pay_fare/shared/network/remote/dio_helper.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;
  late double balance ;
  double amountToPay = 0.0 ;

  List<Widget> bottomScreen = [
    HomeScreen(),
    ScanScreen(),
    HelpScreen(),
    WalletScreen(),
    ProfileScreen(),
  ];

  List<String> titles = [
    'Home',
    'Scan',
    'Help',
    'Wallet',
    'Profile',
  ];

  void changeBottomNave(index) {
    currentIndex = index;
    emit(AppChangeBottomNaveState());
  }
late List chairListTest = [

  {
    "index":0,
    "check":false,
    "booked":false
  },{
    "index":1,
    "check":false,
    "booked":false
  },{
    "index":2,
    "check":false,
    "booked":false
  },{
    "index":3,
    "check":false,
    "booked":false
  },{
    "index":4,
    "check":false,
    "booked":false
  },{
    "index":5,
    "check":false,
    "booked":false
  },{
    "index":6,
    "check":false,
    "booked":false
  },{
    "index":7,
    "check":false,
    "booked":false
  },{
    "index":8,
    "check":false,
    "booked":false
  },{
    "index":9,
    "check":false,
    "booked":false
  },{
    "index":10,
    "check":false,
    "booked":false
  },{
    "index":11,
    "check":false,
    "booked":false
  },{
    "index":12,
    "check":false,
    "booked":false
  },{
    "index":13,
    "check":false,
    "booked":false
  },
];
  // late Map<int, bool> colorChair = {
  //   0: false,
  //   1: false,
  //   2: false,
  //   3: false,
  //   4: false,
  //   5: false,
  //   6: false,
  //   7: false,
  //   8: false,
  //   9: false,
  //   10: false,
  //   11: false,
  //   12: false,
  //   13: false,
  // };
  void changeChair(int index) {

    // colorChair[index] = !colorChair[index]!;
    chairListTest[13-index]['check'] = !chairListTest[13-index]['check']!;

    // for(var item in chairListTest){
    //   print(item['check']);
    // }
    amountToPay +=chairListTest[13-index]['check']?qrModel!.price!:-qrModel!.price!;
    //colorChair.update(index, (value) => !value);
    //CacheHelper.saveData(key: 'chair', value:colorChair[index] );
    CacheHelper.saveData(key: 'chair', value: chairListTest[index]['check']).then((value) {
      emit(AppChangeChairStaState());
    });
  }

  var qrstr = "let's Scan it";

  Future<void> scanQr() async {
    try {
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR)
          .then((value) {
        qrstr = value;
        emit(AppScanState());
      });
    } catch (e) {
      qrstr = 'unable to read this';
      emit(AppScanErrorState());
    }
  }

  ClientLoginModel? userModel;
  void getUserData() {
    //emit(AppLoadingGrtDataState());
    DioHelper.getData(url: PROFILE, query: {
      'id':'${CacheHelper.getData(key: 'clientId')}',
    }).then((value) {
      userModel = ClientLoginModel.fromJson(value.data);
      print(userModel!.user!.phone);
      emit(AppSuccessUserDataState(userModel!));
      getClientHistoryData();
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorUserDataState());
    });
  }

  ClientWalletModel? walletModel;
  void putWalletData({
    required int id,
    required double funds,
  })
  {
    //emit(AppLoadingGrtDataState());
    DioHelper.putData(url:ADDWALLET, data: {
      'id':id,
      'amount':funds,
    }
     ).then((value) {
       walletModel = ClientWalletModel.fromJson(value.data);
       print(value.data);
      emit(AppSuccessWalletDataState());
    }).catchError((error) {
       print(error.toString());
      emit(AppErrorWalletDataState());
     });
  }

  ClientSendBalanceModel? sendBalanceModel;

  void putSendBalanceData({
    required int id,
    required String phone,
    required double amount,
  })
  {
    emit(AppLoadingSendBalanceState());
    DioHelper.putData(url:SENDAMOUNT,query: {
      'id':id,
      'phone':phone,
      'amount':amount,

    }
    ).then((value) {
      sendBalanceModel = ClientSendBalanceModel.fromJson(value.data);
      print(value.data);
      emit(AppSuccessSendBalanceState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorSendBalanceState());
    });
  }

  // GetChair? chairModel;
  // void getChairData() {
  //   DioHelper.getData(url: GETCHAIR, query: {
  //     'id':'8',
  //   }).then((value) {
  //     chairModel = GetChair.fromJson(value.data);
  //     //List<Map<String, dynamic>> map =value.data;
  //     //print(map);
  //     print(chairModel!.chairNumber);
  //     print(chairModel!.status);
  //     emit(AppSuccessChairDataState(chairModel!));
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(AppErrorChairDataState());
  //   });
  // }

  QrModel? qrModel;
  void getQrData() {
    DioHelper.getData(url: QRCODE, query: {
      'qrcode':'${qrstr}',
    }).then((value) {
      qrModel = QrModel.fromJson(value.data);
      print(qrModel!.price);
      getChairData(qrModel!.carId!);
      emit(AppSuccessQrDataState(qrModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorQrDataState());
    });
  }

  PayfareModel? payfareModel;

  void putPayfare({
    required int clientId,
    required int carId,
    required String driverPhone,
    required double amount,
    required List<dynamic> chair,

  })
  {
    emit(AppLoadingPayfareState());
    DioHelper.putPayfareData(url:PAYFARE,query: {
      'clientId':clientId,
      'carId':carId,
      'driverPhone':driverPhone,
      'amount':amount,

    },
      data: chair
    ).then((value) {

      payfareModel = PayfareModel.fromJson(value.data);
      print(value.data);
      amountToPay=0;
      getChairData(qrModel!.carId!);
      emit(AppSuccessPayfareState());
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorPayfareState());
    });
  }

  List<String> date = [];
  List<String> price = [];
  List<String> from = [];
  List<String> to = [];

  ClientRidesHistoryModel? clientRidesHistoryModel;
  void getClientHistoryData() {

    DioHelper.getData(url: CLIENTHISTORY,
        query: {
      'id':int.parse('${userModel!.id}')
        }

    ).then((value) {
      date.clear();
      price.clear();
      from.clear();
      to.clear();

      for (var item in value.data) {
        //print(item['id']);
        clientRidesHistoryModel = ClientRidesHistoryModel.fromJson(item);
        //stationnew.add(item);
        date.add(clientRidesHistoryModel!.date.toString());
        //print(date);
        price.add(clientRidesHistoryModel!.amountPay.toString());
        from.add(clientRidesHistoryModel!.from.toString());
        to.add(clientRidesHistoryModel!.to.toString());
        //print(date);
      }
      //clientRidesHistoryModel stm1 =  ClientRidesHistoryModel.fromJson(stationnew[0]);
      //print(stm1.id);
      emit(AppSuccessClientHistoryState(clientRidesHistoryModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorClientHistoryState());
    });
  }

  GetChair? chairModel;
  List <Map<String,dynamic>> chair=[];
  void getChairData(int carid) {
    DioHelper.getData(url: GETCHAIR, query: {
      'id':carid,
    }).then((value) {
      //chairModel = GetChair.fromJson(value.data);
      for (var item in value.data) {
        //print(item['id']);
        chairModel = GetChair.fromJson(item);
        // colorChair.update(13 - chairModel!.chairNumber!, (value) => chairModel!.status==1?true:false);
        chairListTest[chairModel!.chairNumber!-1]['booked']=chairModel!.status==1?true:false;
        print("staaaaaate ${chairListTest[chairModel!.chairNumber!-1]['booked']}");

        chair.add(item);
      }
      GetChair stm1 =  GetChair.fromJson(chair[5]);
      // for(var item in chair)
      //   {
      //     print(item['status']);
      //   }


      // print(chairModel!.status);
      emit(AppSuccessgetChairDataState(chairModel!));
    }).catchError((error) {
      print(error.toString());
      emit(AppErrorgetChairDataState());
    });
  }

List<int> chairs=[];
  void Pay(index)
  {
    amountToPay= qrModel!.price! * index;
  }

}




