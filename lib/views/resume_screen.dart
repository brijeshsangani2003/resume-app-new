import 'dart:io';

import 'package:flutter/material.dart';
import 'package:resume/views/home_screen.dart';

class Resume_Screen extends StatefulWidget {
  const Resume_Screen({super.key, this.resData});
  final resData;

  @override
  State<Resume_Screen> createState() => _Resume_ScreenState();
}

class _Resume_ScreenState extends State<Resume_Screen> {
  dynamic rData = {};

  @override
  void initState() {
    setState(() {
      rData = widget.resData;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                height: 180,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.teal),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: 140,
                        width: 140,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.white, width: 3)),
                        child: Image.file(
                          File(rData['profile_image']),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (rData['fname'] ?? "").toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                        Text(
                          rData['lname'] ?? "".toString(),
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 23),
                        ),
                        Text(
                          rData['designation'] ?? "".toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'PROFILE',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          Text(
                            rData['description'] ?? "".toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          const Text(
                            'CONTACT ME',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.phone),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                rData['mobile'] ?? "".toString(),
                                textScaleFactor: 1,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.email_outlined),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  rData['email'] ?? "".toString(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on_sharp),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Text(
                                  rData['address'] ?? "".toString(),
                                  textScaleFactor: 1,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 60,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.arrow_circle_right_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'EDUCATION',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: rData['edu_list'].length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text((rData['edu_list'][index]['course'] ??
                                            "")
                                        .toString()),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text((rData['edu_list'][index]
                                                ['institute'] ??
                                            "")
                                        .toString()),
                                  ],
                                );
                              }),
                          const SizedBox(
                            height: 40,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.arrow_circle_right_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'LANGUAGE',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            rData['language'] ?? "".toString(),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.arrow_circle_right_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'SKILLS',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            rData['skill'] ?? "".toString(),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Row(
                            children: [
                              Icon(Icons.arrow_circle_right_rounded),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                'CERTIFICATION',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            rData['certification'] ?? "".toString(),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: MaterialButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const home_screen()),
              (route) => false);
        },
        height: 50,
        color: Colors.teal,
        child: const Text(
          "Go to Home",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
