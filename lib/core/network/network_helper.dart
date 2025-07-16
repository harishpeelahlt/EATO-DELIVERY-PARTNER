
import 'package:eato_delivery_partner/components/custom_snackbar.dart';
import 'package:eato_delivery_partner/core/network/network_service.dart';
import 'package:flutter/material.dart';


class NetworkHelper {
  static Future<bool> checkInternetAndShowSnackbar({
    required BuildContext context,
    required NetworkService networkService,
  }) async {
    bool isConnected = await networkService.hasInternetConnection();
    
    if (!isConnected) {
      print("No Internet Connection");
      
      CustomSnackbars.showErrorSnack(
        context: context,
        title: 'Alert',
        message: 'Please check Internet Connection',
      );

      return false; 
    }
    
    return true; 
  }
}

//  bool isConnected = await NetworkHelper.checkInternetAndShowSnackbar(
    //   context: context,
    //   networkService: networkService,
    // );
    // if (!isConnected) return;