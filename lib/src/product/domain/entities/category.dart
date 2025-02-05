import 'package:equatable/equatable.dart';

class ProductCategory extends Equatable {
  const ProductCategory({required this.id, this.name, this.color, this.image});

  //empty constructor
  const ProductCategory.empty() : this(id: 'Test String');
  const ProductCategory.all() : this(id: '' , name: 'All');

  final String id;
  final String? name;
  final String? color;
  final String? image;

  @override
  List<Object?> get props => [id, name, color, image];
}
