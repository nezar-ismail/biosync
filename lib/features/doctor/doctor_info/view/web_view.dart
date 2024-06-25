import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebViews extends StatelessWidget {
  const PaymentWebViews({super.key, required this.url});
  final String url;

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> isLoading = ValueNotifier<bool>(true);
    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            isLoading.value = true;
          },
          onPageFinished: (url) {
            isLoading.value = false;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        foregroundColor: Colors.white,
        title: const Text('Payment'),
      ),
      body: ValueListenableBuilder<bool>(
        valueListenable: isLoading,
        builder: (context, isLoading, child) {
          return isLoading
              ? Center(child: Lottie.asset('assets/lottie/news_loading.json'))
              : WebViewWidget(controller: controller);
        },
      ),
    );
  }
}
