import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:new_bloc_clean_app/core/error/exceptions.dart';
import 'package:new_bloc_clean_app/core/error/failure.dart';
import 'package:new_bloc_clean_app/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:new_bloc_clean_app/features/blog/data/models/blog_model.dart';
import 'package:new_bloc_clean_app/features/blog/domain/blog_entitie/blog_entitie.dart';
import 'package:new_bloc_clean_app/features/blog/domain/repositories/blog_repositories.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;

  BlogRepositoryImpl(this.blogRemoteDataSource);

  @override
  Future<Either<Failure, BlogEntitie>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String posterId,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          posterId: posterId,
          title: title,
          content: content,
          imageUrl: "",
          topics: topics,
          updatedAt: DateTime.now());

      final imageUrl = await blogRemoteDataSource.uploadBlogImage(
          image: image, blogModel: blogModel);
      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadedBlog = await blogRemoteDataSource.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
