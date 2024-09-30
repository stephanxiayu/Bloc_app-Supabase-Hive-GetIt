import 'package:fpdart/fpdart.dart';
import 'package:new_bloc_clean_app/core/error/failure.dart';
import 'package:new_bloc_clean_app/core/usecase/usecase.dart';
import 'package:new_bloc_clean_app/features/blog/domain/blog_entitie/blog_entitie.dart';
import 'package:new_bloc_clean_app/features/blog/domain/repositories/blog_repositories.dart';

class GetUploadedBlogs implements Usecase<List<BlogEntitie>, NoParams> {
  final BlogRepository blogRepository;

  GetUploadedBlogs(this.blogRepository);

  @override
  Future<Either<Failure, List<BlogEntitie>>> call(NoParams params) async {
    return await blogRepository.getUploadedBlogs();
  }
}
