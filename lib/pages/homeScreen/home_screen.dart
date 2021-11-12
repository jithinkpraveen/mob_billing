import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mob_billing/model/user_modes.dart';
import 'package:mob_billing/pages/add_record/add_record_page.dart';
import 'package:mob_billing/pages/brandScreen/brand_screen.dart';
import 'package:mob_billing/pages/clientsScreen/clint_home_page.dart';
import 'package:mob_billing/pages/servicesScreen/services_home_page.dart';
import 'package:mob_billing/pages/statusScreen/status_services.dart';
// import 'package:mob_billing/pages/clients/users_home_page.dart';
// import 'package:mob_billing/pages/clients/clint_home_page.dart';
import 'package:mob_billing/services/activate_app.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<Users> users;
  bool isLoading = false;

  @override
  initState() {
    ActivateAppServices().checkKey(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "home"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "history"),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const AddRecordPage()),
              (route) => true);
        },
        backgroundColor: const Color(0xff39A2DB),
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xffFAF9F7),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFAF9F7),
        actions: [
          Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xff747474)),
                  shape: BoxShape.circle,
                  color: const Color(0xff4A80F0).withOpacity(0.1)),
              child: const Icon(
                Icons.notifications_outlined,
                color: Colors.black,
              )),
        ],
        title: const Text(
          "App Name",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
                  child: MaterialButton(
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      // _showSearch();
                    },
                    child: Container(
                      margin: const EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: const Color(0xffCFCFCF).withOpacity(0.3),
                      ),
                      height: 50,
                      child: Row(
                        children: const [
                          SizedBox(width: 10),
                          Icon(
                            Icons.search,
                            color: Color(0xffBABABA),
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Search ',
                            style: TextStyle(color: Color(0xffBABABA)),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(onPressed: () {}, icon: const Icon(Icons.tune))
            ],
          ),
          const SizedBox(height: 5),
          SizedBox(
            height: 70,
            child: ListView(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              scrollDirection: Axis.horizontal,
              children: [
                buildHomeIcon(
                  color: const Color(0xffF9B50F),
                  name: "Brands",
                  icon: "assets/brand.svg",
                  route: 1,
                ),
                buildHomeIcon(
                    color: const Color(0xff7974ED),
                    name: "Statuses",
                    icon: "assets/status.svg",
                    route: 2),
                buildHomeIcon(
                    color: const Color(0xff83D15E),
                    name: "Services",
                    icon: "assets/service.svg",
                    route: 3),
                buildHomeIcon(
                    color: const Color(0xffF48F32),
                    name: "Clients",
                    icon: "assets/clints.svg",
                    route: 4)
                // buildHomeIcon(Colors.red, "ser"),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, i) {
                return Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.withOpacity(0.4), blurRadius: 5)
                      ]),
                  margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  // height: 180,
                  // width: 320,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text("00123"),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.more_vert))
                        ],
                      ),
                      const Text(
                        " Service Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "  Customer Name",
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Color(0xff747688),
                            fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.place,
                            color: Color(0xffA5A7B5),
                          ),
                          const SizedBox(
                              width: 130,
                              child: Text(
                                  "Via Giuseppe Meda, 2, 20136 Milano MI",
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: Color(0xff747688),
                                      fontSize: 12))),
                          const Expanded(child: SizedBox()),
                          const Icon(
                            Icons.phone,
                            color: Colors.red,
                          ),
                          const Text(" 9961957211  ",
                              style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.red,
                                  fontSize: 14)),
                          Container(
                            height: 33,
                            width: 33,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xff48C95F)),
                            child: Center(
                              child: SvgPicture.asset("assets/whatsapp.svg"),
                            ),
                          )
                        ],
                      ),
                      const Divider(
                        color: Color(0xff39A2DB),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "service: 20-01-2021",
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    const Color(0xff333333).withOpacity(0.5)),
                          ),
                          Text(
                            "service: 20-01-2021",
                            style: TextStyle(
                                fontSize: 14,
                                color:
                                    const Color(0xff333333).withOpacity(0.5)),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  // Future getallUsers() async {
  //   setState(() => isLoading = true);
  //   users = await LocalDb.instance.getAllUsers();
  //   setState(() => isLoading = false);
  // }

  // Future addUser() async {
  //   setState(() => isLoading = true);
  //   var res = await LocalDb.instance.createUser(Users(
  //       name: "jithin",
  //       phone1: "phone1",
  //       address: "address",
  //       createdTime: DateTime.now()));
  //   setState(() => isLoading = false);
  //   return res;
  // }

  buildHomeIcon(
      {required Color color,
      required String name,
      required String icon,
      required int route}) {
    return MaterialButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => route == 1
                  ? const BrandHomePage()
                  : route == 2
                      ? const StatusHomePage()
                      : route == 3
                          ? const ServicesHomePage()
                          : const ClintHomePage()),
        );
      },
      child: Column(
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Center(
              child: SvgPicture.asset(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              color: Color(0xff515979),
            ),
          )
        ],
      ),
    );
  }
}
