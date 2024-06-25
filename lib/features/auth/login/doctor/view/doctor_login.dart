import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../api_packages/dependency_injection/get_it_locator.dart';
import '../../../../../core/database/local_secure_storage.dart';
import '../../../../../core/database/local_user_model.dart';
import '../../../../../core/route.dart';
import '../../../../../core/utils/custom_snackbar.dart';
import '../../../cubit/cubit/auth_cubit.dart';
import '../widgets/doctor_login_card.dart';
import '../../../../chat/cubit/socket_cubit/socket_cubit.dart';

class DoctorLoginView extends StatelessWidget {
  const DoctorLoginView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/image/Background.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is LoginDoctorCubitSuccess) {
                LocalUserModel.setUserType('doctor');
                LocalSecureStorage.setUserType('doctor');
                LocalSecureStorage.setUserid(
                    LocalUserModel.getUserId().toString());
                getIt<SocketCubit>().userConnected();
                getIt<SocketCubit>().joinAll(
                    userId: LocalUserModel.getUserId(), userType: 'doctor');
                GoRouter.of(context)
                    .pushReplacement(AppRoutes.kDoctorHomeRoute);
              }
              if (state is LoginCubitError) {
                customSnackBar(context,
                    title: 'Something Wrong',
                    message: 'Please try again later !',
                    type: ContentType.failure);
              }
              if (state is LoginCubitInvalid) {
                customSnackBar(context,
                    title: 'Invalid',
                    message: 'Invalid Email or Password !',
                    type: ContentType.warning);
              }
              if (state is LoginCubitWrongEmail) {
                customSnackBar(context,
                    title: 'Email Error',
                    message: 'Email Must Contain @ and .',
                    type: ContentType.failure);
              }
              if (state is LoginCubitWrongPassword) {
                customSnackBar(
                  context,
                  title: 'Password Error',
                  message:
                      'Password must contain at least 8 characters\nat least one number and one letter',
                  type: ContentType.failure,
                );
              }
            },
            child: DoctorLoginCard(),
          ),
        ),
      ),
    );
  }
}
