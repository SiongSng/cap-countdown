import 'dart:io';

import 'package:cap_countdown/main.dart';
import 'package:cap_countdown/src/util/cap_util.dart';
import 'package:cap_countdown/src/widgets/cap_time_left.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:pay/pay.dart';

import 'package:cap_countdown/src/config/config_payment.dart'
    as payment_configurations;

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage>
    with AutomaticKeepAliveClientMixin {
  String donateAmount = '50';
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // 當用戶點擊屏幕的非文字填寫部分時關閉鍵盤。
      },
      child: ListView(
        children: [
          _buildHourglass(),
          const CAPTimeLeft(showDetail: true),
          _buildPostExamTools(),
          if (Platform.isIOS) _buildDonateButton()
        ],
      ),
    );
  }

  Widget _buildHourglass() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SpinKitPouringHourGlassRefined(
            color: Theme.of(context).dividerColor,
            duration: const Duration(minutes: 1),
            size: 200),
      ),
    );
  }

  Widget _buildPostExamTools() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              '考後懶人包（112 年）',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                FilledButton.icon(
                  onPressed: () {
                    CAPUtil.checkChoiceFillingTime(
                        context,
                        config.examResultAnnouncedTime,
                        'https://score.rcpet.edu.tw',
                        '成績查詢',
                        '現在還無法查詢成績，請等待至 %time% 方可查詢。');
                  },
                  icon: const Icon(Icons.search_outlined),
                  label: const Text('會考成績'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    launchUrlString(
                        'https://cap.rcpet.edu.tw/exam/112/112P_Answer.pdf',
                        mode: LaunchMode.externalApplication);
                  },
                  icon: const Icon(Icons.book_outlined),
                  label: const Text('參考答案'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    launchUrlString(
                        'https://cap.rcpet.edu.tw/exam/112/112%E5%B9%B4%E5%9C%8B%E4%B8%AD%E6%95%99%E8%82%B2%E6%9C%83%E8%80%83%E5%90%84%E7%A7%91%E7%AD%89%E7%B4%9A%E5%8A%A0%E6%A8%99%E7%A4%BA%E8%88%87%E7%AD%94%E5%B0%8D%E9%A1%8C%E6%95%B8%E5%B0%8D%E7%85%A7%E8%A1%A8(C8B9-D792-CE57-B546-ED55-255F-E713-2D49).pdf',
                        mode: LaunchMode.externalApplication);
                  },
                  icon: const Icon(Icons.book_outlined),
                  label: const Text('題數與等級對照表'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, '/high-school-choice-filling');
                  },
                  icon: const Icon(Icons.volunteer_activism_outlined),
                  label: const Text('志願選填（高中、高職）'),
                ),
                FilledButton.icon(
                  onPressed: () {
                    final data = config.choiceFilling.fiveYearCollege;
                    CAPUtil.checkChoiceFillingTime(context, data.startTime,
                        data.link, '五專優免選填志願', '現在還無法選填志願，請等待至 %time% 方可選填。');
                  },
                  icon: const Icon(Icons.volunteer_activism_outlined),
                  label: const Text('志願選填（五專優免）'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDonateButton() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            final applePayButtonKey = ValueKey(donateAmount);
            final applePayButton = ApplePayButton(
              key: applePayButtonKey,
              paymentConfiguration: PaymentConfiguration.fromJsonString(
                  payment_configurations.defaultApplePay),
              paymentItems: [
                PaymentItem(
                  label: '會考沙漏-贊助',
                  amount: donateAmount,
                  status: PaymentItemStatus.final_price,
                ),
              ],
              onPaymentResult: (paymentResult) {
                _showPaymentResultDialog();
              },
              style: ApplePayButtonStyle.black,
              type: ApplePayButtonType.donate,
              height: 50,
            );
            return Column(
              children: [
                Text(
                  '支持我們的專案',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: constraints.maxWidth,
                  child: TextField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: '贊助金額',
                      hintText: '請輸入金額',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      if (double.tryParse(value) != null) {
                        setState(() {
                          donateAmount = value;
                        });
                      } else {
                        setState(() {
                          donateAmount = "50";
                        });
                      }
                    },
                  ),
                ),
                const SizedBox(height: 12), // Provide some spacing
                SizedBox(
                  width: constraints.maxWidth,
                  child: applePayButton,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showPaymentResultDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('成功贊助通知'),
          content: MarkdownBody(
              data:
                  '感謝您支持我們得專案\n\n您可以透過[加入我們的BETA測試版](https://testflight.apple.com/join/aFyl60Fj)\n\n使用發中或測試中的功能',
              onTapLink: (text, href, title) {
                if (href == null) return;
                launchUrlString(href);
              }),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
              child: const Text('了解'),
            ),
          ],
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
