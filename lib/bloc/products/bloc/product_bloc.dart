



import 'package:ecomfix/bloc/products/bloc/product_event.dart';
import 'package:ecomfix/bloc/products/bloc/product_state.dart';
import 'package:ecomfix/models/products/top-rated-product.dart';
import 'package:ecomfix/urls/urls_links_class/urls.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../api/api_service.dart';


class ProductBloc extends Bloc<ProductEvents, ProductState>{
  ApiProductHelper apiHelper;
  ProductBloc({required this.apiHelper}) : super(ProductInitialState()){

    on<TopRatedApiFetchEvent>((event, emit) async {
      emit(ProductLoadingState());

      try{

        final rawData = await apiHelper.getRequest(apiUrl: UrlsProductHelper.URL_TOP_RATED);

        final productModel = Model_123.fromJson(rawData);

        emit(ProductLoadedState(products: productModel.products!));

      } catch(e){
        
        emit(ProductErrorState(errorMsg: e.toString()));
        
      }
    });

  }

}












/*


const String url = "https://www.infusevalue.live/api/v1/products/top-rated";

var saveBody;
Future getRequest({required String apiUrl}) async {

  final requestUri = Uri.parse(url);
  final response = await http.get(requestUri);

  try{

    if(response.statusCode == 200) {
      final body = jsonDecode(response.body);
      saveBody = TopRatedProduct.fromJson(body);
      log("body saved on model ");
      return saveBody;
    }

    else  {
      log("body not saved on model ");
      log('error');
    }

  } catch(e) {
    log(e.toString());
  }

}

emit(ProductLoadedState(products:saveBody ));*/
