import 'controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:hktareen_s_application/core/app_export.dart';
import 'package:hktareen_s_application/core/utils/validation_functions.dart';
import 'package:hktareen_s_application/widgets/custom_elevated_button.dart';
import 'package:hktareen_s_application/widgets/custom_icon_button.dart';
import 'package:hktareen_s_application/widgets/custom_outlined_button.dart';
import 'package:hktareen_s_application/widgets/custom_text_form_field.dart';
import 'package:hktareen_s_application/domain/googleauth/google_auth_helper.dart';
import 'package:hktareen_s_application/domain/facebookauth/facebook_auth_helper.dart';

// ignore_for_file: must_be_immutable
class LoginScreen extends GetWidget<LoginController> {
  LoginScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Form(
                key: _formKey,
                child: Container(
                    width: double.maxFinite,
                    padding:
                        EdgeInsets.only(left: 16.h, top: 68.v, right: 16.h),
                    child: Column(children: [
                      CustomIconButton(
                          height: 72.adaptSize,
                          width: 72.adaptSize,
                          padding: EdgeInsets.all(20.h),
                          child: CustomImageView(
                              imagePath: ImageConstant.imgLogo)),
                      SizedBox(height: 16.v),
                      Text("msg_welcome_to_e_com".tr,
                          style: theme.textTheme.titleMedium),
                      SizedBox(height: 10.v),
                      Text("msg_sign_in_to_continue".tr,
                          style: theme.textTheme.bodySmall),
                      SizedBox(height: 28.v),
                      _buildEmail(),
                      SizedBox(height: 10.v),
                      _buildPassword(),
                      SizedBox(height: 16.v),
                      _buildSignIn(),
                      SizedBox(height: 18.v),
                      _buildOrLine(),
                      SizedBox(height: 16.v),
                      _buildLoginWithGoogle(),
                      SizedBox(height: 8.v),
                      _buildLoginWithFacebook(),
                      SizedBox(height: 17.v),
                      Text("msg_forgot_password".tr,
                          style: CustomTextStyles.labelLargePrimary),
                      SizedBox(height: 7.v),
                      RichText(
                          text: TextSpan(children: [
                            TextSpan(
                                text: "msg_don_t_have_an_account2".tr,
                                style: theme.textTheme.bodySmall),
                            TextSpan(text: " "),
                            TextSpan(
                                text: "lbl_register".tr,
                                style: CustomTextStyles.labelLargePrimary_1)
                          ]),
                          textAlign: TextAlign.left),
                      SizedBox(height: 5.v)
                    ])))));
  }

  /// Section Widget
  Widget _buildEmail() {
    return CustomTextFormField(
        controller: controller.emailController,
        hintText: "lbl_your_email".tr,
        textInputType: TextInputType.emailAddress,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgMail,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        prefixConstraints: BoxConstraints(maxHeight: 48.v),
        validator: (value) {
          if (value == null || (!isValidEmail(value, isRequired: true))) {
            return "err_msg_please_enter_valid_email".tr;
          }
          return null;
        });
  }

  /// Section Widget
  Widget _buildPassword() {
    return CustomTextFormField(
        controller: controller.passwordController,
        hintText: "lbl_password".tr,
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        prefix: Container(
            margin: EdgeInsets.fromLTRB(16.h, 12.v, 10.h, 12.v),
            child: CustomImageView(
                imagePath: ImageConstant.imgLockIcon,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        prefixConstraints: BoxConstraints(maxHeight: 48.v),
        validator: (value) {
          if (value == null || (!isValidPassword(value, isRequired: true))) {
            return "err_msg_please_enter_valid_password".tr;
          }
          return null;
        },
        obscureText: true);
  }

  /// Section Widget
  Widget _buildSignIn() {
    return CustomElevatedButton(text: "lbl_sign_in".tr);
  }

  /// Section Widget
  Widget _buildOrLine() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Padding(
          padding: EdgeInsets.only(top: 10.v, bottom: 9.v),
          child: SizedBox(width: 134.h, child: Divider())),
      Text("lbl_or".tr, style: CustomTextStyles.titleSmall_1),
      Padding(
          padding: EdgeInsets.only(top: 10.v, bottom: 9.v),
          child: SizedBox(width: 137.h, child: Divider()))
    ]);
  }

  /// Section Widget
  Widget _buildLoginWithGoogle() {
    return CustomOutlinedButton(
        text: "msg_login_with_google".tr,
        leftIcon: Container(
            margin: EdgeInsets.only(right: 30.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgGoogleIcon,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        onPressed: () {
          onTapLoginWithGoogle();
        });
  }

  /// Section Widget
  Widget _buildLoginWithFacebook() {
    return CustomOutlinedButton(
        text: "msg_login_with_facebook".tr,
        leftIcon: Container(
            margin: EdgeInsets.only(right: 30.h),
            child: CustomImageView(
                imagePath: ImageConstant.imgFacebookIcon,
                height: 24.adaptSize,
                width: 24.adaptSize)),
        onPressed: () {
          onTapLoginWithFacebook();
        });
  }

  /// Performs a Google sign-in and returns a [GoogleUser] object.
  ///
  /// If the sign-in is successful, the [onSuccess] callback will be called with
  /// a TODO comment needed to be modified by you.
  /// If the sign-in fails, the [onError] callback will be called with the error message.
  ///
  /// Throws an exception if the Google sign-in process fails.
  onTapLoginWithGoogle() async {
    await GoogleAuthHelper().googleSignInProcess().then((googleUser) {
      if (googleUser != null) {
        //TODO Actions to be performed after signin
      } else {
        Get.snackbar('Error', 'user data is empty');
      }
    }).catchError((onError) {
      Get.snackbar('Error', onError.toString());
    });
  }

  /// Performs a Facebook sign-in and returns a [FacebookUser] object.
  ///
  /// If the sign-in is successful, the [onSuccess] callback will be called with
  /// a TODO comment needed to be modified by you.
  /// If the sign-in fails, the [onError] callback will be called with the error message.
  ///
  /// Throws an exception if the Facebook sign-in process fails.
  onTapLoginWithFacebook() async {
    await FacebookAuthHelper().facebookSignInProcess().then((facebookUser) {
      //TODO Actions to be performed after signin
    }).catchError((onError) {
      Get.snackbar('Error', onError.toString());
    });
  }
}
