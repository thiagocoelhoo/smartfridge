import 'package:smartfridge/utils/duration_time.dart';
import './product.dart';

class Recipe {
  final String name;
  final String urlImage;
  final List<Product> ingredients;
  final List<String> stepByStep;
  final DurationTime duration;

  Recipe(this.name, this.urlImage, this.ingredients, this.stepByStep, this.duration);
}