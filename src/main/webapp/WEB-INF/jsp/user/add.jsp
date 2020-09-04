<%--
  Created by IntelliJ IDEA.
  User: hgmyh
  Date: 2020/9/3
  Time: 20:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="user.html">众筹平台 - 用户维护</a></div>
        </div>
        <%@include file="../../common/head.jsp"%>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <%@include file="../../common/menu.jsp"%>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <ol class="breadcrumb">
                <li><a href="#">首页</a></li>
                <li><a href="#">数据列表</a></li>
                <li class="active">新增</li>
            </ol>
            <div class="panel panel-default">
                <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
                <div class="panel-body">
                    <form id="userForm" role="form">
                        <div class="form-group">
                            <label for="loginacct">登陆账号</label>
                            <input type="text" class="form-control" id="loginacct" placeholder="请输入登陆账号">
                        </div>
                        <div class="form-group">
                            <label for="username">用户名称</label>
                            <input type="text" class="form-control" id="username" placeholder="请输入用户名称">
                        </div>
                        <div class="form-group">
                            <label for="email">邮箱地址</label>
                            <input type="email" class="form-control" id="email" placeholder="请输入邮箱地址">
                            <p class="help-block label label-warning">请输入合法的邮箱地址, 格式为： xxxx@xxxx.com</p>
                        </div>
                        <button id="addBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
                        <button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                <h4 class="modal-title" id="myModalLabel">帮助</h4>
            </div>
<%--            这里是问号的点击弹出内容--%>
            <div class="modal-body">
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题1</h4>
                    <p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
                </div>
                <div class="bs-callout bs-callout-info">
                    <h4>测试标题2</h4>
                    <p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
                </div>
            </div>
            <!--
            <div class="modal-footer">
              <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              <button type="button" class="btn btn-primary">Save changes</button>
            </div>
            -->
        </div>
    </div>
</div>
<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/layer/layer.js" ></script>
<script type="text/javascript">
    $(function () {
        $(".list-group-item").click(function(){
            if ( $(this).find("ul") ) {
                $(this).toggleClass("tree-closed");
                if ( $(this).hasClass("tree-closed") ) {
                    $("ul", this).hide("fast");
                } else {
                    $("ul", this).show("fast");
                }
            }
        });
        $("#addBtn").click(function () {
            var loadingIndex = layer.msg('处理中', {icon: 16});
            var loginacct = $("#loginacct").val();
            var username = $("#username").val();
            var email = $("#email").val();
            // var reg = /^\\w+@[a-zA-Z0-9]{2,10}(?:\\.[a-z]{2,4}){1,3}$/;
            var reg = /\w+@\w+\.\w+/;
            if(loginacct == ""){
                layer.msg("登录账号不能为空，请重新输入！", {time:1000, icon:5, shift:6}, function () {});
                return;
            }
            if(username == ""){
                layer.msg("用户名不能为空，请重新输入！", {time:1000, icon:5, shift:6}, function () {});
                return;
            }
            if(email == ""){
                layer.msg("邮箱不能为空，请重新输入！", {time:1000, icon:5, shift:6}, function () {});
                return;
            }else if(!reg.test(email)){
                layer.msg("邮箱格式错误，请重新输入！", {time:1000, icon:5, shift:6}, function () {});
                return;
            }
            var loadingIndex = null;
            $.ajax({
                type:"POST",
                url:"${APP_PATH}/user/doAdd",
                data:{
                    "loginacct":loginacct,
                    "username":username,
                    "email":email
                },
                beforesend:function () {
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success:function (result) {
                    layer.close(loadingIndex);
                    if(result.success){
                        layer.msg("用户新增成功，初始密码【123456】！", {time:1500, icon:6}, function () {
                            window.location.href = "${APP_PATH}/user/vindicate";
                        });
                    }else{
                        layer.msg("数据库已存在该用户，新增失败！", {time:1000, icon:5, shift:6}, function () {});
                    }
                }
            })
        });
        $("#resetBtn").click(function () {
            $("#userForm")[0].reset();
        })
    });
</script>
</body>
</html>

