import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hero_market/core/resources/styles/colors.dart';
import 'package:hero_market/core/utils/core_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentProfileView extends StatefulWidget {
  const PaymentProfileView({super.key, required this.sessionUrl});
  static const String path = '/payment-profile';
  final String sessionUrl;
  @override
  State<PaymentProfileView> createState() => _PaymentProfileViewState();
}

class _PaymentProfileViewState extends State<PaymentProfileView> {
  late WebViewController controller;
  final loadingNotifier = ValueNotifier(false);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller = WebViewController()
      ..setJavaScriptMode(
        JavaScriptMode.unrestricted,
      )
      ..setBackgroundColor(AppColors.lightThemeTintStockColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (_) {
            loadingNotifier.value = true;
          },
          onPageFinished: (_) {
            loadingNotifier.value = false;
          },
          onWebResourceError: (error) {
            CoreUtils.showSnackBar(context,
                message: '${error.errorCode} ${error.description}');
          },
          onNavigationRequest: (request) {
            if (request.url.startsWith('https://dbestech.biz/ecomly')) {
              context.pop();
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.sessionUrl));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: loadingNotifier, builder: (_, loading, __) {
              if (loading) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: AppColors.lightThemePrimaryColor,
                  ),
                );
              }
              return WebViewWidget(controller: controller);
            }),
      ),
    );
  }
}
