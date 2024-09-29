import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_bloc_clean_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:new_bloc_clean_app/core/common/cubits/app_user/app_user_state.dart';
import 'package:new_bloc_clean_app/core/common/widgets/loader.dart';
import 'package:new_bloc_clean_app/core/theme/app_pallete.dart';
import 'package:new_bloc_clean_app/core/utils/pick_image.dart';
import 'package:new_bloc_clean_app/core/utils/show_snackbar.dart';
import 'package:new_bloc_clean_app/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:new_bloc_clean_app/features/blog/presentation/pages/blog_page.dart';
import 'package:new_bloc_clean_app/features/blog/presentation/widgets/blog_editor.dart';

class AddNewBlocPage extends StatefulWidget {
  static route() =>
      MaterialPageRoute(builder: (context) => const AddNewBlocPage());
  const AddNewBlocPage({super.key});

  @override
  State<AddNewBlocPage> createState() => _AddNewBlocPageState();
}

class _AddNewBlocPageState extends State<AddNewBlocPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedtopics = [];
  final formKey = GlobalKey<FormState>();
  File? image;

  void selectImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  void uploadBlog() {
    if (formKey.currentState!.validate() &&
        selectedtopics.isNotEmpty &&
        image != null) {
      final posterId = (context.read<AppUserCubit>().state as AppUserLoggedIn)
          .userEntities
          .id;
      context.read<BlogBloc>().add(
            BlogUpload(
                posterId: posterId,
                title: titleController.text.trim(),
                content: contentController.text.trim(),
                image: image!,
                topics: selectedtopics),
          );
    }
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                uploadBlog();
              },
              icon: const Icon(Icons.done_rounded))
        ],
      ),
      body: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is BlogFailure) {
            showSnackBar(context, state.error);
          } else if (state is BlogSuccess) {
            Navigator.pushAndRemoveUntil(
                context, BlogPage.route(), (route) => false);
          }
        },
        builder: (context, state) {
          if (state is BlogLoading) {
            return const Loader();
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    image != null
                        ? GestureDetector(
                            onTap: selectImage,
                            child: SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.file(
                                    image!,
                                    fit: BoxFit.cover,
                                  ),
                                )),
                          )
                        : GestureDetector(
                            onTap: () {
                              selectImage();
                            },
                            child: DottedBorder(
                              radius: const Radius.circular(10),
                              borderType: BorderType.RRect,
                              dashPattern: const [10, 4],
                              strokeCap: StrokeCap.round,
                              color: AppPallete.borderColor,
                              child: const SizedBox(
                                height: 150,
                                width: double.infinity,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.folder_open_outlined,
                                      size: 40,
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Bild auswählen",
                                      style: TextStyle(fontSize: 15),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          "Technolagy",
                          "Business",
                          "Coding",
                          "Entertainment"
                        ]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedtopics.contains(e)) {
                                      selectedtopics.remove(e);
                                    } else {
                                      selectedtopics.add(e);
                                    }

                                    setState(() {});
                                  },
                                  child: Chip(
                                    color: selectedtopics.contains(e)
                                        ? const MaterialStatePropertyAll(
                                            AppPallete.gradient1)
                                        : null,
                                    side: const BorderSide(
                                        color: AppPallete.borderColor),
                                    label: selectedtopics.contains(e)
                                        ? Text(
                                            e,
                                            style: const TextStyle(
                                                color: Colors.black),
                                          )
                                        : Text(e),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    BlogEditor(
                      controller: titleController,
                      hintText: "Blog Title",
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    BlogEditor(
                      controller: contentController,
                      hintText: "Blog Content",
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
