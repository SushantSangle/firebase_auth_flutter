import 'package:flutter/material.dart';

//using this is ok only if there is just one loading indicator on one page
class LoadingNotifier extends ChangeNotifier {
  bool _loadingState = false;
  bool get loadingState => _loadingState;
  set loadingState(state) => _loadingState = state;

  @override
  notifyListeners(){
    super.notifyListeners();
  }

  setLoading(Future future,{Function onFinished,Function onError}) async{
    _loadingState = true;
    notifyListeners();
    try{
      var result = await future;
      _loadingState = false;
      notifyListeners();
      if(onFinished != null)
        onFinished();
      return result;
    }catch(e){
      _loadingState = false;
      notifyListeners();
      if(onError != null)
        onError();
      throw e;
    }
  }
}