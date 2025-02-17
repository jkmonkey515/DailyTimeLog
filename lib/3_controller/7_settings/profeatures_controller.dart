import 'dart:io';

import 'package:dailytimelog/3_controller/5_statistics/statistics_controller.dart';
import 'package:dailytimelog/3_controller/7_settings/settings_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import '../../4_utils/constats.dart';
import '../6_profile/profile_controller.dart';
//import for AppStoreProductDetails
import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
//import for SKProductWrapper
import 'package:in_app_purchase_storekit/store_kit_wrappers.dart';
class ProfeaturesController extends GetxController {
  final cache = GetStorage();
  final InAppPurchase iap = InAppPurchase.instance;
  @override
  void onInit() {
    super.onInit();
    restoreIap();
    handleIAp();
  }
  handleIAp(){    
    iap.purchaseStream.listen((List<PurchaseDetails> purchaseDetailsList) async {
      for (PurchaseDetails purchase in purchaseDetailsList) {
        if (Platform.isIOS && purchase.pendingCompletePurchase) {
            try {
            await InAppPurchase.instance.completePurchase(purchase);
            print('Canceled purchase cleaned up.');
          } catch (e) {
            print('Failed to complete canceled purchase: $e');
          }
        }
        if (purchase.status == PurchaseStatus.purchased) {
          // Verify and deliver the purchase
          processSuccessIap();
        } else if (purchase.status == PurchaseStatus.error) {
          await InAppPurchase.instance.completePurchase(purchase);
          Constants.showToastMessage("Some error has been happened");
        }  else if (purchase.status == PurchaseStatus.restored) {
          // Restore purchases
          processSuccessIap();
          Constants.showToastMessage("restored purchase");
        }
      }
    });
  }


  restoreIap(){
    iap.restorePurchases();
  }
  void tryIap() async{
    bool available = await iap.isAvailable();
    if (available) {
      Set<String> productIds = {'profeature1'};
      if(Platform.isIOS){
        productIds = {'trainee.iap.profeature'};
      }
      final ProductDetailsResponse response = await iap.queryProductDetails(productIds);
      //print(response.notFoundIDs);
      //print(response.productIds);
      if (response.notFoundIDs.isEmpty) {
        final paymentWrapper = SKPaymentQueueWrapper();
        final transactions = await paymentWrapper.transactions();
        transactions.forEach((transaction) async {
            await paymentWrapper.finishTransaction(transaction);
        });

        List<ProductDetails> products = response.productDetails;
        final ProductDetails product = products[0];
        final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
        iap.buyNonConsumable(purchaseParam: purchaseParam); // For non-consumables
      }else{
        Constants.showToastMessage("The in app purchase product does not exist");
      }
    }else{
      Constants.showToastMessage("In app purchase service is not available");
    }

    //processSuccessIap();



    // Navigator.of(Get.context!).push(MaterialPageRoute(builder: (context) {
    //   return SubscriptionWidget(isClose: (){
    //     Future.delayed(Duration(milliseconds: 200), () {
    //       //checkLoginFirst();
    //     });
    //   },);
    //
    // },)).then((value) {
    //   Future.delayed(Duration(milliseconds: 200), () {
    //     //checkLoginFirst();
    //   });
    // });
  }

  processSuccessIap(){
    cache.remove('ispurchase');
    cache.write("ispurchase", 1);
    bool isProfileController = Get.isRegistered<ProfileController>();
    if(isProfileController){
      ProfileController profileController = Get.find();
      profileController.initData();
    }

    bool isSettingsController = Get.isRegistered<SettingsController>();
    if(isSettingsController){
      SettingsController settingsController = Get.find();
      settingsController.updatePurchaseStatus(1);
    }

    bool isStatisticsController = Get.isRegistered<StatisticsController>();
    if(isStatisticsController){
      StatisticsController statisticsController = Get.find();
      statisticsController.updatePurchaseStatus(1);
    }
    Get.back();
  }

}