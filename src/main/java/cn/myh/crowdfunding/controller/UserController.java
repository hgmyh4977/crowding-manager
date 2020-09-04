package cn.myh.crowdfunding.controller;

import cn.myh.crowdfunding.domain.AjaxResult;
import cn.myh.crowdfunding.domain.Page;
import cn.myh.crowdfunding.domain.User;
import cn.myh.crowdfunding.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.SimpleFormatter;

/**
 * description: UserController <br>
 * date: 2020/9/3 13:10 <br>
 * author: myh <br>
 * version: 1.0 <br>
 */
@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    private UserService userService;

    @ResponseBody
    @RequestMapping("/doEdit")
    public Object doEdit(User form){
        AjaxResult result = new AjaxResult();
        SimpleDateFormat sdf = new SimpleDateFormat("yyy-MM-dd HH:mm:ss");
        form.setCreatetime(sdf.format(new Date()));
        try{
            Integer id = form.getId();
            userService.updateUser(form);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/edit")
    public String edit(Integer id,Model model){
        User user = userService.queryUserById(id);
        model.addAttribute("user",user);
        return "user/edit";
    }

    @ResponseBody
    @RequestMapping("/deleteSingleUser")
    public Object deleteSingleUser(Integer userid){
        AjaxResult result = new AjaxResult();
        try{
            userService.deleteUser(userid);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/doDelete")
    public Object doDelete(Integer[] userid){
        AjaxResult result = new AjaxResult();
        try {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("userids", userid);
            userService.deleteUsers(map);
            result.setSuccess(true);
        } catch ( Exception e ) {
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @ResponseBody
    @RequestMapping("/doAdd")
    public Object doAdd(User form){
        AjaxResult result = new AjaxResult();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss ");
        form.setCreatetime(sdf.format(new Date()));
        form.setLoginpwd("123456");
        try{
            userService.addUser(form);
            result.setSuccess(true);
        } catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/add")
    public String add(){
        return "user/add";
    }

    @ResponseBody
    @RequestMapping("/pageQuery")
    public Object pageQuery(String queryText , Integer pageno,Integer pagesize){
        AjaxResult result = new AjaxResult();
        try {
            Map<String,Object> map = new HashMap<>();
            map.put("start",(pageno-1)*pagesize);
            map.put("size",pagesize);
            map.put("queryText",queryText);
            List<User> users = userService.pageQuery(map);
            int totalno = userService.queryUserCount(map);
            if(totalno % pagesize == 0){
                totalno = totalno / pagesize;
            }else{
                totalno = totalno/pagesize + 1;
            }
            Page<User> userPage = new Page<>();
            userPage.setPageno(pageno);
            userPage.setPagesize(pagesize);
            userPage.setTotalno(totalno);
            userPage.setDatas(users);
            result.setData(userPage);
            result.setSuccess(true);
        } catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }

    @RequestMapping("/vindicate")
    public String vindicate(){
        return "user/vindicate";
    }
}
