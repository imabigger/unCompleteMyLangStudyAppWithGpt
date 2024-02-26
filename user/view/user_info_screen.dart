import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:study_language_ai_flutter_project/common/component/drop_button.dart';
import 'package:study_language_ai_flutter_project/common/const/consts.dart';
import 'package:study_language_ai_flutter_project/common/const/enums.dart';
import 'package:study_language_ai_flutter_project/common/utill/utils.dart';
import 'package:study_language_ai_flutter_project/user/auth/auth.dart';
import 'package:study_language_ai_flutter_project/user/model/user_collection_model.dart';
import 'package:study_language_ai_flutter_project/user/provider/user_collection_provider.dart';
import 'package:study_language_ai_flutter_project/user/view/login_page.dart';

class UserInfoScreen extends ConsumerStatefulWidget {
  const UserInfoScreen({super.key});

  @override
  ConsumerState<UserInfoScreen> createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends ConsumerState<UserInfoScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  final box = Hive.box<String>('lowSecurityRequired');
  Lang? myBaseLang;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBaseLang =
        Util.changeStringToLang(box.get(base_lang_key) ?? Lang.English.name);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().userChanges,
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (!snapshot.hasData) {
          //Login
          return const LoginPage();
        }

        User user = snapshot.data!;
        if (user.displayName == '' || user.displayName == null) {
          user.updateDisplayName('Undefined Name');
        }

        final UserCollectionModel? userCollection = ref.watch(userCollectionProvider);
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: const Text(
              '회원 정보',
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              OutlinedButton.icon(
                  onPressed: () {
                    Auth().signOut();
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('log out'),
                  style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      shape: const LinearBorder(start: LinearBorderEdge())))
            ],
          ),
          body: Stack(fit: StackFit.expand, children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: user.photoURL != null
                                            ? const NetworkImage('')
                                            : Image.asset(
                                                    'asset/background/langimg.jpg')
                                                .image,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: 51,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          user.displayName ?? 'Undefined',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(user.email!),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.withOpacity(0.4),
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: coin_padding),
                                      Icon(
                                        Icons.cookie,
                                        size: 20.0,
                                        color: Colors.amber.shade200,
                                      ),
                                      const SizedBox(width: 16.0),
                                      Text(userCollection?.cookie.toString() ?? '0'),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                width: 1,
                                color: Colors.white,
                              ),
                              Expanded(
                                child: Container(
                                  height: 25,
                                  decoration: BoxDecoration(
                                    color: Colors.blueGrey.withOpacity(0.4),
                                    borderRadius: const BorderRadius.only(
                                      bottomRight: Radius.circular(10.0),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(width: coin_padding),
                                      const Icon(
                                        Icons.copyright_outlined,
                                        size: 20.0,
                                        color: Colors.amberAccent,
                                      ),
                                      const SizedBox(width: 16.0),
                                      Text(userCollection?.cash.toString() ?? '0'),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 32.0),
                    ListTile(
                      leading: const Icon(Icons.manage_accounts),
                      title: const Text('계정 정보 관리'),
                      onTap: () {
                        context.go('/account_detail');
                      },
                    ),
                    const Divider(thickness: 0.5),
                    ListTile(
                      leading: const Icon(Icons.speaker_outlined),
                      title: const Text('tts Voice 선택'),
                      onTap: () {
                        context.go('/sound_selection');
                      },
                    ),
                    const Divider(thickness: 0.5),
                    ListTile(
                      leading: const Icon(Icons.upload_file_outlined),
                      title: const Text('Upload 파일 관리'),
                      onTap: () {},
                    ),
                    const Divider(),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButtonHideUnderline(
                  child: DropDownButtonSearchCustom<Lang>(
                    value: myBaseLang,
                    hintText: 'Base Language 선택',
                    onChanged: (Lang? lang) {
                      box.put(base_lang_key, lang!.name);
                      setState(() {
                        myBaseLang = lang;
                      });
                    },
                    items: Lang.values,
                    valueToString: (Lang val) {
                      return val.name;
                    },
                    textEditingController: _textEditingController,
                    buttonSize: 300,
                    dropSize: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            ) // button
          ]),
        );
      },
    );
  }
}
