// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:zcart_vendor/application/app/order/order_details_provider.dart';

class PDFScreen extends HookConsumerWidget {
  final int orderId;

  const PDFScreen({Key? key, required this.orderId}) : super(key: key);

  // late Completer<PDFViewController> _controller;

  @override
  Widget build(BuildContext context, ref) {
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () async {
        ref.read(orderDetailsProvider(orderId).notifier).getInvoice();
      });
      return null;
    }, []);
    // final _currentPage = useState(0);
    // final _isReady = useState(false);
    // final errorMessage = useState('');
    // final controller = useMemoized(() => Completer<PDFViewController>());

    final pdfFile = ref
        .watch(orderDetailsProvider(orderId).select((value) => value.invoice));
    final loading = ref
        .watch(orderDetailsProvider(orderId).select((value) => value.loading));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Invoice"),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: loading
          ? const CircularProgressIndicator()
          : pdfFile == null
              ? const Center(
                  child: Text('File Not Found'),
                )
              : Stack(
                  children: const [
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 16),
                    //   child: PDFView(
                    //     filePath: pdfFile.path,
                    //     enableSwipe: true,
                    //     swipeHorizontal: true,
                    //     autoSpacing: false,
                    //     pageFling: true,
                    //     pageSnap: true,
                    //     defaultPage: _currentPage.value,
                    //     onRender: (pages) {
                    //       pages = pages;
                    //       _isReady.value = true;
                    //     },
                    //     onError: (error) {
                    //       errorMessage.value = error.toString();
                    //     },
                    //     onPageError: (page, error) {
                    //       errorMessage.value = '$page: ${error.toString()}';
                    //     },
                    //     onViewCreated: (PDFViewController pdfViewController) {
                    //       controller.complete(pdfViewController);
                    //     },
                    //     onLinkHandler: (String? uri) {
                    //       launchUrlString(uri ?? "");
                    //     },
                    //     onPageChanged: (int? page, int? total) {
                    //       _currentPage.value = page!;
                    //     },
                    //   ),
                    // ),
                    // errorMessage.value.isEmpty
                    //     ? !_isReady.value
                    //         ? const Center(
                    //             child: CircularProgressIndicator.adaptive(),
                    //           )
                    //         : Container()
                    //     : Center(
                    //         child: Text(errorMessage.value),
                    //       )
                  ],
                ),
    );
  }
}

// Future<String?> generateInvoice(String api, String name) async {
//   final _response = await getRequest(api, bearerToken: true);
//   if (_response.body.isEmpty) {
//     return null;
//   }
//   if (_response.statusCode > 206) {
//     return null;
//   }

//   final File _file = File(await getTemporaryDirectory()
//       .then((value) => value.path + "/" + "$name.pdf"));
//   final _res = await _file.writeAsBytes(_response.bodyBytes);

//   return _res.path;
// }
