import 'package:dailytimelog/4_utils/iap/package_plan.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class SubscriptionItemWidget extends StatefulWidget {
  ProductDetails? productDetails;
  PurchaseDetails? previousPurchase;
  Packageplan packageplan;
  bool isBestBuy;
  String currentSelectedSubscribeId;
  Map<String, PurchaseDetails> purchases;
  Function purchaseCallBack;
  Function selectCallBack;
  bool isProUser;
  SubscriptionItemWidget(this.productDetails, this.previousPurchase, this.packageplan, this.currentSelectedSubscribeId, this.isBestBuy,this.purchases, this.isProUser, this.selectCallBack ,this.purchaseCallBack);

  @override
  State<SubscriptionItemWidget> createState() => _SubscriptionItemWidgetState();
}

class _SubscriptionItemWidgetState extends State<SubscriptionItemWidget> {

  Widget getCustomText(String text, Color color, int maxLine,
      TextAlign textAlign, FontWeight fontWeight, double textSizes) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          decoration: TextDecoration.none,
          fontSize: textSizes,
          color: color,
          fontWeight: fontWeight),
      maxLines: maxLine,
      textAlign: textAlign,
    );
  }

  Widget getSmallIconButtonWidget(
      BuildContext context, String s, Function function,
      {Color? borderColor, Color? fillColor ,double? btnHeight, Color? fontColor, String? asset, bool? isHorizontal}) {
    double height = btnHeight == null
        ? 30
        : btnHeight;
    double radius = 7;
    double fontSize = 12;

    return GestureDetector(
      child: Container(
        height: height,
        width: MediaQuery.of(context).size.width/3-50,

        child: Stack(
          children: [
            asset!=null && asset.length>0?
            Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(left: 20),
                child: Image.asset(asset??"", width: 20, height: 20,)):SizedBox(),
            Center(
                child: Text(s, )),
          ],
        ),
      ),
      onTap: () {
        function();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print(widget.currentSelectedSubscribeId +"========"+ widget.packageplan.planId!);
    return Container(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          widget.isBestBuy==true?
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width/3-50,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text("BEST BUY", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
          ):Container(
            width: MediaQuery.of(context).size.width/3-50,
            height: 30,
          ),
          GestureDetector(
            onTap: (){
              //widget.selectCallBack(widget.packageplan);
            },
            child: Container(
              width: MediaQuery.of(context).size.width/3-40,
              height: 150,
              decoration: BoxDecoration(
                color: widget.currentSelectedSubscribeId == widget.packageplan.planId? Colors.white: Colors.grey,
                border: Border.all(
                  width: 2,
                  color: widget.currentSelectedSubscribeId == widget.packageplan.planId? Colors.red: Colors.grey,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  getCustomText(
                      "${widget.packageplan.planName}".replaceAll(" ","\n"),
                      Colors.black,
                      2,
                      TextAlign.center,
                      FontWeight.bold,
                      22),
                  getCustomText(
                      "£${ (double.parse(widget.packageplan.price!)/double.parse(widget.packageplan.days!)).toStringAsFixed(2)}/ day.",
                      Colors.black,
                      1,
                      TextAlign.center,
                      FontWeight.w500,
                      14),
                  Expanded(child: Container()),
                  getCustomText(
                      "£${ widget.packageplan.price!}",
                      Colors.black,
                      1,
                      TextAlign.center,
                      FontWeight.bold,
                      14),
                  getCustomText(
                      int.parse(widget.packageplan.days??"0")<10? "billed weekly":int.parse(widget.packageplan.days??"20")<40&& int.parse(widget.packageplan.days??"20")>10?"billed monthly":"billed yearly",
                      Colors.black,
                      1,
                      TextAlign.center,
                      FontWeight.w500,
                      12),
                  SizedBox(height: 10,)

                ],
              ),
            ),
          ),
          widget.currentSelectedSubscribeId == widget.packageplan.planId?
          Container(
            height: 30,
            alignment: Alignment.center,
            child: Text('Current Plan', style: TextStyle(fontSize: 12, color: Colors.red),),
          ):
          getSmallIconButtonWidget(
              context, widget.isProUser==true? 'Upgrade' : 'Purchase', borderColor: Colors.red, fillColor : Colors.red, fontColor : Colors.white, asset: "", () {
            widget.purchaseCallBack(widget.packageplan, widget.previousPurchase, widget.productDetails, widget.purchases);
          }),
        ],
      ),
    );
  }
}