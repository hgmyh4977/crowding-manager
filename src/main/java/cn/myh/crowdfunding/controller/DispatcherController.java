package cn.myh.crowdfunding.controller;

import cn.myh.crowdfunding.domain.AjaxResult;
import cn.myh.crowdfunding.domain.User;
import cn.myh.crowdfunding.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;

/**
 * description: DispatcherController <br>
 * date: 2020/9/2 22:55 <br>
 * author: myh <br>
 * version: 1.0 <br>
 */
@Controller
public class DispatcherController {

    @Autowired
    private UserService userService;

    @RequestMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:login";
    }

    @RequestMapping("/main")
    public String main(){
        return "main";
    }

    @RequestMapping("/login")
    public String login(){
        return "login";
    }

    @ResponseBody
    @RequestMapping("/doAjaxLogin")
    public Object doAjaxLogin(User form, HttpSession session){
        AjaxResult result = new AjaxResult();
        try{
            User user = userService.queryUser(form);
            session.setAttribute("loginUser",user);
            result.setSuccess(true);
        }catch (Exception e){
            e.printStackTrace();
            result.setSuccess(false);
        }
        return result;
    }
}
