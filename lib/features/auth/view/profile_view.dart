import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry_app/core/constants/app_colors.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/features/auth/data/auth_repo.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';
import 'package:hungry_app/features/auth/view/login_view.dart';
import 'package:hungry_app/features/auth/widgets/custom_profile_field.dart';
import 'package:hungry_app/shared/Custom_bottom.dart';
import 'package:hungry_app/shared/custom_snack.dart';
import 'package:hungry_app/shared/custom_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeletonizer/skeletonizer.dart';
import "../../../root.dart";

// ignore: must_be_immutable
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _visa = TextEditingController();

  AuthRepo authRepo = AuthRepo();
  bool isLoading = false;
  UserModel? userModel;
  String? selectedImage;

  Future<void> _getProfile() async {
    try {
      final user = await authRepo.profile();
      if (user != null) {
        setState(() {
          userModel = user;
          _name.text = user.name ?? "Unknown Name";
          _email.text = user.email ?? "Unknown Email";
          _address.text = user.address ?? "Unknown Address";
        });
      }
    } catch (e) {
      String errMessage = "fail to load profile";
      if (e is ApiError) {
        errMessage = e.message;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(customSnack(errMessage));
      }
    }
  }

  Future<void> _updateProfile() async {
    try {
      setState(() => isLoading = true);
      final user = await authRepo.updateProfile(
        _name.text.trim(),
        _email.text.trim(),
        _visa.text.trim(),
        _address.text.trim(),
        selectedImage ?? "",
      );

      if (user != null) {
        setState(() => userModel = user);
      }
      setState(() => isLoading = false);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(customSnack("Profile Updated", color: AppColors.primary));
    } catch (e) {
      setState(() => isLoading = false);
      String errMsg = "Failed to update profile";
      if (e is ApiError) {
        errMsg = e.message;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
      }
    }
  }

  Future<void> _logout() async {
    try {
      await authRepo.logout();
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (c) => LoginView()),
      );
    } catch (e) {
      String errMsg = "Failed to logout";
      if (e is ApiError) {
        errMsg = e.message;
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(customSnack(errMsg));
      }
    }
  }

  Future<void> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        selectedImage = pickedImage.path;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        await _getProfile();
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          backgroundColor: AppColors.primary,
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            leading: GestureDetector(
              onTap: () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (c) => RootView()),
              ),
              child: Icon(CupertinoIcons.back, color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Icon(Icons.settings, color: Colors.white),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Skeletonizer(
              enabled: userModel == null,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: BoxBorder.all(color: Colors.white, width: 3),
                        ),
                        child: selectedImage != null
                            ? Image.file(
                                File(selectedImage!),
                                fit: BoxFit.cover,
                              )
                            : (userModel?.image != null &&
                                  userModel!.image!.isNotEmpty)
                            ? Image.network(
                                userModel!.image!,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                      Icons.error,
                                      color: Colors.white,
                                      size: 50,
                                    ),
                              )
                            : Icon(Icons.person, color: Colors.white, size: 50),
                      ),
                      Gap(10),
                      CustomBottom(
                        onTap: _pickImage,
                        width: 200,
                        height: 40,
                        radius: 40,
                        color: Colors.white,
                        textColor: AppColors.primary,
                        text: "update image",
                      ),

                      Gap(30),
                      CustomProfileField(hint: "Name", controller: _name),
                      Gap(15),
                      CustomProfileField(hint: "Email", controller: _email),
                      Gap(15),
                      CustomProfileField(
                        hint: "Delivery Address",
                        controller: _address,
                      ),
                      Gap(30),

                      userModel?.visa == null || userModel!.visa!.isEmpty
                          ? CustomProfileField(
                              type: TextInputType.number,
                              hint: "ADD CARD",
                              controller: _visa,
                            )
                          : Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: ListTile(
                                leading: Image.asset(
                                  "assets/checkout/visa.png",
                                  width: 80,
                                ),
                                title: CustomText(
                                  text: "Debit card",
                                  weight: FontWeight.w700,
                                ),
                                subtitle: CustomText(
                                  text: userModel?.visa ?? "",
                                  size: 12,
                                ),
                                trailing: CustomText(text: "DEFAULT"),
                              ),
                            ),
                      Gap(500),
                    ],
                  ),
                ),
              ),
            ),
          ),

          bottomSheet: Container(
            height: 100,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: _updateProfile,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        isLoading
                            ? CupertinoActivityIndicator(color: Colors.white)
                            : CustomText(
                                text: "Update",
                                color: Colors.white,
                                weight: FontWeight.bold,
                                size: 16,
                              ),
                        Gap(30),
                        Icon(CupertinoIcons.pencil, color: Colors.white),
                      ],
                    ),
                  ),
                ),

                GestureDetector(
                  onTap: _logout,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primary, width: 2),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        CustomText(
                          text: "Exit",
                          color: AppColors.primary,
                          weight: FontWeight.bold,
                          size: 16,
                        ),
                        Gap(30),
                        Icon(
                          Icons.exit_to_app_rounded,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
