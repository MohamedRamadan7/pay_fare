import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background= Colors.blue,
  Color fontColor= Colors.white,
  bool isUberCase= true,
  double radius=15.0,
  double fontSize=20.0,
  required Function function,
  required String text,
})=>Container(
  width: width,
  child: MaterialButton(
    onPressed:()=>function() ,
    child: Text(
      isUberCase ?text.toUpperCase():text,
      style: TextStyle(
        fontSize: fontSize,
        color: fontColor,
      ),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius,),
    color: background,
  ),
);

Function? validateFunc() => null;

class defaultFormFiled extends StatelessWidget {
  defaultFormFiled({
    this.lable = 'Username',
    this.ispassword = false,
    this.validation = validateFunc,
    this.onsumit= validateFunc,
    required this.controller,
    this.type = TextInputType.text,
    this.sufixpressd,
    this.suffix,
    this.fixIcon,
    this.radius = 15.0,
  });
  final String lable;
  final bool ispassword;
  final Function validation;
  final Function onsumit;
  final TextEditingController controller;
  final TextInputType type;
  final Function? sufixpressd;
  final IconData? suffix;
  final IconData? fixIcon;
  final double radius;


  @override
  Widget build(BuildContext context) {
    // App Theme
    var theme = Theme.of(context);

    //Check if dark mode enabled
    bool darkModeOn = theme.brightness == Brightness.dark;

    //Main Text Field Color
    Color? color = darkModeOn ? Color(0xff252A34) : Colors.white;

    //Main Text Field border
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      // borderRadius: BorderRadius.circular(15),
      borderRadius: BorderRadius.circular(radius),
      // borderSide: BorderSide(color: color!),
    );

    return TextFormField(
      validator: (value) => validation(value!),
      onFieldSubmitted: (value) => onsumit(value),
      keyboardType: type,
      obscureText: ispassword,
      controller: controller,
      style: TextStyle(
        color: darkModeOn ? Color(0xffE9EAEF) : Colors.grey[900],
        fontSize: 17,
        fontWeight: FontWeight.w400,
      ),
      decoration: InputDecoration(
        hintText: lable,
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 17,
          letterSpacing: 1,
          fontWeight: FontWeight.w400,
        ),
        //contentPadding: EdgeInsets.symmetric(horizontal: 35, vertical: 25),
        filled: true,
        fillColor: color,
        border: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        // errorBorder: outlineInputBorder.copyWith(
        //   borderSide: BorderSide(color: Colors.red[700]!),
        // ),
        focusedBorder: outlineInputBorder,
        // focusedErrorBorder: outlineInputBorder.copyWith(
        //   borderSide: BorderSide(color: Colors.red[700]!),
        // ),
        prefixIcon: Icon(fixIcon),
        suffixIcon: sufixpressd != null || suffix != null
            ? IconButton(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onPressed: () => sufixpressd!(),
              icon: Icon(suffix),
        )
            : null,
      ),
    );
  }
}
// Widget defaultFormFiled({
//   required TextEditingController controller,
//   required TextInputType type,
//   required String lable,
//   IconData? fixIcon,
//   IconData? suffix,
//   bool ispassword= false,
//   Function? onChanged,
//   Function? onsumit,
//   Function? ontap,
//   Function? validation,
//   Function? sufixpressd,
//   bool isClicable = true,
//   bool readOny=false,
//   double radius=15.0,
//   Color? color,
// })=>TextFormField(
//   readOnly: readOny,
//   controller:controller,
//   keyboardType:type,
//   obscureText: ispassword,
//   onFieldSubmitted:(value)=>onsumit!(value),
//   onChanged: (value)=>onChanged!(value),
//   onTap: ()=>ontap!(),
//   enabled:isClicable ,
//   validator: (value)=>validation!(value),
//   decoration:InputDecoration(
//     prefixIcon: Icon(
//         fixIcon,
//       color: color,
//     ),
//     suffixIcon:  suffix != null? IconButton(
//       onPressed:()=>sufixpressd!() ,
//       icon: Icon(
//           suffix
//       ),
//     ) : null,
//     labelText: lable,
//     border: OutlineInputBorder(
//       borderRadius:BorderRadius.circular(radius,),
//     ),
//
//   ),
//
// );

// class DropDownFormField extends FormField<dynamic> {
//   final String titleText;
//   final String hintText;
//   final bool required;
//   final String errorText;
//   final dynamic value;
//   final List dataSource;
//   final String textField;
//   final String valueField;
//   final Function onChanged;
//   final bool filled;
//   final EdgeInsets contentPadding;
//
//   DropDownFormField(
//       {FormFieldSetter<dynamic>? onSaved,
//         FormFieldValidator<dynamic>? validator,
//         AutovalidateMode autovalidate = AutovalidateMode.disabled,
//         this.titleText = 'Title',
//         this.hintText = 'Select one option',
//         this.required = false,
//         this.errorText = 'Please select one option',
//         this.value,
//         required this.dataSource,
//         required this.textField,
//         required this.valueField,
//         required this.onChanged,
//         this.filled = true,
//         this.contentPadding = const EdgeInsets.fromLTRB(12, 12, 8, 0)})
//       : super(
//     onSaved: onSaved,
//     validator: validator,
//     autovalidateMode: autovalidate,
//     initialValue: value == '' ? null : value,
//     builder: (FormFieldState<dynamic> state) {
//       return Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             InputDecorator(
//               decoration: InputDecoration(
//                 contentPadding: contentPadding,
//                 labelText: titleText,
//                 filled: filled,
//               ),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<dynamic>(
//                   isExpanded: true,
//                   hint: Text(
//                     hintText,
//                     style: TextStyle(color: Colors.grey.shade500),
//                   ),
//                   value: value == '' ? null : value,
//                   onChanged: (dynamic newValue) {
//                     state.didChange(newValue);
//                     onChanged(newValue);
//                   },
//                   items: dataSource.map((item) {
//                     return DropdownMenuItem<dynamic>(
//                       value: item[valueField],
//                       child: Text(item[textField],
//                           overflow: TextOverflow.ellipsis),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//             // SizedBox(height: state.hasError ? 5.0 : 0.0),
//             // Text(
//             //   state.hasError ? state.errorText : '',
//             //   style: TextStyle(
//             //       color: Colors.redAccent.shade700,
//             //       fontSize: state.hasError ? 12.0 : 0.0),
//             // ),
//           ],
//         ),
//       );
//     },
//   );
// }


Widget MyDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20.0),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);


Widget buildArticaleItem(artical , context) => InkWell(
  onTap: ()
  {
   // navigateTo(context, WebViewScreen(artical['url']));
  },
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            image: DecorationImage(
              image: NetworkImage('${artical['urlToImage']}'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Container(
            height: 120 ,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    '${artical['title']}',
                    style:Theme.of(context).textTheme.bodyText1,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '${artical['publishedAt']}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ),
);



void navigateTo(context, widget) =>Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context)=>widget,));

void navigateAndFinish(context, widget) =>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
        builder: (context)=>widget),
        (route) => false);

void showToast({
  required String text,
  required ToastStates state})=> Fluttertoast.showToast(
msg: text,
toastLength: Toast.LENGTH_LONG,
gravity: ToastGravity.BOTTOM,
timeInSecForIosWeb: 5,
backgroundColor: chooseToastColor(state),
textColor: Colors.white,
fontSize: 16.0);
enum ToastStates{SUCCESS,ERROR,WARNING}
Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state)
  {
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
  }
  return color;
}
