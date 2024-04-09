import 'package:plant_app/exports/exports.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SignUpScreenProvider provider =
        Provider.of<SignUpScreenProvider>(context, listen: false);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
                width: 100.w,
                child: Image.asset(MyImages.signUp),
              ),
              Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 2.h),
              CustomTextField(
                controller: provider.emailController,
                obscureText: false,
                hintText: 'Enter Email',
                icon: Icons.alternate_email,
              ),
              SizedBox(height: 1.h),
              CustomTextField(
                controller: provider.nameController,
                obscureText: false,
                hintText: 'Enter Full name',
                icon: Icons.person,
              ),
              SizedBox(height: 1.h),
              CustomTextField(
                controller: provider.passwordController,
                obscureText: true,
                hintText: 'Enter Password',
                icon: Icons.lock,
              ),
              SizedBox(height: 2.3.h),
              Selector<SignUpScreenProvider, bool>(
                selector: (context, instance) => instance.loading,
                builder: (context, value, child) {
                  return MyButton(
                    text: 'Sign Up',
                    loading: provider.loading,
                    onTap: () {
                      provider.signUp(context);
                    },
                  );
                },
              ),
              SizedBox(height: 2.5.h),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2.w),
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
              SizedBox(height: 2.2.h),
              Container(
                width: 100.w,
                decoration: BoxDecoration(
                  border: Border.all(color: MyColors.black54.withOpacity(0.3)),
                  borderRadius: BorderRadius.circular(7.sp),
                ),
                padding:
                    EdgeInsets.symmetric(horizontal: 12.w, vertical: 1.8.h),
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
              SizedBox(height: 2.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '     Already have an account?',
                    style: TextStyle(
                      color: MyColors.black54,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                    borderRadius: BorderRadius.circular(100.h),
                    onTap: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: Text(
                      '  Login  ',
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
