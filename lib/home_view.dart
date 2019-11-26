import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String _githubPhotoUrl =
      "https://avatars0.githubusercontent.com/u/15869224?s=400&u=f5563c857c9af1ba6cd2f61f4905abc62ba6037a&v=4";

  String _randomImage = "https://picsum.photos/200";
  String _dummyTweet =
      "Bu şimdinin genç akademisyeni, eski bir öğrencimden geldi. Benle çalışırken öbür asistanlardan daha çok yorulduğundan, intikam için bu nefis şeyleri yedirip kilo aldırmayı mı seçti ki diye düşündüm önce ama notundaki içten minnet ifadeleri “her şeye rağmen iyi şu meslek” dedirtti";

  int defaultTabLength = 4;
  ScrollController scrollController;
  bool isHeaderClose = false;
  double lastOffset = 0;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset <= 0) {
        isHeaderClose = false;
      } else if (scrollController.offset >=
          scrollController.position.maxScrollExtent) {
        isHeaderClose = true;
      } else {
        isHeaderClose = scrollController.offset > lastOffset ? true : false;
      }

      setState(() {
        lastOffset = scrollController.offset;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _fabButtons,
      body: SafeArea(
        child: DefaultTabController(
          length: defaultTabLength,
          child: Column(
            children: <Widget>[
              _containerAppBar,
              _tabbarItems,
              _expandedListView
            ],
          ),
        ),
      ),
    );
  }

  Widget get _fabButtons => FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.adb),
      );

  Widget get _containerAppBar => AnimatedContainer(
        duration: Duration(milliseconds: 200),
        height: isHeaderClose ? 0 : 50,
        child: _appBar,
      );

  Widget get _appBar => AppBar(
        elevation: 0,
        centerTitle: false,
        title: _appBarItems,
      );

  Widget get _appBarItems => Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        children: <Widget>[
          CircleAvatar(backgroundImage: NetworkImage(_githubPhotoUrl)),
          Text(
            "Home",
            style: titleTextStyle,
          )
        ],
      );

  Widget get _tabbarItems => TabBar(
        tabs: <Widget>[
          Tab(icon: Icon(Icons.dashboard)),
          Tab(icon: Icon(Icons.radio)),
          Tab(icon: Icon(Icons.satellite)),
          Tab(icon: Icon(Icons.verified_user)),
        ],
      );

  Widget get _expandedListView => Expanded(
        child: _listView,
      );

  Widget get _listView => ListView.builder(
        itemCount: 10,
        controller: scrollController,
        itemBuilder: (context, index) {
          return _listViewCard;
        },
      );

  Widget get _listViewCard => Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(_randomImage),
          ),
          title: Wrap(
            runSpacing: 5,
            children: <Widget>[
              _listCardTitle("Hello"),
              Text(_dummyTweet),
              _placeHolderField,
              _footerButtonRow
            ],
          ),
        ),
      );

  Widget _listCardTitle(String text) => Text(
        text,
        style: titleTextStyle,
      );

  Widget get _placeHolderField => Container(
        height: 100,
        child: Placeholder(),
      );

  Widget get _footerButtonRow => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton,
          _iconLabelButton
        ],
      );

  Widget _iconLabel(String text) => Wrap(
        spacing: 5,
        children: <Widget>[
          Icon(
            Icons.comment,
            color: CupertinoColors.inactiveGray,
          ),
          Text(text)
        ],
      );

  Widget get _iconLabelButton => InkWell(
        child: _iconLabel("1"),
        onTap: () {},
      );
}

final titleTextStyle = TextStyle(
    letterSpacing: 1,
    fontSize: 20,
    fontWeight: FontWeight.w800,
    color: Colors.black);
