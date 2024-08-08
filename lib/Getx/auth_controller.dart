// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:pocketbase/pocketbase.dart';
// import 'package:receive_the_product/Getx/user_model.dart';
// import 'dart:convert';
//
// class AuthController extends GetxController {
//   final box = GetStorage();
//   final pb = PocketBase('https://saater.liara.run');
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   void setUser(User user) {
//     final userJson = jsonEncode(user.toJson());
//     box.write('user', userJson);
//     update(['user']);
//   }
//
//   User? getUser() {
//     final userJson = box.read('user');
//     if (userJson != null) {
//       return User.fromJson(jsonDecode(userJson));
//     }
//     return null;
//   }
//
//   void clearUser() {
//     box.remove('user');
//     update(['user']);
//   }
//
//   void logout() {
//     clearUser();
//     Get.offAllNamed('/login');
//   }
//
//   Future<void> checkLoginStatus() async {
//     final userJson = box.read('user');
//     if (userJson != null) {
//       final user = User.fromJson(userJson);
//       if (user.verified) {
//         Get.offAllNamed('/home');
//       } else {
//         clearUser();
//         Get.offAllNamed('/login');
//       }
//     } else {
//       Get.offAllNamed('/login');
//     }
//   }
//
//
//   Future<void> login(String email, String password) async {
//     try {
//       final authData = await pb.collection('users').authWithPassword(email, password);
//       final userJson = authData.record!.toJson();
//       final user = User.fromJson(userJson);
//
//       // اضافه کردن پسورد به اطلاعات کاربر
//       user.password = password; // ذخیره کردن پسورد
//
//       if (user.verified) {
//         // ذخیره اطلاعات کاربر با پسورد
//         box.write('user', user.toJson());
//         setUser(user);
//         Get.offAllNamed('/home');
//       } else {
//         Get.snackbar('مشکل', 'شما مجاز به ورود نیستین',backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       Get.snackbar('مشکل', 'ایمیل یا پسورد به درستی وارد نشده',backgroundColor: Colors.red);
//     }
//   }
//
//   // Future<User?> getUserFromServerOrStorage() async {
//   //   final userJson = box.read('user');
//   //   if (userJson != null) {
//   //     try {
//   //       final user = User.fromJson(jsonDecode(userJson));
//   //       if (user.verified) {
//   //         return user;
//   //       } else {
//   //         clearUser();
//   //         return null;
//   //       }
//   //     } catch (e) {
//   //       clearUser();
//   //       return null;
//   //     }
//   //   }
//   //   return null;
//   // }
//
//   // فرض بر این است که متد checkVerificationStatus که در فایل profile_page.dart استفاده می‌شود، به صورت زیر باشد
//   Future<bool> checkVerificationStatus() async {
//     bool check = false; // مقداردهی اولیه به false
//
//     final userJson = box.read('user');
//     if (userJson == null) {
//       Get.snackbar('Error', 'No user data found. Please login again.');
//       return check; // در صورتی که اطلاعات کاربر وجود نداشته باشد، false برگردانده می‌شود
//     }
//
//     final usersa = User.fromJson(jsonDecode(userJson));
//
//     try {
//       final authData = await pb.collection('users').authWithPassword(usersa.email, usersa.password);
//       final fetchedUserJson = authData.record!.toJson();
//       final user = User.fromJson(fetchedUserJson);
//
//       if (user.verified) {
//         // وضعیت تأیید درست است
//         check = true;
//         // اطلاعات کاربر را به روز کنید و به صفحه خانه هدایت کنید (اختیاری)
//         box.write('user', fetchedUserJson); // ذخیره اطلاعات کاربر به جای توکن
//         setUser(user);
//         Get.offAllNamed('/home');
//       } else {
//         Get.snackbar('Error', 'شما مجاز نیست');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Invalid email or password');
//     }
//
//     return check; // در پایان متد، مقدار check برگردانده می‌شود
//   }
//
// }

//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketbase/pocketbase.dart';
// import 'package:receive_the_product/Getx/DataBase/sembast_database.dart';
// import 'package:sembast/sembast.dart';
// import 'package:receive_the_product/Getx/user_model.dart';
// import 'dart:convert';
//
//
// class AuthController extends GetxController {
//   final StoreRef<String, String> _store = StoreRef<String, String>.main();
//   final SembastDatabase _dbInstance = SembastDatabase();
//   final pb = PocketBase('https://saater.liara.run');
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//   Future<void> setUser(User user) async {
//     final db = await _dbInstance.database;
//     final userJson = jsonEncode(user.toJson());
//     await _store.record('user').put(db, userJson);
//     update(['user']);
//   }
//
//   // Future<User?> getUser() async {
//   //   final db = await _dbInstance.database;
//   //   final userJson = await _store.record('user').get(db);
//   //   if (userJson != null) {
//   //     return User.fromJson(jsonDecode(userJson));
//   //   }
//   //   return null;
//   // }
//   Future<User?> getUser() async {
//     final db = await _dbInstance.database;
//     final userJson = await _store.record('user').get(db);
//     if (userJson != null) {
//       return User.fromJson(jsonDecode(userJson));
//     }
//     return null;
//   }
//
//   Future<void> clearUser() async {
//     final db = await _dbInstance.database;
//     await _store.record('user').delete(db);
//     update(['user']);
//   }
//
//   void logout() async {
//     await clearUser();
//     Get.offAllNamed('/login');
//   }
//
//   Future<void> checkLoginStatus() async {
//     final user = await getUser();
//     if (user != null) {
//       if (user.verified) {
//         Get.offAllNamed('/home');
//       } else {
//         await clearUser();
//         Get.offAllNamed('/login');
//       }
//     } else {
//       Get.offAllNamed('/login');
//     }
//   }
//
//   Future<void> login(String email, String password) async {
//     try {
//       final authData = await pb.collection('users').authWithPassword(email, password);
//       final userJson = authData.record!.toJson();
//       final user = User.fromJson(userJson);
//
//       user.password = password;
//
//       if (user.verified) {
//         await setUser(user);
//         Get.offAllNamed('/home');
//       } else {
//         Get.snackbar('مشکل', 'شما مجاز به ورود نیستین', backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       Get.snackbar('مشکل', 'ایمیل یا پسورد به درستی وارد نشده', backgroundColor: Colors.red);
//     }
//   }
//
//   Future<bool> checkVerificationStatus() async {
//     bool check = false;
//
//     final user = await getUser();
//     if (user == null) {
//       Get.snackbar('Error', 'No user data found. Please login again.');
//       return check;
//     }
//
//     try {
//       final authData = await pb.collection('users').authWithPassword(user.email, user.password);
//       final fetchedUserJson = authData.record!.toJson();
//       final fetchedUser = User.fromJson(fetchedUserJson);
//
//       if (fetchedUser.verified) {
//         check = true;
//         await setUser(fetchedUser);
//         Get.offAllNamed('/home');
//       } else {
//         Get.snackbar('Error', 'شما مجاز نیست');
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Invalid email or password');
//     }
//
//     return check;
//   }
// }

//
// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:pocketbase/pocketbase.dart';
// import 'package:receive_the_product/Getx/DataBase/sembast_database.dart';
// import 'package:receive_the_product/Getx/user_model.dart';
//
// class AuthController extends GetxController {
//   final pb = PocketBase('https://saater.liara.run');
//
//   @override
//   void onInit() {
//     super.onInit();
//   }
//
//
//   Future<User?> getUser() async {
//     try {
//       final path = await getLocalPath();
//       final file = File('$path/user.json');
//       if (await file.exists()) {
//         String content = await file.readAsString();
//         Map<String, dynamic> data = jsonDecode(content);
//         return User.fromJson(data);
//       } else {
//         print("File does not exist at path: $path/user.json");
//         return null;
//       }
//     } catch (e) {
//       print("Error in getUser: $e");
//       return null;
//     }
//   }
//
//   // تابع برای پاک‌سازی اطلاعات کاربر
//   Future<void> clearUser() async {
//     final path = await getLocalPath();
//     final file = File('$path/name_surname_verified.txt');
//     if (await file.exists()) {
//       await file.delete(); // حذف فایل
//     }
//     update(['user']);
//   }
//
//   // تابع برای خروج
//   void logout() async {
//     await clearUser();
//     Get.offAllNamed('/login');
//   }
//
//   // تابع برای ورود کاربر
//   Future<void> login(String email, String password) async {
//     try {
//       // احراز هویت کاربر
//       final authData = await pb.collection('users').authWithPassword(email, password);
//       final userJson = authData.record!.toJson();
//       final user = User.fromJson(userJson);
//
//       user.password = password; // ذخیره کردن پسورد در مدل کاربر
// print(user);
//       if (user.verified) {
//         // ذخیره اطلاعات کاربر در فایل
//         await saveNameSurnameAndVerified(email, password, true);
//         await saveUser(user);
//         // نمایش پیام ورود موفق
//         Get.snackbar('ورود موفق', 'شما با موفقیت وارد شدید.', backgroundColor: Colors.green);
//
//         // هدایت به صفحه خانه
//         Get.offAllNamed('/home');
//       } else {
//         // اگر کاربر تأیید نشده باشد، نمایش پیام دسترسی محدود
//         Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
//       }
//     } catch (e) {
//       // در صورت خطا در ورود، نمایش پیام مناسب
//       Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
//     }
//   }
//
//   Future<void> checkAndLogin() async {
//     try {
//       // مرحله 1: خواندن اطلاعات کاربر از فایل محلی
//       Map<String, dynamic> data = await readNameSurnameAndVerified();
//
//       if (data['email'].isNotEmpty && data['password'].isNotEmpty) {
//         // مرحله 2: اعتبارسنجی اطلاعات در سرور
//         final authData = await pb.collection('users').authWithPassword(data['email'], data['password']);
//         final userJson = authData.record!.toJson();
//         final user = User.fromJson(userJson);
//
//         user.password = data['password'];
//
//         // مرحله 3: بررسی وضعیت تأیید
//         if (user.verified) {
//           Get.offAllNamed('/home');
//         } else {
//           Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
//           Get.offAllNamed('/login');
//         }
//       } else {
//         Get.offAllNamed('/login');
//       }
//     } catch (e) {
//       Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
//       Get.offAllNamed('/login');
//     }
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:receive_the_product/Getx/DataBase/sembast_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:receive_the_product/Getx/user_model.dart';

class AuthController extends GetxController {
  final pb = PocketBase('https://saater.liara.run');

  @override
  void onInit() {
    super.onInit();
  }

  Future<User?> getUser() async {
    try {
      return await readUser();
    } catch (e) {
      print("Error in getUser: $e");
      return null;
    }
  }

  // تابع برای پاک‌سازی اطلاعات کاربر
  Future<void> clearUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('name_surname_verified');
      await prefs.remove('user');
      update(['user']);
    } catch (e) {
      print("Error in clearUser: $e");
    }
  }

  // تابع برای خروج
  void logout() async {
    await clearUser();
    Get.offAllNamed('/login');
  }

  // تابع برای ورود کاربر
  Future<void> login(String email, String password) async {
    try {
      // احراز هویت کاربر
      final authData = await pb.collection('users').authWithPassword(email, password);
      final userJson = authData.record!.toJson();
      final user = User.fromJson(userJson);

      user.password = password; // ذخیره کردن پسورد در مدل کاربر
      print(user);
      if (user.verified) {
        // ذخیره اطلاعات کاربر در shared_preferences
        await saveNameSurnameAndVerified(email, password, true);
        await saveUser(user);
        // نمایش پیام ورود موفق
        Get.snackbar('ورود موفق', 'شما با موفقیت وارد شدید.', backgroundColor: Colors.green);

        // هدایت به صفحه خانه
        Get.offAllNamed('/home');
      } else {
        // اگر کاربر تأیید نشده باشد، نمایش پیام دسترسی محدود
        Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
      }
    } catch (e) {
      // در صورت خطا در ورود، نمایش پیام مناسب
      Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
    }
  }

  Future<void> checkAndLogin() async {
    try {
      // مرحله 1: خواندن اطلاعات کاربر از shared_preferences
      Map<String, dynamic> data = await readNameSurnameAndVerified();

      if (data['email'].isNotEmpty && data['password'].isNotEmpty) {
        // مرحله 2: اعتبارسنجی اطلاعات در سرور
        final authData = await pb.collection('users').authWithPassword(data['email'], data['password']);
        final userJson = authData.record!.toJson();
        final user = User.fromJson(userJson);

        user.password = data['password'];

        // مرحله 3: بررسی وضعیت تأیید
        if (user.verified) {
          Get.offAllNamed('/home');
        } else {
          Get.snackbar('دسترسی محدود', 'حساب کاربری شما تأیید نشده است. لطفاً با پشتیبانی تماس بگیرید.', backgroundColor: Colors.red);
          Get.offAllNamed('/login');
        }
      } else {
        Get.offAllNamed('/login');
      }
    } catch (e) {
      Get.snackbar('ورود ناموفق', 'ایمیل یا رمز عبور نادرست است. لطفاً دوباره تلاش کنید.', backgroundColor: Colors.red);
      Get.offAllNamed('/login');
    }
  }
}