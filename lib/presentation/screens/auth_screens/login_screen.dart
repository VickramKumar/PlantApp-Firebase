// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:plant_app/exports/exports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    LoginScreenProvider provider =
        Provider.of<LoginScreenProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 1.h),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 35.h,
                width: 100.w,
                child: Image.asset(MyImages.login),
              ),
              SizedBox(height: 2.h),
              Text(
                'Log In',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4.h),
              CustomTextField(
                controller: provider.emailController,
                hintText: 'Enter Email',
                icon: Icons.alternate_email,
              ),
              SizedBox(height: 1.2.h),
              CustomTextField(
                controller: provider.passwordController,
                hintText: 'Enter Password',
                icon: Icons.lock,
              ),
              SizedBox(height: 0.5.h),
              Align(
                alignment: Alignment.bottomRight,
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(5.sp),
                  child: Text(
                    '  Forgot Password?  ',
                    style: TextStyle(
                      color: MyColors.black54.withOpacity(0.5),
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              GestureDetector(
                onTap: () {
                  provider.login(context);
                },
                child: Container(
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: MyColors.appColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                  child: const Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3.h),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      'OR',
                      style: TextStyle(
                        color: MyColors.black54,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              SizedBox(height: 4.h),
              Container(
                width: 100.w,
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.black54.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(7.sp),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 1.8.h),
                child: InkWell(
                  onTap: () => provider.signUpWithGoogle(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 3.h,
                        child: Image.asset(MyImages.google),
                      ),
                      Text(
                        'Sign Up with Google',
                        style: TextStyle(
                          color: MyColors.black54,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '     Don\'t have an account?',
                    style: TextStyle(
                      color: MyColors.black54,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(100.h),
                    onTap: () {
                      Get.to(() => const SignUpScreen());
                    },
                    child: Text(
                      '  Sign Up  ',
                      style: TextStyle(
                        color: MyColors.appColor,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
