package cn.myh.crowdfunding.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * description: PermissionController <br>
 * date: 2020/9/3 13:14 <br>
 * author: myh <br>
 * version: 1.0 <br>
 */
@Controller
@RequestMapping("/permission")
public class PermissionController {

    @RequestMapping("/vindicate")
    public String vindicate(){
        return "permission/vindicate";
    }
}
