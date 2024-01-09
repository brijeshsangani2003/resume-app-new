import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:resume/common_widget/common_textfield.dart';
import 'package:resume/views/home_screen.dart';
import 'package:resume/views/resume_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Detail_Screen extends StatefulWidget {
  final data;
  const Detail_Screen({super.key, this.data});

  @override
  State<Detail_Screen> createState() => _Detail_ScreenState();
}

class _Detail_ScreenState extends State<Detail_Screen> {
  final formkey = GlobalKey<FormState>();
  List<dynamic> eduList = [{}];

  var resumeDetail = {};

  eduCard(eData, index) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Institute:',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  common_textformfield(
                    controller: institute,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Institute can not be empty';
                      }
                    },
                    onsave: (val) {
                      setState(() {
                        eduList[index]['institute'] = val.toString();
                      });
                    },
                    hintText: 'Institute',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Course:',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  common_textformfield(
                    controller: course,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Course can not be empty';
                      }
                    },
                    onsave: (val) {
                      setState(() {
                        eduList[index]['course'] = val.toString();
                      });
                    },
                    hintText: 'Course',
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: -10,
          right: -5,
          child: Visibility(
            visible: eduList.length > 1,
            child: IconButton(
              onPressed: () {
                eduList.removeAt(index);
                setState(() {});
              },
              icon: const Icon(
                Icons.close,
                color: Colors.red,
              ),
            ),
          ),
        ),
      ],
    );
  }

  final ImagePicker picker = ImagePicker();
  var selectedimage = '';

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController des = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController mno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController lang = TextEditingController();
  TextEditingController skill = TextEditingController();
  TextEditingController certi = TextEditingController();
  TextEditingController institute = TextEditingController();
  TextEditingController course = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("Data is :- ${widget.data["fname"]}");
    if (widget.data != null) {
      setState(() {
        fname.text = "${widget.data['fname']}";
        lname.text = "${widget.data['lname']}";
        des.text = "${widget.data['designation']}";
        desc.text = "${widget.data['description']}";
        mno.text = "${widget.data['mobile']}";
        email.text = "${widget.data['email']}";
        address.text = "${widget.data['address']}";
        lang.text = "${widget.data['language']}";
        skill.text = "${widget.data['skill']}";
        certi.text = "${widget.data['certification']}";
        institute.text = "${widget.data['edu_list'][0]['institute']}";
        course.text = "${widget.data['edu_list'][0]['course']}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Details',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    final XFile? image =
                        await picker.pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      setState(() {
                        selectedimage = image.path;
                        resumeDetail['profile_image'] = image.path;
                      });
                    }
                  },
                  child: Container(
                    height: 150,
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200, shape: BoxShape.circle),
                    child: ClipOval(
                      child: selectedimage.isEmpty
                          ? const Icon(
                              Icons.person,
                              size: 50,
                            )
                          : Image.file(File(selectedimage)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'First Name:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            common_textformfield(
                              controller: fname,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'First name can not be empty';
                                }
                              },
                              onsave: (val) {
                                setState(() {
                                  resumeDetail['fname'] = val;
                                  debugPrint("value => $val");
                                  debugPrint(
                                      "details => ${resumeDetail['fname']}");
                                });
                              },
                              hintText: 'First Name',
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Last Name:',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            common_textformfield(
                              controller: lname,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Last name can not be empty';
                                }
                              },
                              onsave: (val) {
                                setState(() {
                                  resumeDetail['lname'] = val;
                                });
                              },
                              hintText: 'Last Name',
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Designation:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      common_textformfield(
                        controller: des,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Designation can not be empty';
                          }
                        },
                        onsave: (val) {
                          setState(() {
                            resumeDetail['designation'] = val;
                          });
                        },
                        hintText: 'Designation',
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Description:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      common_textformfield(
                        controller: desc,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Descrption can not be empty';
                          }
                        },
                        onsave: (val) {
                          setState(() {
                            resumeDetail['description'] = val;
                          });
                        },
                        hintText: 'Description',
                        maxline: 5,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mobile No:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      common_textformfield(
                        controller: mno,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Mobile no can not be empty';
                          }
                        },
                        onsave: (val) {
                          setState(() {
                            resumeDetail['mobile'] = val;
                          });
                        },
                        hintText: 'Mobile No',
                        keyboardType: TextInputType.phone,
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Email:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      common_textformfield(
                        controller: email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Email can not be empty';
                          }
                        },
                        onsave: (val) {
                          setState(() {
                            resumeDetail['email'] = val;
                          });
                        },
                        hintText: 'Email',
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Address:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      common_textformfield(
                        controller: address,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Address can not be empty';
                          }
                        },
                        onsave: (val) {
                          setState(() {
                            resumeDetail['address'] = val;
                          });
                        },
                        hintText: 'Address',
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Langauge:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      common_textformfield(
                        controller: lang,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Language can not be empty';
                          }
                        },
                        onsave: (val) {
                          setState(() {
                            resumeDetail['language'] = val;
                          });
                        },
                        hintText: 'Language',
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Skills:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      common_textformfield(
                        controller: skill,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Skill can not be empty';
                          }
                        },
                        onsave: (val) {
                          setState(() {
                            resumeDetail['skill'] = val;
                          });
                        },
                        hintText: 'Skills',
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Certification:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      common_textformfield(
                        controller: certi,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Certification can not be empty';
                          }
                        },
                        onsave: (val) {
                          setState(() {
                            resumeDetail['certification'] = val;
                          });
                        },
                        hintText: 'Certification',
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Educational Details:',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 1.5),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              ListView.separated(
                                itemCount: eduList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return eduCard(eduList[index], index);
                                },
                                separatorBuilder:
                                    (BuildContext context, int sindex) {
                                  return const Divider(
                                    height: 30.0,
                                    color: Colors.grey,
                                  );
                                },
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  MaterialButton(
                                    onPressed: () {
                                      eduList.add({});
                                      setState(() {});
                                    },
                                    color: Colors.lightBlue,
                                    child: const Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Add New',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () async {
                        var formContext = formkey.currentState;
                        formContext!.save();

                        if (widget.data['id'] != null) {
                          await FirebaseFirestore.instance
                              .collection("resume")
                              .doc(widget.data['id'])
                              .update(jsonDecode(jsonEncode(resumeDetail)));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const home_screen()));
                        } else {
                          await FirebaseStorage.instance
                              .ref('/user-image.jpg')
                              .putFile(File(resumeDetail["profile_image"]));

                          final url = await FirebaseStorage.instance
                              .ref('/user-image.jpg')
                              .getDownloadURL();
                          resumeDetail['edu_list'] = eduList;
                          FirebaseFirestore.instance
                              .collection('resume')
                              .add(jsonDecode(jsonEncode(resumeDetail)))
                              .then((DocumentReference doc) {
                            FirebaseFirestore.instance
                                .collection('resume')
                                .doc(doc.id)
                                .update({"id": doc.id});
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    Resume_Screen(resData: resumeDetail),
                              ));
                        }
                      },
                      color: Colors.lightBlue,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Submit',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
