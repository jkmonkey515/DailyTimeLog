import 'dart:async';
import 'dart:io';

import 'package:dailytimelog/4_utils/iap/package_plan.dart';
import 'package:dailytimelog/4_utils/iap/subscription_item.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:in_app_purchase_android/billing_client_wrappers.dart';
import 'package:in_app_purchase_android/in_app_purchase_android.dart';
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
import '../constats.dart';
import 'dialog_util.dart';



List<String> _kProductIds = <String>[];
List<Packageplan>? plans = [];


class SubscriptionWidget extends StatefulWidget {

  final Function? isClose;
  const SubscriptionWidget({Key? key,this.isClose}) : super(key: key);

  @override
  State<SubscriptionWidget> createState() => _SubscriptionWidgetState();
}

class _SubscriptionWidgetState extends State<SubscriptionWidget> {
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<String> _notFoundIds = <String>[];
  List<ProductDetails> _products = <ProductDetails>[];
  List<PurchaseDetails> _purchases = <PurchaseDetails>[];
  bool _isAvailable = false;
  bool _purchasePending = false;
  bool _loading = true;
  String? _queryProductError;

  String currentSubscriptionItem = "";
  String prevPurchaseId = "";

  late DialogUtil dialogUtil;

  @override
  void initState() {
    Constants.showToastMessage("Please wait until restore purchases");
    restorePurchase();
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription =
        purchaseUpdated.listen((List<PurchaseDetails> purchaseDetailsList) {
          _purchases.addAll(purchaseDetailsList);
          print("old purchases==="+_purchases.length.toString());
          _listenToPurchaseUpdated(purchaseDetailsList);
        }, onDone: () {
          _subscription.cancel();
          Constants.showToastMessage("Subscription Done");
        }, onError: (Object error) {
          // handle error here.
          print("subscrip==errrr");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              action: SnackBarAction(
                label: 'Purchase Updated Error!',
                onPressed: () {
                  // Code to execute.
                },
              ),
            ),
          );
        });
    dialogUtil = DialogUtil(context);
    initStoreInfo();
    super.initState();
  }

  Future<bool> _requestPop() {
    Navigator.pop(context);
    return Future.value(false);
  }


  purchaseNewItem( ProductDetails? productDetails, Map<String, PurchaseDetails> purchases, String prevPurchaseId){

    late PurchaseParam purchaseParam;

    if (Platform.isAndroid) {
      // NOTE: If you are making a subscription purchase/upgrade/downgrade, we recommend you to
      // verify the latest status of you your subscription by using server side receipt validation
      // and update the UI accordingly. The subscription purchase status shown
      // inside the app may not be accurate.
      print(prevPurchaseId);
      String prevProductId = "";
      plans!.forEach((element) {
        print(element.planId);
        if(element.planId == prevPurchaseId) prevProductId = element.skuIdAndroid!;
      });
      final GooglePlayPurchaseDetails? oldSubscription =
      _getOldSubscription(productDetails!, purchases, prevProductId);
      purchaseParam = GooglePlayPurchaseParam(
          productDetails: productDetails,
          changeSubscriptionParam: (oldSubscription != null)
              ? ChangeSubscriptionParam(
            oldPurchaseDetails: oldSubscription,
            prorationMode:
            ProrationMode.immediateWithTimeProration,
          )
              : null);
    } else {
      purchaseParam = PurchaseParam(
        productDetails: productDetails!,
      );
    }

    // if (productDetails.id == _kConsumableId) {
    //   _inAppPurchase.buyConsumable(
    //       purchaseParam: purchaseParam,
    //       autoConsume: _kAutoConsume);
    // } else {
    _inAppPurchase.buyNonConsumable(
        purchaseParam: purchaseParam);
    //}
  }

  subscriptionItemClicked(Packageplan packageplan){
    setState(() {

    });
  }

  purchaseOrUpgrade(Packageplan packageplan, PurchaseDetails? previousPurchase, ProductDetails? productDetails, Map<String, PurchaseDetails> purchases){
    prevPurchaseId = currentSubscriptionItem;
    currentSubscriptionItem = packageplan.planId!;

    // previousPurchase != null?
    // confirmPriceChange(context,packageplan,  previousPurchase,  productDetails, purchases)
    //     : purchaseNewItem(packageplan,  previousPurchase,  productDetails, purchases);


    // if(isProUser == true){
    //   purchaseNewItem(packageplan,  previousPurchase,  productDetails, purchases, prevPurchaseId);
    // }else{
    purchaseNewItem(  productDetails, purchases, prevPurchaseId);
    //}
  }

  changeTimestampToDate(String? timestamp){
    if(timestamp != null && timestamp.length>5){
      int ts = int.parse(timestamp);
      DateTime tsdate = DateTime.fromMillisecondsSinceEpoch(ts);
      int day =  tsdate.day;
      int month = tsdate.month;
      String date = day<10? "0"+day.toString(): day.toString();
      String months = month<10? "0"+month.toString():month.toString();
      String datetime = date+"-"+months +"-"+tsdate.year.toString();
      return datetime;
    }else {
      return timestamp;
    }
  }



  Future<void> initStoreInfo() async {
    // PlanData? planData = await getAllPackagesPlanNew();
    // if(planData!=null && planData.packageplan!=null) plans = planData.packageplan;
    // if(planData!=null && planData.isPro!=null && planData.isPro=="1") {
    //   isProUser= true;
    //   currentSubscriptionItem = planData.planId!;
    // }
    currentSubscriptionItem ="planId";
    _kProductIds = [];
    plans!.forEach((element) {
      if(Platform.isIOS){
        _kProductIds.add(element.skuIdIOS!);
      }else{
        _kProductIds.add(element.skuIdAndroid!);
      }
    });

    final bool isAvailable = await _inAppPurchase.isAvailable();
    if (!isAvailable) {
      setState(() {
        _isAvailable = isAvailable;
        _products = <ProductDetails>[];
        _purchases = <PurchaseDetails>[];
        _notFoundIds = <String>[];
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iosPlatformAddition.setDelegate(ExamplePaymentQueueDelegate());
    }

    final ProductDetailsResponse productDetailResponse =
    await _inAppPurchase.queryProductDetails(_kProductIds.toSet());
    if (productDetailResponse.error != null) {
      setState(() {
        _queryProductError = productDetailResponse.error!.message;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    if (productDetailResponse.productDetails.isEmpty) {
      setState(() {
        _queryProductError = null;
        _isAvailable = isAvailable;
        _products = productDetailResponse.productDetails;
        _purchases = <PurchaseDetails>[];
        _notFoundIds = productDetailResponse.notFoundIDs;
        _purchasePending = false;
        _loading = false;
      });
      return;
    }

    setState(() {
      _isAvailable = isAvailable;
      _products = productDetailResponse.productDetails;
      _notFoundIds = productDetailResponse.notFoundIDs;
      _purchasePending = false;
      _loading = false;
    });

  }

  @override
  void dispose() {
    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iosPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      iosPlatformAddition.setDelegate(null);
    }
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> stack = <Widget>[];

    if (_purchasePending) {
      stack.add(
        Center(
          child: CircularProgressIndicator(),
        ),
      );
    }else{
      if (_queryProductError == null) {
        stack.add(_buildConnectionCheckTile());
        stack.add(_buildProductList());
      } else {
        stack.add(Center(
          child: Text(_queryProductError!),
        ));
      }
    }

    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(backgroundColor: Colors.blue),
        resizeToAvoidBottomInset: false,
        body: Column(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20,),
                  Expanded(
                    child: Container(
                      color: Colors.white,
                      height: 320,
                      child: Stack(
                        children: [
                          const Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                                "Shape Up With Your\nPersonalized Plan!",
                                ),
                          ),
                          Align(
                              alignment: Alignment.topLeft,
                              child: GestureDetector(
                                  onTap: () {
                                    _requestPop();
                                  },
                                  child: Icon(Icons.close,).marginOnly(left: 10) )),
                          Align(
                              alignment: Alignment.topRight,
                              child: GestureDetector(
                                  onTap: () {
                                    _requestPop();
                                  },
                                  child: _buildRestoreButton() ))
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: stack,
                    ).paddingSymmetric(horizontal: 20),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Card _buildConnectionCheckTile() {
    if (_loading) {
      return const Card(child: ListTile(title: Text('Trying to connect...')));
    }
    final Widget storeHeader = ListTile(
      leading: Icon(_isAvailable ? Icons.check : Icons.block,
          color: _isAvailable
              ? Colors.green
              : ThemeData.light().colorScheme.error),
      title:
      Text('The store is ${_isAvailable ? 'available' : 'unavailable'}.'),
    );
    List<Widget> children = <Widget>[storeHeader];
    if(_isAvailable) children = [];
    if (!_isAvailable) {
      children.addAll(<Widget>[
        const Divider(),
        ListTile(
          title: Text('Not connected',
              style: TextStyle(color: ThemeData.light().colorScheme.error)),
          subtitle: const Text(
              'Unable to connect to the payments processor. Has this app been configured correctly? See the example README for instructions.'),
        ),
      ]);
    }
    return Card(child: Column(children: children));
  }

  Widget _buildProductList() {
    if (_loading) {
      return const Card(
          child: ListTile(
              leading: CircularProgressIndicator(),
              title: Text('Fetching Items...')));
    }
    if (!_isAvailable) {
      return const SizedBox();
    }
    //const ListTile productHeader = ListTile(title: Text('Products for Sale'));
    final List<Widget> productList = <Widget>[];
    if (_notFoundIds.isNotEmpty) {
      productList.add(ListTile(
          title: Text('[${_notFoundIds.join(", ")}] not found',
              style: TextStyle(color: ThemeData.light().colorScheme.error)),
          subtitle: const Text(
              'This app needs special configuration to run. Please see example/README.md for instructions.')));

    }

    // This loading previous purchases code is just a demo. Please do not use this as it is.
    // In your app you should always verify the purchase data using the `verificationData` inside the [PurchaseDetails] object before trusting it.
    // We recommend that you use your own server to verify the purchase data.
    final Map<String, PurchaseDetails> purchases =
    Map<String, PurchaseDetails>.fromEntries(
        _purchases.map((PurchaseDetails purchase) {
          if (purchase.pendingCompletePurchase) {
            _inAppPurchase.completePurchase(purchase);
          }
          return MapEntry<String, PurchaseDetails>(purchase.productID, purchase);
        }));

    List<Widget> priceItemWidgets = [];

    for(int i=0; i<plans!.length; i++){
      bool isBest = false;
      if(i==2) isBest = true;
      ProductDetails? correspondingProduct;
      _products.forEach((element) {
        if(Platform.isAndroid &&  element.id == plans![i].skuIdAndroid) correspondingProduct = element;
        if(Platform.isIOS &&  element.id == plans![i].skuIdIOS) correspondingProduct = element;
      });
      if(i<=_products.length){
        final PurchaseDetails? previousPurchase = purchases[_products[i].id];
        priceItemWidgets.add(
            SubscriptionItemWidget(
                correspondingProduct,
                previousPurchase,
                plans![i],
                currentSubscriptionItem,
                isBest,
                purchases ,
                false,
                subscriptionItemClicked,
                purchaseOrUpgrade
            ));
      }

    }
    print("plans==="+priceItemWidgets.length.toString());
    Widget subscribeButtons = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: priceItemWidgets,
    );


    productList.add(subscribeButtons);

    return Column(
        children: productList);
  }

  restorePurchase() async{
    await _inAppPurchase.restorePurchases();
  }



  Widget _buildRestoreButton() {
    if (_loading) {
      return Container();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(0,3,10,0),
      child: GestureDetector(
        onTap: () => _inAppPurchase.restorePurchases(),
        child: const Text('Restore'),
      ),
    );
  }

  void showPendingUI() {
    setState(() {
      _purchasePending = true;
    });
  }

  Future<void> deliverProduct(PurchaseDetails purchaseDetails) async {
    if(currentSubscriptionItem.length==0) return;
    // IMPORTANT!! Always verify purchase details before delivering the product.
    _loading = true;
    String purchaseToken = "ios";
    var purchaseID = purchaseDetails.purchaseID;

    if (purchaseDetails is GooglePlayPurchaseDetails) {
      PurchaseWrapper billingClientPurchase = (purchaseDetails as GooglePlayPurchaseDetails).billingClientPurchase;
      print(billingClientPurchase.originalJson);
      print(billingClientPurchase.purchaseToken);
      purchaseToken = billingClientPurchase.purchaseToken;
    }
    if (purchaseDetails is AppStorePurchaseDetails) {
      final originalTransaction = purchaseDetails.skPaymentTransaction.originalTransaction;
      if (originalTransaction != null) {
        purchaseID = originalTransaction.transactionIdentifier;
      }
    }

    // ModelAddPurchasePlan? completeResult = await addPurchasePlan(
    //   currentSubscriptionItem,
    //   changeTimestampToDate(purchaseDetails.transactionDate),
    //   purchaseToken,
    //   "1",
    //   Platform.isIOS? "PURCHASED":"4",
    //   purchaseId: purchaseID??"noId",
    // );

    setState(() {
      _purchases.add(purchaseDetails);
      _purchasePending = false;
      _loading = false;
    });
    //if(completeResult!= null && completeResult.data!.success==1){
      Constants.showToastMessage("You purchased successfully");
    // }else{
    //   Constants.showToastMessage(completeResult!.data!.error!);
    // }
    _requestPop();

  }

  void handleError(IAPError error) {
    if(error.message=="BillingResponse.userCanceled"){

    }else{
      Constants.showToastMessage(error.message+" "+error.code);
    }
    currentSubscriptionItem =  prevPurchaseId;
    prevPurchaseId = "";
    setState(() {
      _purchasePending = false;
      _loading = false;
    });
  }

  Future<bool> _verifyPurchase(PurchaseDetails purchaseDetails) {

    // IMPORTANT!! Always verify a purchase before delivering the product.
    // For the purpose of an example, we directly return true.
    return Future<bool>.value(true);
  }

  void _handleInvalidPurchase(PurchaseDetails purchaseDetails) {
    // handle invalid purchase here if  _verifyPurchase` failed.
    print("invalid purchase handle=====");
  }

  Future<void> _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList) async {
    for (final PurchaseDetails purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        Constants.showToastMessage("Subscription is processing");
        showPendingUI();
      } else {
        if (purchaseDetails.status == PurchaseStatus.error) {
          handleError(purchaseDetails.error!);
        } else if (purchaseDetails.status == PurchaseStatus.canceled) {
          handleError(purchaseDetails.error!);
        }else if (purchaseDetails.status == PurchaseStatus.purchased) {
          final bool valid = await _verifyPurchase(purchaseDetails);
          if (valid) {
            deliverProduct(purchaseDetails);
          } else {
            _handleInvalidPurchase(purchaseDetails);
            return;
          }
        }else if (purchaseDetails.status == PurchaseStatus.restored) {
          Constants.showToastMessage("Subscription Restored");
          //isProUser = true;
          setState(() {

          });
        }

        if (purchaseDetails.pendingCompletePurchase) {
          await _inAppPurchase.completePurchase(purchaseDetails);
        }
      }
    }
  }

  Future<void> confirmPriceChange(BuildContext context,Packageplan packageplan, PurchaseDetails? previousPurchase, ProductDetails? productDetails, Map<String, PurchaseDetails> purchases, String prevProductId) async {
    print("purchase upgraded==="+prevProductId);

    if (Platform.isIOS) {
      final InAppPurchaseStoreKitPlatformAddition iapStoreKitPlatformAddition =
      _inAppPurchase
          .getPlatformAddition<InAppPurchaseStoreKitPlatformAddition>();
      await iapStoreKitPlatformAddition.showPriceConsentIfNeeded();
    }
  }

  GooglePlayPurchaseDetails? _getOldSubscription(
      ProductDetails productDetails, Map<String, PurchaseDetails> purchases, String? oldSubscriptinoId) {
    // This is just to demonstrate a subscription upgrade or downgrade.
    // This method assumes that you have only 2 subscriptions under a group, 'subscription_silver' & 'subscription_gold'.
    // The 'subscription_silver' subscription can be upgraded to 'subscription_gold' and
    // the 'subscription_gold' subscription can be downgraded to 'subscription_silver'.
    // Please remember to replace the logic of finding the old subscription Id as per your app.
    // The old subscription is only required on Android since Apple handles this internally
    // by using the subscription group feature in iTunesConnect.
    if(oldSubscriptinoId==null || oldSubscriptinoId.length==0){
      return null;
    }
    GooglePlayPurchaseDetails? oldSubscription;
    _purchases.forEach((element) {
      if(element.productID==oldSubscriptinoId)
        oldSubscription =element as GooglePlayPurchaseDetails;
    });
    //oldSubscription = purchases[oldSubscriptinoId]! as GooglePlayPurchaseDetails;
    return oldSubscription;
  }
}

/// Example implementation of the
/// [`SKPaymentQueueDelegate`](https://developer.apple.com/documentation/storekit/skpaymentqueuedelegate?language=objc).
///
/// The payment queue delegate can be implementated to provide information
/// needed to complete transactions.
class ExamplePaymentQueueDelegate implements SKPaymentQueueDelegateWrapper {
  @override
  bool shouldContinueTransaction(
      SKPaymentTransactionWrapper transaction, SKStorefrontWrapper storefront) {
    return true;
  }

  @override
  bool shouldShowPriceConsent() {
    return false;
  }
}