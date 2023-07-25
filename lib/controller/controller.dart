import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:magadh/model/user_model.dart';
import 'package:magadh/view/home_screen/home_screen.dart';
import 'package:magadh/view/otp_screen/otp_screen.dart';
import 'package:magadh/view/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';

TextEditingController phoneController = TextEditingController();
TextEditingController otpController = TextEditingController();
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController latController = TextEditingController();
TextEditingController lonController = TextEditingController();

final GlobalKey<ScaffoldState> homeKey = GlobalKey<ScaffoldState>();

double? mHeight;
double? mWidth;

String token = '';
String myAuthToken = '';
List myUserList = [];

clear() {
  nameController.clear();
  phoneController.clear();
  emailController.clear();
  otpController.clear();
  latController.clear();
  lonController.clear();
}

//user login=================================================================

Future<void> loginUser({context}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child:
          SizedBox(height: 40, width: 40, child: CircularProgressIndicator()),
    ),
  );
  try {
    final url =
        Uri.parse('https://flutter.magadh.co/api/v1/users/login-request');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({"phone": phoneController.text});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final otp = jsonDecode(response.body)['otp'];
      otpController.text = otp.toString();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => OTPScreen(),
          ),
          (route) => false);

      print('Login successful');
      print('otp: $otp');
      print(jsonDecode(response.body));
    } else {
      print('Login failed');
      print('Status code: ${response.statusCode}');
      print('Error: ${response.body}');
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: '${jsonDecode(response.body)['message']}',
        backgroundColor: red,
      );
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}

//verify otp================================================================
Future<void> verifyOTP(context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child:
          SizedBox(height: 40, width: 40, child: CircularProgressIndicator()),
    ),
  );
  try {
    final url =
        Uri.parse('https://flutter.magadh.co/api/v1/users/login-verify');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "phone": phoneController.text,
      "otp": otpController.text,
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final authToken = jsonDecode(response.body)['token'];
      // myAuthToken = authToken;
      // log(myAuthToken.toString());
      getToken(authToken, context);

      print('Verification successful');
      print(jsonDecode(response.body));
    } else {
      Fluttertoast.showToast(
        msg: 'Error: ${response.body}',
        backgroundColor: red,
      );
      print('Verification failed');
      print('Status code: ${response.statusCode}');
      print('Error: ${response.body}');
    }
  } catch (e) {
    throw Exception('error: $e');
  }
}

//get token==================================================================
Future<void> getToken(authToken, context) async {
  try {
    final url =
        Uri.parse('https://flutter.magadh.co/api/v1/users/verify-token');

    final header = {'Authorization': 'Bearer $authToken'};
    final response = await http.get(
      url,
      headers: header,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // token = data.toString();
      final token = data['user']['token'];
      final user = data['user']['name'];
      print('user::::::$user');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setString('name', user);
      await prefs.setBool('isLoggedIn', true);
      // getUserList();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
          (route) => false);
      Fluttertoast.showToast(
        msg: 'Logged in successfully',
        backgroundColor: green,
      );
      phoneController.clear();
      print('Token retrieval successful');
      print('Token: $token');
    } else {
      Fluttertoast.showToast(
        msg: 'Error: ${response.body}',
        backgroundColor: red,
      );
      print('Token retrieval failed');
      print('Status code: ${response.statusCode}');
      print('Error: ${response.body}');
    }
  } catch (e) {
    throw Exception('error : $e');
  }
}

//get User list =============================================================

Future<List<User>> getUserList() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  log('shared :::${prefs.getString('token')}');

  try {
    final url = Uri.parse('https://flutter.magadh.co/api/v1/users');

    final authToken = prefs.getString('token').toString();
    print(authToken.toString());

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $authToken'},
    );

    if (response.statusCode == 200) {
      final jsonBody = jsonDecode(response.body);
      if (jsonBody.containsKey('users')) {
        final List<dynamic> userListJson = jsonBody['users'];

        final data = userListJson.map((json) => User.fromJson(json)).toList();
        print(data.toString());
        myUserList = data;
        return data;
      } else {
        Fluttertoast.showToast(
          msg: 'No "users" key found',
        );
        throw Exception('No "users" key found');
      }
    } else {
      Fluttertoast.showToast(
        msg:
            'Failed to retrieve user list. Status code: ${response.statusCode}',
        backgroundColor: red,
      );
      throw Exception(
          'Failed to retrieve user list. Status code: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('error: $e');
  }
}

//create a new user==========================================================

Future<void> createUser(
    {name, email, phone, latitude, longitude, context}) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const Center(
      child:
          SizedBox(height: 40, width: 40, child: CircularProgressIndicator()),
    ),
  );
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final authToken = prefs.getString('token').toString();

  final url = 'https://flutter.magadh.co/api/v1/users';

  final Map<String, dynamic> userData = {
    'name': name,
    'email': email,
    'phone': phone,
    'location': {
      'latitude': latitude,
      'longitude': longitude,
    },
  };

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken'
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'User created successfully',
        backgroundColor: green,
      );

      print('User created successfully');
    } else {
      Fluttertoast.showToast(
        msg: 'Failed to create user. Status code: ${response.statusCode}',
        backgroundColor: red,
      );
      print('Failed to create user. Status code: ${response.statusCode}');
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: 'Error creating user: $e',
      backgroundColor: red,
    );
    print('Error creating user: $e');
  }
}

//get the current location=================================================

Future getLocation() async {
  String? lat;
  String? long;

  final position = await getCurrentLocation();
  lat = '${position.latitude}';
  long = '${position.longitude}';

  latController.text = lat;
  lonController.text = long;
  Fluttertoast.showToast(msg: 'Location fetched');
}

//get current location================================================

Future<Position> getCurrentLocation() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Location services are disabled');
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Location permission denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Location permission permanently denied');
  }

  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.best,
  );
}

//update user================================================================

Future<void> updateUser(
    {userId, name, email, phone, latitude, longitude, imagePath}) async {
  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('token');
    print(authToken);
    print(imagePath);
    final url = Uri.parse('https://flutter.magadh.co/api/v1/users/');

    var formData = FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      'location': jsonEncode({
        'latitude': latitude,
        'longitude': longitude,
      }),
      'image': await MultipartFile.fromFile(imagePath),
    });

    final response = await Dio().patch(
      url.toString(),
      data: formData,
      options: Options(
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'multipart/form-data',
        },
      ),
    );

    if (response.statusCode == 200) {
      Fluttertoast.showToast(
        msg: 'User updated successfully',
        backgroundColor: Colors.green,
      );
      print('User updated successfully');
    } else {
      throw Exception(
          'Failed to update user. Status code: ${response.statusCode}');
    }
  } catch (e) {
    Fluttertoast.showToast(
      msg: 'Error updating user: $e',
      backgroundColor: red,
    );

    Exception('Error updating user: $e');
  }
}

// Future<void> uploadImage({imagePath, longitude, latitude}) async {
//   try {
//     var stream =
//         http.ByteStream(DelegatingStream.typed(File(imagePath).openRead()));
//     var length = await File(imagePath).length();

//     var uri = Uri.parse('https://flutter.magadh.co/api/v1/users/');

//     var request = http.MultipartRequest('PATCH', uri);

//     var multipartFile = http.MultipartFile('image', stream, length,
//         filename: basename(imagePath), contentType: MediaType('image', 'jpg'));

//     request.files.add(multipartFile);

//     request.fields['location'] = jsonEncode({
//       'latitude': latitude,
//       'longitude': longitude,
//     });

//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     final authToken = prefs.getString('token');

//     request.headers['Authorization'] = 'Bearer $authToken';

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       print('Image and Location updated successfully');
//       // Do something with the response if needed
//     } else {
//       print(
//           'Failed to update image and location. Status code: ${response.statusCode}');
//     }
//   } catch (e) {
//     print('Error updating image and location: $e');
//   }
// }

//get location name========================================================
String? locationName;

Future<String> getPlaceName({latitude, longitude}) async {
  print('getplaced called');

  final apiUrl =
      'https://nominatim.openstreetmap.org/reverse?format=json&lat=$latitude&lon=$longitude';

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      String placeName = decodedData['display_name'];
      locationName = placeName;
      print(placeName);
      return placeName;
    } else {
      print('Error: Status code ${response.statusCode}');
    }
  } catch (e) {
    print('Error getting place name: $e');
  }
  return 'Unknown Place';
}
