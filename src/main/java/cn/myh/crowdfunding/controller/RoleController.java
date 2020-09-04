package cn.myh.crowdfunding.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * description: RoleController <br>
 * date: 2020/9/3 13:12 <br>
 * author: myh <br>
 * version: 1.0 <br>
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @RequestMapping("/vindicate")
    public String vindicate(){
        return "role/vindicate";
    }
}
