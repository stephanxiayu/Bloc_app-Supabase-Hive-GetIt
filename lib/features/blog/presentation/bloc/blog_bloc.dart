import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bloc_clean_app/core/usecase/usecase.dart';
import 'package:new_bloc_clean_app/features/blog/domain/blog_entitie/blog_entitie.dart';
import 'package:new_bloc_clean_app/features/blog/domain/usecases/get_uploaded_blogs.dart';
import 'package:new_bloc_clean_app/features/blog/domain/usecases/upload_blog.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final UploadBlog uploadBlog;
  final GetUploadedBlogs getBlogs;

  BlogBloc(this.uploadBlog, this.getBlogs) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUpload>(_onBlogUpload);
    on<BlogGetAllUploadedBlogs>(_onGetAllUploadedBlogs);
  }

  void _onBlogUpload(BlogUpload event, Emitter<BlogState> emit) async {
    final result = await uploadBlog(UploadBlogParams(
        posterId: event.posterId,
        title: event.title,
        content: event.content,
        image: event.image,
        topics: event.topics));
    result.fold(
        (l) => emit(BlogFailure(l.message)), (r) => emit(BlogSuccess()));
  }

  void _onGetAllUploadedBlogs(
      BlogGetAllUploadedBlogs event, Emitter<BlogState> emit) async {
    final result = await getBlogs(NoParams());
    result.fold((l) => emit(BlogFailure(l.message)),
        (r) => emit(BlogDisplaySuccess(r)));
  }
}
