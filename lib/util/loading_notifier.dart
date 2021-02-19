import 'package:flutter/material.dart';

//using this is ok only if there is just one loading indicator on one page
class LoadingNotifier extends ChangeNotifier {
  bool _loadingState = false;
  get loadingState => _loadingState;

  setLoading(Future future) async{
    _loadingState = true;
    notifyListeners();
    try{
      var result = await future;
      _loadingState = true;
      return result;
    }catch(e){
      _loadingState = false;
      notifyListeners();
      throw e;
    }
  }
}