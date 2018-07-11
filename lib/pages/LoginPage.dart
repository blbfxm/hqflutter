import 'dart:async';

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
              style: TextStyle(color: Colors.blue[700], fontSize: 20.0),
            ),
            onTap: () {},
          ),
          new InkWell(
            child: new Icon(
              Icons.clear,
              color: Colors.blue[700],
            ),
          ),
        ],
      ),
    );
  }

  /* final TextEditingController _textController = new TextEditingController();
return new Container(
  height: 35.0,
margin: const EdgeInsets.all(40.0),
child: new Material(
  type: MaterialType.canvas,
  shape: new StadiumBorder(
    side: new BorderSide(
      color: Colors.grey[200],
      style: BorderStyle.solid
    )
  ),
  child: new TextField(
    autofocus: true,
    controller: _textController,
    decoration: new InputDecoration(
      contentPadding: new EdgeInsets.all(5.0),
        hintText: "请输入手机号",
      border: InputBorder.none
    ),
    onChanged: (String content){
      print(content);
    }
  ),
),
); */

  Widget _buildPhoneEdit() {
    return new Padding(
      padding: const EdgeInsets.only(
          left: 50.0, right: 50.0, top: 40.0, bottom: 10.0),
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
      decoration: const InputDecoration(hintText: "请输入短信验证码"),
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
          style: TextStyle(color: Colors.black, fontSize: 15.0),
        ),
      ),
    );
    return new Padding(
        padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 10.0),
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
        color: Colors.blue,
        textColor: Colors.white,
        disabledColor: Colors.blue[100],
        disabledTextColor: Colors.white,
        onPressed: (_phoneNum.isEmpty || _verifyCode.isEmpty)
            ? null
            : () {
               print("登录");
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
    theme = Theme.of(context);
    return new MaterialApp(
        home: new Scaffold(
      body: _buildBody(),
    ));
  }
}
