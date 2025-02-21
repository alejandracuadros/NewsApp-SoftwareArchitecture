// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:intl/intl.dart';
// import 'package:kira_news/presentation/pages/category/category_page.dart';

// import '../../../core/models/news_channels_headlines_model.dart';
// import '../../../data/news/news_view_model.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// enum FilterList { bbcNews, afr }

// class _HomePageState extends State<HomePage> {
//   NewsViewModel newsViewModel = NewsViewModel();

//   FilterList? selectedMenu;

//   final format = DateFormat('MMMM dd, yyyy');

//   String channelName = 'bbc-news';
//   String title = "BBC News";

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.sizeOf(context).width * 1;
//     final height = MediaQuery.sizeOf(context).height * 1;

//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: ((context) => const CategoryPage())),
//             );
//           },
//           icon: const Icon(
//             Icons.menu_book,
//           ),
//         ),
//         title: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Center(
//               child: Image.asset(
//                 'assets/images/logo.png',
//                 fit: BoxFit.contain,
//                 height: 50,
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           PopupMenuButton<FilterList>(
//               initialValue: selectedMenu,
//               onSelected: (FilterList item) {
//                 if (FilterList.bbcNews.name == item.name) {
//                   channelName = 'bbc-news';
//                 }
//                 if (FilterList.afr.name == item.name) {
//                   channelName = 'australian-financial-review';
//                 }

//                 if (channelName == 'bbc-news') {
//                   title = "BBC News";
//                 }

//                 if (channelName == 'australian-financial-review') {
//                   title = "AFR News";
//                 }

//                 setState(() {
//                   selectedMenu = item;
//                 });
//               },
//               itemBuilder: (BuildContext context) =>
//                   <PopupMenuEntry<FilterList>>[
//                     const PopupMenuItem<FilterList>(
//                       value: FilterList.bbcNews,
//                       child: Text('BBC News'),
//                     ),
//                     const PopupMenuItem<FilterList>(
//                       value: FilterList.afr,
//                       child: Text('AFR'),
//                     ),
//                   ])
//         ],
//       ),
//       body: ListView(
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           Center(
//             child: Text(
//               title.toString(),
//               style: GoogleFonts.poppins(
//                 fontSize: 20,
//                 color: Colors.blue[800],
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           FutureBuilder<NewsChannelsHeadlinesModel>(
//               future: newsViewModel.fetchNewsChannelHeadlinesApi(channelName),
//               builder: (BuildContext context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(
//                       child: SpinKitCircle(
//                     size: 50,
//                     color: Colors.blue,
//                   ));
//                 } else {
//                   return ListView.builder(
//                       itemCount: snapshot.data!.articles!.length,
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemBuilder: (context, index) {
//                         DateTime dateTime = DateTime.parse(snapshot
//                             .data!.articles![index].publishedAt
//                             .toString());
//                         return SizedBox(
//                           child: Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               Container(
//                                 height: height * 0.4,
//                                 width: width * .9,
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: height * 0.02),
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(50),
//                                   child: CachedNetworkImage(
//                                     imageUrl: snapshot
//                                         .data!.articles![index].urlToImage
//                                         .toString(),
//                                     fit: BoxFit.cover,
//                                     placeholder: (context, url) => Container(
//                                       child: spinkit2,
//                                     ),
//                                     errorWidget: (context, url, error) =>
//                                         const Icon(Icons.error_outline,
//                                             color: Colors.red),
//                                   ),
//                                 ),
//                               ),
//                               Positioned(
//                                 bottom: 20,
//                                 child: Card(
//                                     elevation: 5,
//                                     shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(12),
//                                     ),
//                                     child: Container(
//                                       alignment: Alignment.bottomCenter,
//                                       padding: EdgeInsets.all(15),
//                                       height: height * .22,
//                                       child: Column(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         children: [
//                                           Container(
//                                             width: width * 0.7,
//                                             child: Text(
//                                               snapshot
//                                                   .data!.articles![index].title
//                                                   .toString(),
//                                               maxLines: 3,
//                                               overflow: TextOverflow.ellipsis,
//                                               style: GoogleFonts.poppins(
//                                                   fontSize: 17),
//                                             ),
//                                           ),
//                                           Spacer(),
//                                           Container(
//                                               alignment: Alignment.bottomRight,
//                                               child: Row(
//                                                   mainAxisAlignment:
//                                                       MainAxisAlignment.end,
//                                                   children: [
//                                                     Text(
//                                                       format.format(dateTime),
//                                                       maxLines: 2,
//                                                       overflow:
//                                                           TextOverflow.ellipsis,
//                                                       style:
//                                                           GoogleFonts.poppins(
//                                                               fontSize: 12),
//                                                     ),
//                                                   ]))
//                                         ],
//                                       ),
//                                     )),
//                               )
//                             ],
//                           ),
//                         );
//                       });
//                 }
//               }),
//           const SizedBox(
//             height: 20,
//           ),
//         ],
//       ),
//     );
//   }
// }

// const spinkit2 = SpinKitFadingCircle(
//   color: Colors.amber,
//   size: 50,
// );
