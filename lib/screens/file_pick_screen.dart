import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musiqa_uia1/cubit/file_cubit.dart';
import 'package:musiqa_uia1/cubit/file_state.dart';
import 'package:musiqa_uia1/widgets/custom_audio_widget.dart';

class FilePickScreen extends StatefulWidget {
  const FilePickScreen({super.key});

  @override
  State<FilePickScreen> createState() => _FilePickScreenState();
}

class _FilePickScreenState extends State<FilePickScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: BlocBuilder<FileCubit, FileState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: 30),
                SafeArea(child: app()),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 320,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/image.png"),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (state is FileSuccessState) {
                      return CustomAudioWidget(
                        filePahth: state.audio.path,
                        musicName: state.musicName,
                        animationController: _animationController,
                      );
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.chevron_left, color: Color(0xffffffff)),
        Spacer(),
        Column(
          children: [
            Text(
              "Сейчас играет",
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: Color(0xffffffff),
              ),
            ),
            Text(
              "Моя волна",
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xffffffff),
              ),
            ),
          ],
        ),
        Spacer(),
        InkWell(
          onTap: () {
            context.read<FileCubit>().pickFile();
          },
          child: Image.asset(
            "assets/images/notbook.png",
            height: 25,
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(width: 15),
        Icon(Icons.menu_outlined, color: Color(0xffffffff)),
      ],
    );
  }
}
