import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:readxpress2/app_export.dart';
import 'package:readxpress2/screens/home.dart';
import 'package:readxpress2/screens/menu.dart';
import 'package:readxpress2/screens/reader.dart';
import 'package:readxpress2/widgets/custom_appbar.dart';
import 'package:readxpress2/widgets/SmallBookCard.dart';

class LibraryScreen extends StatefulWidget {
  @override
  _LibraryScreenState createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  OverlayEntry? _overlayEntry;
  List<SmallBookCardWidget> bookList = []; 
  List<SmallBookCardWidget> filteredBooks = [];
  TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> bookcardInfoList = [
    {
      'title': "Jane Eyre",
      'author': "Charlotte Bronte",
      'imagePath': ImageConstant.imgMedia88x68,
    },
    {
      'title': "Wuthering Heights",
      'author': "Emily Bronte",
      'imagePath': ImageConstant.imgMedia1,
    },
    {
      'title': "Rebecca",
      'author': "Daphne du Maurier",
      'imagePath': ImageConstant.imgMedia2,
    },
    {
      'title': "Dune",
      'author': "Frank Herbert",
      'imagePath': ImageConstant.imgMedia3,
    },
    {
      'title': "1984",
      'author': "G. Orwell",
      'imagePath': ImageConstant.imgMedia4,
    },
    {
      'title': "Emma",
      'author': "Jane Austen",
      'imagePath': ImageConstant.imgMedia5,
    },
    {
      'title': "Neverwhere",
      'author': "Neil Gaiman",
      'imagePath': ImageConstant.imgMedia6,
    },
    {
      'title': "Animal Farm",
      'author': "G. Orwell",
      'imagePath': ImageConstant.imgMedia7,
    },
    {
      'title': "Goldfinger",
      'author': "Ian Fleming",
      'imagePath': ImageConstant.imgMedia8,
    },
    {
      'title': "It",
      'author': "Stephen King",
      'imagePath': ImageConstant.imgMedia9,
    },
    {
    'title': "Tale of two cities",
     'author': "Charles Dickens",
      'imagePath': ImageConstant.imgMedia,
    }
  ];

  @override
  void initState() {
    super.initState();
    // Convert bookcardInfoList to a list of BookCardWidget
    bookList = bookcardInfoList
        .map((info) => SmallBookCardWidget(
              title: info['title'],
              author: info['author'],
              imagePath: info['imagePath'],
              progress: 0.15 * bookcardInfoList.indexOf(info),
            ))
        .toList();
    filteredBooks = List.from(bookList);
    _searchController.addListener(() {
      String searchText = _searchController.text;
      setState(() {
        // Filter the book cards based on the entered text
        filteredBooks = bookList
            .where((book) =>
                book.title.toLowerCase().contains(searchText.toLowerCase()) ||
                book.author.toLowerCase().contains(searchText.toLowerCase()))
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: double.maxFinite,
          child: Container(
            decoration: AppDecoration.secondaryBackground,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildAppBar(context),
                SizedBox(height: 40.v),
                Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomImageView(
                              imagePath: ImageConstant.imgLibraryBooksAmberA700,
                              height: 32.adaptSize,
                              width: 32.adaptSize,
                              margin: EdgeInsets.only(
                                top: 6.v,
                                bottom: 14.v,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 8.h),
                              child: Text(
                                "Library",
                                style: theme.textTheme.headlineMedium,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.v),
                _buildSearchWidget(),
                SizedBox(height: 20.v),
                Expanded(
                  child: _buildScrollableContainer(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

Widget _buildSearchWidget() {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 20.h),
    child: CustomFloatingTextField(
      hintText: 'Title or Author',
      hintStyle: CustomTextStyles.bodyLargeWhite9000,
      textStyle: CustomTextStyles.bodyLargeWhite9000,
      fillColor: appTheme.amberA700.withOpacity(0.8),
      filled: true,
      borderDecoration: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30.0), 
        borderSide: BorderSide.none,
      ),
      
      contentPadding: EdgeInsets.symmetric(vertical: 14.0, horizontal: 15.0),
      controller: _searchController,
      prefix: Padding(
        padding: EdgeInsets.all(15.0),
        child: CustomImageView(
          imagePath: ImageConstant.imgSearchWhiteA700,
          height: 20.adaptSize,
          width: 20.adaptSize,
          color: Colors.white,
        ),
      ),
    ),
  );
}


   PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      centerTitle: true,
      title: Column(
        children: [
          Row(
            children: [
              AppbarLeadingImage(
                imagePath: ImageConstant.imgMegaphone,
                margin: EdgeInsets.only(
                  top: 9.v,
                  bottom: 11.v,
                ),
                onTap: () {
          onTapMenuButton(context);
        },
              ),
              Container(
                width: 174.h,
                margin: EdgeInsets.only(
                  left: 32.h,
                  top: 8.v,
                  bottom: 2.v,
                ),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "Read",
                        style: ThemeHelper().themeData().textTheme.headlineMedium,
                      ),
                      TextSpan(
                        text: "X",
                        style: CustomTextStyles.headlineMediumAmberA700,
                      ),
                      TextSpan(
                        text: "press",
                        style: ThemeHelper().themeData().textTheme.headlineMedium,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              AppbarLeadingImage(
                imagePath: ImageConstant.img38745835070228,
                margin: EdgeInsets.only(left: 29.h),
                 onTap: () {
                  HapticFeedback.vibrate();
          Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePageScreen()),
      );
        },
              ),
            ],
          ),
          SizedBox(
            width: double.maxFinite,
            child: Divider(),
          ),
        ],
      ),
      styleType: Style.bgFill,
    );
  }

  void onTapMenuButton(BuildContext context) {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: GestureDetector(
          onTap: () {
            // Dismiss the overlay when tapped outside the menu
            _overlayEntry?.remove();
          },
          child: Container(
            color: Colors.black.withOpacity(0.1),
            child: Center(
              child: Container(
                width: 800.h,
                height: 800.v,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.transparent,
                ),
                child: Align(
        alignment: Alignment.topLeft,
        child: MenuScreen(),
      ),
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)?.insert(_overlayEntry!);
  }

   

Widget _buildScrollableContainer() {
  return Align(
    alignment: Alignment.topLeft,
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < filteredBooks.length; i += 2)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                GestureDetector(
                onTap: () {
                  
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReaderScreen(title : filteredBooks[i].title)));
                },
                child:
                    filteredBooks[i],
                    ),
                    if (i + 1 < filteredBooks.length) SizedBox(width: 10.0),
                    if (i + 1 < filteredBooks.length) GestureDetector(
                onTap: () {
                  
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ReaderScreen(title :filteredBooks[i+1].title)));
                },
                child:filteredBooks[i + 1],
                    ),
                  ],
                ),
                SizedBox(height: 30.0), 
              ],
            ),
        ],
      ),
    ),
  );
}
}