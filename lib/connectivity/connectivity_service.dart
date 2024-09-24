// import 'package:dio/dio.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../utils/common_style.dart';

// class ApiMethod {
//   Ref? ref;
//   ApiMethod({required this.ref});
//   Dio dio = Dio();
//   // (dioOptions)..interceptors.add(Logging());

//   Future<Respond> postDioRequest(String url) async {
//     try {
//       bool result = await InternetConnection().hasInternetAccess;
//       if (result) {
//         final token = await tokenWatch(ref!);

//         Response response =
//             await dio.post(url, options: Options(headers: token));

//         log("response success ${response.statusCode}\n response success ${response.data}");

//         return checkStatus(response);
//       } else {
//         ref!.read(internetProvider.notifier).state = true;
//         noInernet();
//         return Respond(success: false, message: Msg.somethingWrong, data: null);
//       }
//     } on DioException catch (err) {
//       log("Url....${err.response!.realUri}");
//       String error = (err.response == null)
//           ? "Something went wrong"
//           : err.response!.data['message'].toString();
//       ref!.read(errorProvider.notifier).state = error;
//       checkStatus(err.response!);
//       snackBarMessage(msg: error, color: AppColor.redClr);

//       return Respond(success: false, message: error, data: null);
//     } finally {
//       ref!.invalidate(loadingProvider);
//     }
//   // }}