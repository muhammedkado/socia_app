import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia_app/layout/cubit/cubit.dart';
import 'package:socia_app/layout/cubit/state.dart';
import 'package:socia_app/sherd/components/components.dart';
import 'package:socia_app/sherd/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  NewPostScreen({Key? key}) : super(key: key);
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      builder: (context, state) {
        var cubit = SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            title: const Text(
              'New Post',
            ),
            actions: [
              defaultTextButton(
                onPressed: () {
                  var time=DateTime.now();
                  if (cubit.postImage == null) {
                    cubit.createPost(
                        time: time.toString(),
                        text: textController.text);
                  } else {
                    cubit.uploadPostImage(
                        time: time.toString(),
                        text: textController.text);
                  }
                },
                lable: Text(
                  'Post',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Colors.green, fontWeight: FontWeight.normal),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is CreatePostLoadingState)
                  const LinearProgressIndicator(),
                if (state is CreatePostLoadingState)
                  const SizedBox(
                    height: 15,
                  ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                        '${cubit.userModel!.image}',
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Text(
                      '${cubit.userModel!.name}',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                        hintText:
                            'what is on your mind, ${cubit.userModel!.name} ...',
                        hintStyle: const TextStyle(fontSize: 15),
                        border: InputBorder.none),
                  ),
                ),
                if(cubit.postImage != null)
                  Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:FileImage(cubit.postImage!)
                                ,
                                fit: BoxFit.cover),
                            borderRadius:BorderRadius.circular(4)
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            cubit.removePostImage();
                          },
                          icon: const CircleAvatar(
                            radius: 20,
                            child: Icon(
                              Icons.cancel_outlined,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
                const SizedBox(
                  height: 5 ,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: () {
                            cubit.getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(IconBroken.Image),
                              SizedBox(
                                width: 10,
                              ),
                              Text('Add Image'),
                            ],
                          )),
                    ),
                    Expanded(
                      child: TextButton(
                          onPressed: () {}, child: const Text('# heshdak')),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
