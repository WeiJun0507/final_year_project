import 'package:carousel_slider/carousel_slider.dart';
import 'package:final_year_project/customWidget/homeNavButton.dart';
import 'package:final_year_project/model/sliderDetail.dart';
import 'package:final_year_project/screens/LoyaltyProgram/admin_loyalty_dashboard.dart';
import 'package:final_year_project/screens/LoyaltyProgram/customer_loyalty_dashboard.dart';
import 'package:final_year_project/screens/Menu/menu_dashboard.dart';
import 'package:final_year_project/screens/Profile/profile.dart';
import 'package:final_year_project/screens/Reservation/reservation_admin/reservation_admin_dashboard.dart';
import 'package:final_year_project/screens/Reservation/reservation_dashboard.dart';
import 'package:final_year_project/screens/dashboard/sliderDetailPage.dart';
import 'package:final_year_project/services/Database.dart';
import 'package:flutter/material.dart';


class HomeApp extends StatefulWidget {
  final List<String> imgList = [
    'assets/image/undraw_Hamburger_8ge6.png',
    'assets/image/undraw_ice_cream_s2rh.png',
    'assets/image/undraw_special_event_4aj8.png',
  ];

  @override
  _HomeAppState createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  int _current = 0;

  final _dbService = DatabaseService();
  bool admin = false;

  @override
  void initState() {
    super.initState();
    updateAdminStatus();
  }

  void updateAdminStatus() {
    final data = _dbService.getUserInfo();
    setState(() {
      if (data != null) {
        data.forEach((element) {
          setState(() {
            admin = element.data()['admin'];
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    indexMethod(String index) {
      switch (index) {
        case '0':
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SliderDetailPage(
                      item: SliderDetail(
                          id: '1',
                          title: 'Promotion',
                          description: 'Using PromoCode: "Discount" to get a voucher to discount 30%',
                          image: 'assets/image/undraw_Hamburger_8ge6.png'))),
            );
          }
          break;
        case '1':
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SliderDetailPage(
                      item: SliderDetail(
                          id: '2',
                          title: 'New Menu',
                          description: 'Roti Canai',
                          image: 'assets/image/undraw_ice_cream_s2rh.png'))),
            );
          }
          break;
        case '2':
          {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SliderDetailPage(
                      item: SliderDetail(
                          id: '3',
                          title: 'Discount',
                          description: 'Voucher for Buy 1 Free 1',
                          image:
                              'assets/image/undraw_special_event_4aj8.png'))),
            );
          }
          break;
        default:
          break;
      }
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Welcome to EasyBook!',
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          SizedBox(height: 10.0,),
          CarouselSlider(
            items: widget.imgList
                .map(
                  (item) => Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                      child: Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              indexMethod(
                                  widget.imgList.indexOf(item).toString());
                            },
                            child: Image.asset(
                              item,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Positioned(child: Text(
                              widget.imgList.indexOf(item) == 0 ? 'Promotion'
                                  : widget.imgList.indexOf(item) == 1 ? 'New Menu'
                                  : 'Discount', style: TextStyle(
                            fontSize: 20.0,
                          )),)

                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
            options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2,
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.imgList.map((item) {
              int index = widget.imgList.indexOf(item);
              return Container(
                width: 10,
                height: 10,
                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == index
                        ? Color.fromRGBO(0, 0, 0, 0.9)
                        : Color.fromRGBO(0, 0, 0, 0.3)),
              );
            }).toList(),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomePageButton(
                imageUrl: 'assets/image/table-with-food-cartoon-table.jpg',
                title: 'Reservation',
                customSize: 20,
                pColor: Colors.lightBlueAccent[700],
                navigation: () {
                  admin ?
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationAdminDashboard()))
                  : Navigator.push(context, MaterialPageRoute(builder: (context) => ReservationDashboard()));
                },
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              HomePageButton(
                imageUrl: 'assets/image/table-with-food-cartoon-table.jpg',
                title: 'Menu',
                customSize: 20,
                pColor: Colors.green[800],
                navigation: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MenuDashboard(admin)));
                },
              ),
            ],
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.05),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              HomePageButton(
                imageUrl: 'assets/image/table-with-food-cartoon-table.jpg',
                title: 'Loyalty Promotion',
                customSize: 20,
                pColor: Colors.redAccent[700],
                navigation: () {
                  admin ?
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AdminLoyaltyDashboard()))
                      :
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CustomerLoyaltyDashboard()));

                  },
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              HomePageButton(
                  imageUrl: 'assets/image/table-with-food-cartoon-table.jpg',
                  title: 'Profile',
                  customSize: 20,
                  pColor: Colors.yellow[900],
                navigation: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
