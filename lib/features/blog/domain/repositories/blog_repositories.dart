import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:new_bloc_clean_app/core/error/failure.dart';
import 'package:new_bloc_clean_app/features/blog/domain/blog_entitie/blog_entitie.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntitie>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  });
}
