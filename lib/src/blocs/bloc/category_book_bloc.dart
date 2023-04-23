import 'package:bloc/bloc.dart';

import '../../models/category_book.dart';
import '../../services/category_service/category_service.dart';
import '../../shared/helpers/iterable_helper.dart';
import 'category_book_event.dart';
import 'category_book_state.dart';

class CategoryBookBloc extends Bloc<CategoryBookEvent, CategoryBookState> {
  final CategoryService _categoryService;
  List<CategoryBook> _categories = [];
  CategoryBookBloc(this._categoryService) : super(CategoryBookInitial()) {
    on<CategoryBookRequested>((event, emit) async {
      emit(CategoryBookLoadInProgress());
      try {
        final results = await _categoryService.getCategories();
        if (IterableHelper.isNotNullOrEmpty(results)) {
          _categories = results!;
        }
        emit(CategoryBookLoadSuccess(_categories));
      } catch (e) {
        emit(CategoryBookLoadFailure());
      }
    });
  }
}
