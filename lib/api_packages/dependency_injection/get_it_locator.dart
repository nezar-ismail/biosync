import 'package:get_it/get_it.dart';
import '../../features/chat/cubit/socket_cubit/socket_cubit.dart';

final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<SocketCubit>(SocketCubit());
}
