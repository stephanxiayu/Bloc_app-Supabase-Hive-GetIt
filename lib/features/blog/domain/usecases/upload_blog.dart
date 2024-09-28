import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:new_bloc_clean_app/core/error/failure.dart';
import 'package:new_bloc_clean_app/core/usecase/usecase.dart';
import 'package:new_bloc_clean_app/features/blog/domain/blog_entitie/blog_entitie.dart';
import 'package:new_bloc_clean_app/features/blog/domain/repositories/blog_repositories.dart';

class UploadBlog implements Usecase<BlogEntitie, UploadBlogParams> {
  final BlogRepository blogRepository;

  UploadBlog(this.blogRepository);

  @override
  Future<Either<Failure, BlogEntitie>> call(UploadBlogParams params) async {
    return blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        posterId: params.posterId,
        topics: params.topics);
  }
}

class UploadBlogParams {
  final String posterId;
  final String title;
  final String content;
  final File image;
  final List<String> topics;

  UploadBlogParams(
      {required this.posterId,
      required this.title,
      required this.content,
      required this.image,
      required this.topics});
}
