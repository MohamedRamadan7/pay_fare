import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pay_fare/layout/client_pay_fare/cubit/cubit.dart';
import 'package:pay_fare/layout/client_pay_fare/cubit/states.dart';
import 'package:pay_fare/models/client_model/client_login_model.dart';
import 'package:pay_fare/modules/pay_fare/wallet/balance_card.dart';
import 'package:pay_fare/modules/qr/create_qr_screen.dart';
import 'package:pay_fare/shared/components/components.dart';
import 'package:pay_fare/shared/components/constants.dart';
import 'package:pay_fare/shared/components/title_text.dart';
import 'package:pay_fare/shared/network/local/cache_helper.dart';
import 'package:pay_fare/shared/styles/colors.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit = AppCubit.get(context);
    cubit.getUserData();
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            body: state is AppSuccessUserDataState ||
                    state is AppSuccessClientHistoryState ||
                    state is AppChangeBottomNaveState ||
                    state is AppSuccessClientHistoryState ||
                    state is AppSuccessClientHistoryState ||
                    state is AppSuccessUserDataState
                ? SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: 130,
                                  ),
                                  Text(
                                    'welcome',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Divider(
                                thickness: 2,
                                indent: 60,
                                endIndent: 60,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 25.0,
                                backgroundImage: NetworkImage(
                                    'https://play-lh.googleusercontent.com/O6bNpvDPClvYntJEOxbM7w-UNtoJf0Xcj6JyY2zJZOYlkSd8F3AufC20SJXKUncqGxk=s200'),
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '${cubit.userModel!.user!.name}',
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    '${cubit.userModel!.user!.phone}',
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Icon(
                                Icons.short_text,
                                color: Theme.of(context).iconTheme.color,
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30.0,
                          ),
                          TitleText(text: "My wallet"),
                          SizedBox(
                            height: 20,
                          ),
                          BalanceCard(
                              balance: double.parse(
                                  '${AppCubit.get(context).userModel!.amount}')),
                          SizedBox(
                            height: 30.0,
                          ),
                          Text(
                            'Transaction',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          cubit.price.length!=0
                              ? Container(
                                  padding: EdgeInsets.symmetric(vertical: 20.0),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              'assets/images/minibus.png',
                                              height: 80,
                                              width: 80,
                                              //color: Colors.grey[600],
                                            ),
                                            SizedBox(
                                              width: 40.0,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      'EGP ${cubit.price[cubit.price.length - 1]} ',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,

                                                        color: Colors.white,
                                                        // fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    Text(
                                                      '- Go ',
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        // fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${cubit.date[cubit.date.length - 1]}',
                                                      maxLines: 1,
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 120,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.import_export,
                                                  color: Colors.blue,
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      '${cubit.from[cubit.from.length - 1]}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.white,
                                                        // fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15.0,
                                                    ),
                                                    Text(
                                                      '${cubit.to[cubit.to.length - 1]}',
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 20.0,
                                                        color: Colors.white,
                                                        // fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 15.0,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 350,
                                          child: MaterialButton(
                                            onPressed: () {
                                              AppCubit.get(context).getClientHistoryData();
                                            },
                                            child: Text(
                                              'Sow more',
                                              style: TextStyle(
                                                fontSize: 20.0,
                                                //fontWeight:FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              25,
                                            ),
                                            color: defaultColor,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10.0,
                                        ),
                                        Container(
                                          width: 350,
                                          child: MaterialButton(
                                            onPressed: () {

                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Icon(
                                                  Icons.history,
                                                  color: Colors.white,
                                                ),
                                                Text(
                                                  'View past rides',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20.0,
                                                    //fontWeight:FontWeight.bold,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              25,
                                            ),
                                            color: LightColor.navyBlue2,
                                          ),
                                        ),
                                      ]),
                                  decoration: BoxDecoration(
                                    color: LightColor.navyBlue1,
                                    // border: Border.all(color: defaultColor,
                                    //     width: 10),
                                    borderRadius: BorderRadius.circular(
                                      20.0,
                                    ),
                                  ),
                                )
                              : Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.menu,
                                        size: 80.0,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        ' There are no Trips ',
                                        style: TextStyle(
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ),
                  )
                : Center(child: CircularProgressIndicator()),
          );
        });
  }
}
