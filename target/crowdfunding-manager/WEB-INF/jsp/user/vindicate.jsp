<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="GB18030">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/main.css">
    <style>
        .tree li {
            list-style-type: none;
            cursor:pointer;
        }
        table tbody tr:nth-child(odd){background:#F4F4F4;}
        table tbody td:nth-child(even){color:#C00;}
    </style>
</head>

<body>

<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container-fluid">
        <div class="navbar-header">
            <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 用户维护</a></div>
        </div>
        <%@include file="../../common/head.jsp"%>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <div class="container-fluid">
            <div class="row">
                <%@include file="../../common/menu.jsp"%>
            </div>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
                </div>
                <div class="panel-body">
                    <form class="form-inline" role="form" style="float:left;">
                        <div class="form-group has-feedback">
                            <div class="input-group">
                                <div class="input-group-addon">查询条件</div>
                                <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件" />
                            </div>
                        </div>
                        <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
                    </form>
                    <button id="deleteBtn" type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="doDeleteUsers()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
                    <button id="addBtn" type="button" class="btn btn-primary" style="float:right;"  ><i class="glyphicon glyphicon-plus"></i> 新增</button>
                    <br>
                    <hr style="clear:both;">
                    <div class="table-responsive">
                        <form id="userForm">
                            <table class="table  table-bordered">
                                <thead>
                                <tr >
                                    <th width="30">#</th>
                                    <th width="30"><input id="allSetBtn" type="checkbox"></th>
                                    <th>账号</th>
                                    <th>名称</th>
                                    <th>邮箱地址</th>
                                    <th width="100">操作</th>
                                </tr>
                                </thead>
                                <tbody id="userData">


                                </tbody>
                                <tfoot>
                                <tr >
                                    <td colspan="6" align="center">
                                        <ul class="pagination">
                                            <!-- 异步增加 -->
                                        </ul>
                                    </td>
                                </tr>
                                </tfoot>
                            </table>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
<script src="${APP_PATH}/script/docs.min.js"></script>
<script src="${APP_PATH}/layer/layer.js"></script>
<script type="text/javascript">
    var fuzzyFlag = false;
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
        pageQuery(1);

        $("#queryBtn").click(function () {
            var queryText = $("#queryTexte").val()
            if(queryText == ""){
                fuzzyFlag = false;
            }else{
                fuzzyFlag = true;
            }
            pageQuery(1)
        });
        $("#allSetBtn").click(function () {
            var flag = this.checked;
            $("#userData :checkbox").each(function () {
                this.checked = flag;
            });
        });
    });
    $("#addBtn").click(function () {
        window.location.href = "${APP_PATH}/user/add";
    });

    $("tbody .btn-success").click(function(){
        window.location.href = "assignRole.html";
    });
    $("tbody .btn-primary").click(function(){
        window.location.href = "edit.html";
    });
    // 异步分页查询
    function pageQuery(pageno){
        var loadingIndex = null;
        var jsonData  = {"pageno":pageno,"pagesize":4}
        if( fuzzyFlag == true){
            jsonData.queryText = $("#queryText").val();
        }

        $.ajax({
            type:"POST",
            url:"${APP_PATH}/user/pageQuery",
            data:jsonData,
            beforeSend:function () {
                loadingIndex  = layer.msg('处理中', {icon: 16});
            },
            success:function (result) {
                layer.close(loadingIndex);
                if(result.success){
                    var userPage = result.data;
                    var users = userPage.datas;
                    var tableContent = "";
                    var pageContent = "";
                    $.each(users,function(i,user){
                        tableContent +='<tr>';
                        tableContent +='    <td>'+(i+1)+'</td>';
                        tableContent +='    <td><input type="checkbox" name="userid" value="'+user.id+'"></td>';
                        tableContent +='        <td>'+user.loginacct+'</td>';
                        tableContent +='        <td>'+user.username+'</td>';
                        tableContent +='        <td>'+user.email+'</td>';
                        tableContent +='    <td>';
                        tableContent +='        <button type="button" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
                        tableContent +='        <button type="button" class="btn btn-primary btn-xs" onclick="editUser('+user.id+')"><i class=" glyphicon glyphicon-pencil"></i></button>';
                        tableContent +='        <button type="button" class="btn btn-danger btn-xs" onclick="deleteSingleUser('+user.id+')"><i class=" glyphicon glyphicon-remove"></i></button>';
                        tableContent +='    </td>';
                        tableContent +='</tr>';
                    });
                    if (userPage.totalno <=5){
                        if(pageno == 1) {
                            pageContent += '<li class="disabled"><a href="#">上一页</a></li>';
                        }else{
                            pageContent += '<li><a href="#" onclick="pageQuery('+(pageno-1)+')">上一页</a></li>';
                        }
                        for(var i=1;i<=userPage.totalno;i++) {
                            if(i == pageno){
                                pageContent += '<li class="active"><a href="#">'+ i +'<span class="sr-only">(current)</span></a></li>';
                            }else{
                                pageContent += '    <li><a href="#" onclick="pageQuery('+i+')">'+ i+'</a></li>';
                            }
                        }
                        if(pageno == userPage.totalno) {
                            pageContent += '<li class="disabled"><a href="#">下一页</a></li>';
                        }else{
                            pageContent += '<li><a href="#" onclick="pageQuery('+(pageno+1)+')">下一页</a></li>';
                        }
                    }else{
                        var start = 2;
                        var end = 6;
                        if(pageno <= 3 ){
                            start = 1;
                            end = start + 4;
                        }else if(pageno >= userPage.totalno - 2 ){
                            end = userPage.totalno;
                            start = end - 4;
                        }
                        if(pageno == start ) {
                            pageContent += '<li class="disabled"><a href="#">上一页</a></li>';
                        }else{
                            pageContent += '<li><a href="#" onclick="pageQuery('+(pageno-1)+')">上一页</a></li>';
                        }
                        for(var i=start;i<= end;i++){
                            if(i == pageno){
                                pageContent += '<li class="active"><a href="#">'+ pageno +'<span class="sr-only">(current)</span></a></li>';
                            }else{
                                pageContent += '    <li><a href="#" onclick="pageQuery('+i+')">'+i +'</a></li>';
                            }
                        }
                        if(pageno == end) {
                            pageContent += '<li class="disabled"><a href="#">下一页</a></li>';
                        }else{
                            pageContent += '<li><a href="#" onclick="pageQuery('+(pageno+1)+')">下一页</a></li>';
                        }
                    }
                    $("#userData").html(tableContent);
                    $(".pagination").html(pageContent);
                }else{
                    layer.msg("用户查询失败！请重试", {time:1000, icon:5, shift:6}, function () {});
                }
            }
        });
    }
    function doDeleteUsers(){
        var count = 0;
        $("#userData :checkbox").each(function () {
            if(this.checked == true){
                count++;
            }
        });
        if( count == 0 ){
            layer.msg("请选择需要删除的用户信息", {time:2000, icon:5, shift:6}, function(){
            });
        }else{
            layer.confirm("确认删除所选用户吗？",  {icon: 3, title:'提示'}, function(cindex){
                $.ajax({
                    type:"POST",
                    url:"${APP_PATH}/user/doDelete",
                    data:$("#userForm").serialize(),
                    success:function (result) {
                        if ( result.success ) {
                            pageQuery(1);
                        } else {
                            layer.msg("用户信息删除失败", {time:2000, icon:5, shift:6}, function(){
                            });
                        }
                    }
                });

                layer.close(cindex);
            }, function(cindex){
                layer.close(cindex);
            });
        }
    }
    function deleteSingleUser(userid) {
        var loadingIndex = null;
        layer.confirm("确认删除该用户吗？",  {icon: 3, title:'提示'}, function(cindex){
            $.ajax({
                type:"POST",
                url:"${APP_PATH}/user/deleteSingleUser",
                data:{"userid":userid},
                beforesend:function () {
                    loadingIndex  = layer.msg('处理中', {icon: 16});
                },
                success:function (result) {
                    layer.close(loadingIndex);
                    if(result.success){
                        pageQuery(1);
                    }else{
                        layer.msg("用户删除失败，请重试！", {time:1000, icon:5, shift:6}, function () {});
                    }
                }
            });
            layer.close(cindex);
        }, function(cindex){
            layer.close(cindex);
        });
    }
    function editUser(userid) {
        window.location.href = "${APP_PATH}/user/edit?id="+userid;
    }
</script>
</body>
</html>

