import 'package:go_router/go_router.dart';
import '../features/ai_model/view/model_details.dart';
import '../features/ai_model/view/pick_image.dart';
import '../features/auth/login/doctor/view/doctor_login.dart';
import '../features/auth/login/patient/view/patient_login.dart';
import '../features/auth/login/doctor/widgets/doctor_form.dart';
import '../features/auth/login/patient/widget/verify_code_card.dart';
import '../features/auth/sign_up/view/sign_up_view.dart';
import '../features/chat/views/select_chat.dart';
import '../features/doctor/doctor_list/view/doctor_list.dart';
import '../features/home/doctor/view/doctor_home.dart';
import '../features/home/patient/view/patient_home.dart';
import '../features/splash/view/splash_screen.dart';
import '../features/user_profile/doctor/edit/view/edit_doctor_profile.dart';
import '../features/user_profile/doctor/info/view/doctor_profile.dart';
import '../features/user_profile/doctor/info/view/widgets/doctor_confirm_image.dart';
import '../features/user_profile/doctor/password/view/doctor_edit_user_profile.dart';
import '../features/user_profile/patient/edit/view/edit_user_profile.dart';
import '../features/user_profile/patient/password/view/edit_user_profile.dart';
import '../features/user_profile/patient/info/view/user_profile.dart';
import '../features/user_profile/patient/info/view/widgets/confirm_image.dart';

abstract class AppRoutes {
  ///
  ///Chat routes
  ///

  ///Chat
  static const kChatRoute = '/chat';

  ///
  ///Model routes
  ///

  ///Model Result
  static const kModelResultRoute = '/model_result';

  ///Model Info
  static const kModelInfoRoute = '/model_info';

  ///
  ///Pick image
  ///

  ///Pick image
  static const kPickImageRoute = '/pick_image';

  ///
  ///Patient routes
  ///

  ///Patient Login
  static const kPatientLoginRoute = '/login';

  ///Patient SignUp
  static const kPatientSignupRoute = '/patient_signup';

  ///Patient Home
  static const kPatientHomeRoute = '/patient_home';

  ///Patient profile
  static const kPatientProfileRoute = '/patient_profile';

  ///Edit Patient info
  static const kEditPatientInfoRoute = '/edit_patient_info';

  ///Edit Patient password
  static const kEditPatientPasswordRoute = '/edit_patient_password';

  ///Confirm patient image
  static const kConfirmPatientImageRoute = '/confirm_patient_image';

  ///
  ///Doctor routes
  ///

  ///Edit doctor info
  static const kEditDoctorInfoRoute = '/edit_doctor_info';

  ///Confirm doctor image
  static const kConfirmDoctorImageRoute = '/confirm_doctor_image';

  ///Edit doctor password
  static const kEditDoctorPasswordRoute = '/edit_doctor_password';

  ///Doctor form
  static const kDoctorFormRoute = '/doctor_form';

  ///Doctor profile
  static const kDoctorProfileRoute = '/doctor_profile';

  ///Doctor login
  static const kkDoctorLoginRoute = '/doctor_login';

  ///Doctor info
  static const kDoctorInfoRoute = '/doctor_info';

  ///Doctor list
  static const kDoctorListRoute = '/doctor_list';

  ///Doctor home
  static const kDoctorHomeRoute = '/doctor_home';

  ///Forget password
  static const kForgotPasswordRoute = '/forgot_password';

  ///Verify Code
  static const kVerifyCodeRoute = '/verify_code';

  ///Verify Code
  static const kConfirmCodeRoute = '/confirm_code';

  ///splash
  ///
  static const kSplashRoute = '/';

  ///
  static final router = GoRouter(
    routes: [
      ///
      ///Splash routes
      ///
      GoRoute(
        path: kSplashRoute,
        builder: (context, state) => const SplashScreen(),
      ),

      ///
      ///Chat routes
      ///
      GoRoute(
        path: kChatRoute,
        builder: (context, state) => SelectChat(
          chatBoxList: const [],
        ),
      ),

      ///
      ///Model routes
      ///
      GoRoute(
        path: kModelInfoRoute,
        builder: (context, state) => const ModelDetailsView(),
      ),

      ///
      /// Patient routes
      ///
      GoRoute(
        path: kPatientProfileRoute,
        builder: (context, state) => const PatientProfileView(),
      ),
      GoRoute(
        path: kPatientLoginRoute,
        builder: (context, state) => const PatientLoginView(),
      ),

      GoRoute(
        path: kEditPatientPasswordRoute,
        builder: (context, state) => const EditPatientPasswordView(),
      ),

      GoRoute(
        path: kPatientSignupRoute,
        builder: (context, state) => const PatientSignUpView(),
      ),
      GoRoute(
        path: kPatientHomeRoute,
        builder: (context, state) => const PatientHomeView(),
      ),

      GoRoute(
        path: kEditPatientInfoRoute,
        builder: (context, state) => EditPatientInfoView(),
      ),

      // GoRoute(
      //   path: kForgotPasswordRoute,
      //   builder: (context, state) => VerifyEmailCard(),
      // ),

      GoRoute(
        path: kVerifyCodeRoute,
        builder: (context, state) => const VerifyCodeCard(),
      ),

      // GoRoute(
      //   path: kConfirmCodeRoute,
      //   builder: (context, state) => ConfirmNewPassword(),
      // ),

      ///
      ///Doctor routes
      ///
      GoRoute(
        path: kDoctorProfileRoute,
        builder: (context, state) => const DoctorProfileView(),
      ),
      GoRoute(
        path: kEditDoctorInfoRoute,
        builder: (context, state) => EditDoctorInfoView(),
      ),
      GoRoute(
        path: kEditDoctorPasswordRoute,
        builder: (context, state) => const EditDoctorPasswordView(),
      ),

      GoRoute(
        path: kDoctorFormRoute,
        builder: (context, state) => FormDoctor(),
      ),
      GoRoute(
        path: kkDoctorLoginRoute,
        builder: (context, state) => const DoctorLoginView(),
      ),
      GoRoute(
        path: kDoctorHomeRoute,
        builder: (context, state) => const DoctorHomeView(),
      ),

      ///
      GoRoute(
        path: kDoctorListRoute,
        builder: (context, state) => const DoctorList(),
      ),

      ///
      ///Pick image
      ///
      GoRoute(
        path: kPickImageRoute,
        builder: (context, state) => PickImageWidget(),
      ),
      GoRoute(
        path: kConfirmPatientImageRoute,
        builder: (context, state) => const ConfirmImage(),
      ),
      GoRoute(
        path: kConfirmDoctorImageRoute,
        builder: (context, state) => const DoctorConfirmImage(),
      ),
    ],
  );
}
