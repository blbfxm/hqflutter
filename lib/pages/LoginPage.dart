import 'dart:async';
import '../common/Constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _loginPage();
}

class _loginPage extends State<LoginPage> {
  String _verifyStr = '获取验证码';
  var theme;
  int _seconds = 0;
  Timer _timer;
  String _verifyCode = "";
  String _phoneNum = "";


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _cancelTimer();
  }

  _startTimer() {
    _seconds = 10;
    _timer = new Timer.periodic(new Duration(seconds: 1), (_timer) {
      if (_seconds == 0) {
        _cancelTimer();
        return;
      }
      _seconds--;
      _verifyStr = "$_seconds";
      setState(() {});
      if (_seconds == 0) {
        _verifyStr = "重新发送";
      }
    });
  }

  _cancelTimer() {
    _timer?.cancel();
  }

  Widget _buildBody() {
    return new ListView(
      children: <Widget>[
        _buildCostomBar(),
        _bulidLogoImg(),
        _buildPhoneEdit(),
        _buildVerifyCodeEdit(),
        _buildRegist()
      ],
    );
  }

  Widget _buildCostomBar() {
    return new Padding(
      padding: const EdgeInsets.all(10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          new InkWell(
            child: new Text(
              "密码登录",
              style: TextStyle(color: Constants.color_blue, fontSize: 20.0),
            ),
            onTap: () {},
          ),
          new InkWell(
            child: new Icon(
              Icons.clear,
              color: Constants.color_blue,
            ),
            onTap: (){
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _bulidLogoImg() {
    return new Center(
        child: new Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Expanded(
          child: new Image.asset("images/logo_name2.png"),
          flex: 1,
        )
      ],
    ));
  }

  Widget _buildPhoneEdit() {
    return new Padding(
      padding:   const EdgeInsets.only(left: 50.0, right: 50.0,top:10.0),
      child: new TextField(
        onChanged: (str) {
          _phoneNum = str;
        },
        decoration: new InputDecoration(
          hintText: "请输入手机号",        
        ),
        keyboardType: TextInputType.phone,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
      ),
    );
  }

  Widget _buildVerifyCodeEdit() {
    Widget _verifyCodeEdit = new TextField(
      decoration: const InputDecoration(
        hintText: "请输入短信验证码",        
      ),
      keyboardType: TextInputType.number,     
      onChanged: (str) {
        _verifyCode = str;
        setState(() {});
      },
    );

    Widget _buildVerifyBun = new InkWell(
      onTap: () {
        if (_seconds == 0) {
          setState(() {
            _startTimer();
          });
        }
      },
      child: new Container(
        alignment: Alignment.center,
        width: 100.0,
        height: 30.0,
        decoration: new BoxDecoration(
          color: Colors.grey[200],
        ),
        child: new Text(
          "$_verifyStr",
          style: TextStyle( fontSize: 15.0),
        ),
      ),
    );
    return new Padding(
        padding:    const EdgeInsets.only(left: 50.0, right: 50.0,top: 10.0),
        child: new Stack(
          children: <Widget>[
            _verifyCodeEdit,
            new Align(
              alignment: Alignment.topRight,
              child: _buildVerifyBun,
            )
          ],
        ));
  }

  Widget _buildRegist() {
    return new Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 80.0),
      child: new RaisedButton(
        color:Colors.blue[300],
        textColor: Colors.white,
        disabledColor: Colors.blue[100],
        disabledTextColor: Colors.white,
        onPressed: (_phoneNum.isEmpty || _verifyCode.isEmpty)
            ? null
            : () {
                Navigator.pushNamed(context, '/b');
              },
        child: new Text(
          "登  录",
          style: new TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return new MaterialApp(
    theme: new ThemeData(
      primaryColor: Constants.color_blue
    ),
        home: new Scaffold(
      body: _buildBody(),
    ));
  }
}
