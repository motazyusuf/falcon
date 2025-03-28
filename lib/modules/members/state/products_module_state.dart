part of '../import/members_module_import.dart';

final class ProductsInitialState extends RenderDataState {
  ProductsInitialState() : super(null);
}

// final class ProductsLoaded extends RenderDataState {
//   Products? products;
//   ProductsLoaded(this.products) : super(null);
// }

final class ProductsLoaded extends RenderDataState {
  ProductsLoaded(super.data);
}

final class ProductAdded extends NonRenderState {}
