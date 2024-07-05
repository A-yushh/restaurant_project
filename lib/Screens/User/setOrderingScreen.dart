import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:restaurant_app/Controller/Profile/profile_controller.dart';
import 'package:restaurant_app/Screens/User/documentationScreen.dart';
import 'package:restaurant_app/Screens/User/loginScreen.dart';
import 'package:restaurant_app/Screens/User/registrationCompleteScreen.dart';
import 'package:restaurant_app/Widgets/buttons/mainButton.dart';
import 'package:restaurant_app/Widgets/constants/colors.dart';
import 'package:restaurant_app/Widgets/constants/texts.dart';
import 'package:restaurant_app/Widgets/customs/User/registrationTimeline.dart';
import 'package:restaurant_app/Widgets/customs/User/uploadWidget.dart';
import 'package:restaurant_app/Widgets/input_fields/textInputField.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class SetOrderingScreen extends StatefulWidget {
  const SetOrderingScreen({super.key});

  @override
  State<SetOrderingScreen> createState() => _SetOrderingScreenState();
}

class _SetOrderingScreenState extends State<SetOrderingScreen> {
  List<String> cuisines = [
    "Chinese",
    "Momos",
    "Mughlai",
    "Mexican",
    "Arabic",
    "Bihari",
    "North Indian",
    "Thai",
    "South Indian",
    "Chaat",
    "Italian",
    "Cakes",
    "Bakery",
    "Sweets",
    "Himachali",
    "Bengali",
    "Nepali",
    "Continental",
    "Hyderabadi",
    "Gujrati",
    "Maharastrian"
  ];

  Map<String, bool> selectedCuisines = {};
  List<String> selectedCuisineList = [];
  TextEditingController controller = TextEditingController();
  bool isLoading = false;
  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  List<bool> isOpen = List.generate(7, (index) => false);
  late String uid;
  LocalController _getSavedData = LocalController();
  late Map<String, dynamic> userInfo;
  @override
  void initState() {
    super.initState();
    for (var cuisine in cuisines) {
      selectedCuisines[cuisine] = false;
    }
    getUserData();
    // getUid();
  }

  Future<void> getUid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userInfoString = prefs.getString('user_id');
    if (userInfoString != null) {
      setState(() {
        uid = userInfoString;
      });
    } else {
      return null;
    }
  }

  Future<void> getUserData() async {
    try {
      Map<String, dynamic>? getData = await _getSavedData.getUserInfo();
      setState(() {
        userInfo = getData!;
      });
    } catch (e) {
      print('Error: $e');
      // Handle error
    }
  }

  Future<void> saveUserInfo(Map<String, dynamic> userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_info', jsonEncode(userInfo));
    await signUp();
    // print(prefs.getString('user_info'));
  }

  routeRegistrationComplete() {
    if (controller.text.isNotEmpty) {
      userInfo['cuisines'] = [];
      userInfo['operationalHours'] = "8pm";
      userInfo['restaurantMenuImages'] = _imageRestaurantMenuImgPaths;
      userInfo['restaurantImages'] = imageRestaurantImgPath;
      userInfo['foodImages'] = imageFoodImgPath;
      saveUserInfo(userInfo);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorFailure,
          content: Text("All Fields is required")));
    }
  }

  void _updateSelectedCuisines(bool? value, String cuisine) {
    setState(() {
      if (selectedCuisineList.length < 3 || selectedCuisines[cuisine] == true) {
        selectedCuisines[cuisine] = value!;
        if (value == true) {
          selectedCuisineList.add(cuisine);
        } else {
          selectedCuisineList.remove(cuisine);
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("You can select up to 3 cuisines only."),
          ),
        );
      }
    });
  }

  Future<void> signUp() async {
    setState(() {
      isLoading = true;
    });
    try {
      var baseUrl = dotenv.env['BASE_URL'];
      String requestBody = jsonEncode(userInfo);
      // print(reqData);
      final response = await http.post(Uri.parse('$baseUrl/auth/signup'),
          headers: {
            'Content-Type': 'application/json',
          },
          body: requestBody);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        if (responseData != null && responseData['executed']) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: colorSuccess,
              content: Text("Signup Successfully")));
          setState(() {
            isLoading = false;
          });
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // Remove the data associated with the key 'user_info'
          await prefs.remove('user_info');
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const RegistrationCompleteScreen(),
            ),
          );
        } else {
          // RegistrationCompleteScreen
          setState(() {
            isLoading = false;
          });
          // SharedPreferences prefs = await SharedPreferences.getInstance();
          // // Remove the data associated with the key 'user_info'
          // await prefs.remove('user_info');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                backgroundColor: colorFailure,
                content: Text(responseData['message'])),
          );
        }
      } else {
        setState(() {
          isLoading = false;
        });
        // return "Failed to Update profile";
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: colorFailure, content: Text("Failed to Signup")));
        throw Exception('Failed to Signup');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: colorFailure, content: Text("Error: Server Error")));
      print('Error: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DocumentationScreen(),
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
            size: 20.sp,
          ),
        ),
        title: Text('Set for Ordering', style: h4TextStyle),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.red,
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const RegistrationTimeline(pageIndex: 3),
                  //   alignment: Alignment.center,
                  // child:
                  Align(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5.w, 1.h, 5.w, 2.h),
                      child: Text(
                        'Cuisines'.toUpperCase(),
                        style: titleTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                  Container(
                      margin: EdgeInsets.only(left: 3.w, right: 3.w),
                      padding:
                          EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: bgColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: textGrey2, width: 0.2.w),
                      ),
                      child: Column(
                        children: [
                          // DropdownButtonHideUnderline(
                          //   child: DropdownButton(
                          //     hint: Text("Select up to 3 cuisines"),
                          //     isExpanded: true,
                          //     items: [
                          //       DropdownMenuItem(
                          //         child: Column(
                          //           children: cuisines.map((cuisine) {
                          //             return CheckboxListTile(
                          //               title: Text(cuisine),
                          //               value: selectedCuisines[cuisine],
                          //               onChanged: (bool? value) {
                          //                 _updateSelectedCuisines(
                          //                     value, cuisine);
                          //               },
                          //             );
                          //           }).toList(),
                          //         ),
                          //       ),
                          //     ],
                          //     onChanged: (_) {},
                          //   ),
                          // ),

                          const SizedBox(height: 20),
                          if (selectedCuisineList.isNotEmpty)
                            Card(
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: selectedCuisineList.map((cuisine) {
                                    return ListTile(
                                      title: Text(cuisine),
                                      trailing: IconButton(
                                        icon: Icon(Icons.remove_circle),
                                        onPressed: () {
                                          setState(() {
                                            selectedCuisines[cuisine] = false;
                                            selectedCuisineList.remove(cuisine);
                                          });
                                        },
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 2.h),
                            child: textInputField(
                                'Cuisines', controller, (String input) => null),
                          ),
                        ],
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      child: Text(
                        'restaurant operational hours'.toUpperCase(),
                        style: titleTextStyle.copyWith(fontSize: 14.sp),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    margin: EdgeInsets.only(left: 3.w, right: 3.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: textGrey2, width: 0.2.w),
                    ),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Select restaurant opening days',
                            style: body4TextStyle.copyWith(color: textGrey3),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: SizedBox(
                            width: 100.w,
                            child: Wrap(
                              spacing: 0.5.h,
                              runSpacing: 0.5.h,
                              // alignment: WrapAlignment.spaceEvenly,
                              runAlignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: List.generate(
                                (daysOfWeek.length / 2).ceil(),
                                (rowIndex) {
                                  int startIndex = rowIndex * 2;
                                  int endIndex = startIndex + 1;
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      if (startIndex < daysOfWeek.length)
                                        Checkbox(
                                          value: isOpen[startIndex],
                                          onChanged: (newValue) {
                                            setState(() {
                                              isOpen[startIndex] = newValue!;
                                            });
                                          },
                                          activeColor: colorSuccess,
                                        ),
                                      if (startIndex < daysOfWeek.length)
                                        Text(
                                          daysOfWeek[startIndex],
                                          style: body3TextStyle.copyWith(
                                              fontSize: 12.sp),
                                        ),
                                      if (endIndex < daysOfWeek.length)
                                        Checkbox(
                                          value: isOpen[endIndex],
                                          onChanged: (newValue) {
                                            setState(() {
                                              isOpen[endIndex] = newValue!;
                                            });
                                          },
                                          activeColor: colorSuccess,
                                        ),
                                      if (endIndex < daysOfWeek.length)
                                        Text(
                                          daysOfWeek[endIndex],
                                          style: body3TextStyle.copyWith(
                                              fontSize: 12.sp),
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            'Select restaurant opening /closing time',
                            style: body4TextStyle.copyWith(color: textGrey3),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Opening',
                                  style: body5TextStyle.copyWith(
                                      color: colorSuccess,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7.w, vertical: 1.h),
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: colorFailure, width: 0.2.w),
                                    boxShadow: [
                                      BoxShadow(
                                        color: colordenger
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 2, // Spread radius
                                        blurRadius: 5, // Blur radius
                                        offset: Offset(0,
                                            2), // Offset in the x and y directions
                                      ),
                                    ],
                                  ),
                                  child: Stack(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/openRes.png',
                                          cacheWidth: 50,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          '09:30 AM',
                                          style: body5TextStyle.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 5,
                                      child: Text(
                                        'OPEN',
                                        style: body6TextStyle.copyWith(
                                            color: colorSuccess),
                                      ),
                                    )
                                  ]),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  'Closing',
                                  style: body5TextStyle.copyWith(
                                      color: colordenger,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w600),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7.w, vertical: 1.h),
                                  decoration: BoxDecoration(
                                    color: bgColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(
                                        color: colorFailure, width: 0.2.w),
                                    boxShadow: [
                                      BoxShadow(
                                        color: colordenger
                                            .withOpacity(0.5), // Shadow color
                                        spreadRadius: 2, // Spread radius
                                        blurRadius: 5, // Blur radius
                                        offset: Offset(0,
                                            2), // Offset in the x and y directions
                                      ),
                                    ],
                                  ),
                                  child: Stack(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Image.asset(
                                          'assets/images/closeRes.png',
                                          cacheWidth: 50,
                                        ),
                                        SizedBox(
                                          width: 2.w,
                                        ),
                                        Text(
                                          '10:30 PM',
                                          style: body5TextStyle.copyWith(
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                    Positioned(
                                      top: 10,
                                      left: 5,
                                      child: Text(
                                        'CLOSE',
                                        style: body6TextStyle.copyWith(
                                          color: colorFailure,
                                        ),
                                      ),
                                    )
                                  ]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      child: Text(
                        'add restaurant menu images'.toUpperCase(),
                        style: titleTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    margin: EdgeInsets.only(left: 3.w, right: 3.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: textGrey2, width: 0.2.w),
                    ),
                    child: Column(
                      children: [
                        uploadWidget(
                            onFilePicked: _handleRestaurantMenuImgPicked),
                        _isRestaurantMenuUploaded
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: _imageRestaurantMenuImgPaths
                                      .map((path) => Card(
                                            color: Color.fromARGB(
                                                255, 211, 216, 218),
                                            elevation: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                getLast7Characters(path),
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      child: Text(
                        'add restaurant images'.toUpperCase(),
                        style: titleTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    margin: EdgeInsets.only(left: 3.w, right: 3.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: textGrey2, width: 0.2.w),
                    ),
                    child: Column(
                      children: [
                        uploadWidget(onFilePicked: _handleRestaurantImgPicked),
                        _isRestaurantImgUploaded
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: imageRestaurantImgPath
                                      .map((path) => Card(
                                            color: Color.fromARGB(
                                                255, 211, 216, 218),
                                            elevation: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                getLast7Characters(path),
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 5.w, vertical: 3.h),
                      child: Text(
                        'add food images'.toUpperCase(),
                        style: titleTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  Container(
                    width: 100.w,
                    margin: EdgeInsets.only(left: 3.w, right: 3.w),
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
                    decoration: BoxDecoration(
                      color: bgColor,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: textGrey2, width: 0.2.w),
                    ),
                    child: Column(
                      children: [
                        uploadWidget(onFilePicked: _handleFoodImgPicked),
                        _isFoodImgUploaded
                            ? SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: imageFoodImgPath
                                      .map((path) => Card(
                                            color: Color.fromARGB(
                                                255, 211, 216, 218),
                                            elevation: 1,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                getLast7Characters(path),
                                                style: TextStyle(
                                                    color: Colors.green),
                                              ),
                                            ),
                                          ))
                                      .toList(),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 5.h),
                    child: mainButton(
                      'Set Restaurant',
                      textWhite,
                      routeRegistrationComplete,
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  bool _isFoodImgUploaded = false;
  List<String> imageFoodImgPath = [];

  bool _isRestaurantImgUploaded = false;
  List<String> imageRestaurantImgPath = [];

  bool _isRestaurantMenuUploaded = false;
  List<String> _imageRestaurantMenuImgPaths = [];

  String getLast7Characters(String path) {
    String fileName = path.split('/').last;
    if (fileName.length <= 7) {
      return fileName;
    } else {
      return fileName.substring(fileName.length - 7);
    }
  }

  void _handleFoodImgPicked(bool isPicked, String? filePath) {
    if (isPicked && filePath != null) {
      setState(() {
        _isFoodImgUploaded = true;
        imageFoodImgPath.add(filePath);
      });
    } else {
      setState(() {
        _isFoodImgUploaded = false;
      });
    }
  }

  void _handleRestaurantImgPicked(bool isPicked, String? filePath) {
    if (isPicked && filePath != null) {
      setState(() {
        _isRestaurantImgUploaded = true;
        imageRestaurantImgPath.add(filePath);
      });
    } else {
      setState(() {
        _isRestaurantImgUploaded = false;
      });
    }
  }

  void _handleRestaurantMenuImgPicked(bool isPicked, String? filePath) {
    if (isPicked && filePath != null) {
      setState(() {
        _isRestaurantMenuUploaded = true;
        _imageRestaurantMenuImgPaths.add(filePath);
      });
    } else {
      setState(() {
        _isRestaurantMenuUploaded = false;
      });
    }
  }
}
