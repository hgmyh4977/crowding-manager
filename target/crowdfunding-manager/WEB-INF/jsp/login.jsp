<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/login.css">
    <style>

    </style>
    <title>登录</title>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="${APP_PATH}/login" style="font-size:32px;">尚筹网-创意产品众筹平台</a></div>
        </div>
    </div>
</nav>

<div id="loginDiv" class="container">
    <form id="loginForm" action="" method="post" class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-user"></i> 用户登录</h2>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="loginacct" name="loginacct" placeholder="请输入登录账号" autofocus>
            <span class="glyphicon glyphicon-user form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <input type="text" class="form-control" id="loginpwd" name="loginpwd" placeholder="请输入登录密码" style="margin-top:10px;">
            <span class="glyphicon glyphicon-lock form-control-feedback"></span>
        </div>
        <div class="form-group has-success has-feedback">
            <select class="form-control" >
                <option value="member">会员</option>
                <option value="user">管理</option>
            </select>
        </div>
        <!-- 还没实现的功能 -->
        <div class="checkbox">
            <label>
                <input type="checkbox" value="remember-me"> 记住我
            </label>
            <br>
            <label>
                忘记密码
            </label>
            <label style="float:right">
                <a href="reg.html">我要注册</a>
            </label>
        </div>
        <a id="loginBtn" class="btn btn-lg btn-success btn-block" onclick="dologin()" > 登录</a>
    </form>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/layer/layer.js" ></script>
<script>
    $("#loginDiv").bind('keyup',function (event) {
        if(event.keyCode == 13){
            $("#loginBtn").click();
        }
    })
    function dologin() {
        // 非空校验
        var loginacct = $("#loginacct").val();
        if (loginacct == ""){
            layer.msg("用户登录账号不能为空", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        var loginpwd = $("#loginpwd").val();
        if (loginpwd == ""){
            layer.msg("用户登录密码不能为空", {time:2000, icon:5, shift:6}, function(){
            });
            return;
        }
        // 使用ajax提交数据
        var loadingIndex = null;
        $.ajax({
            type:"POST",
            url:"doAjaxLogin",
            data:{
                "loginacct":loginacct,
                "loginpwd":loginpwd
            },
            beforeSend:function () {
                loadingIndex = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    window.location.href="main";
                }else{
                    layer.msg("账号或密码错误，登录失败！", {time:2000, icon:5, shift:6}, function(){
                    });
                }
            }
        });
    }
</script>
</body>
</html>
