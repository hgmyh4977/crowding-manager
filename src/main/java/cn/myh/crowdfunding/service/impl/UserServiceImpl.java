package cn.myh.crowdfunding.service.impl;

import cn.myh.crowdfunding.dao.UserDao;
import cn.myh.crowdfunding.domain.User;
import cn.myh.crowdfunding.service.UserException;
import cn.myh.crowdfunding.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * description: UserServiceImpl <br>
 * date: 2020/9/3 10:50 <br>
 * author: myh <br>
 * version: 1.0 <br>
 */
@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public User queryUser(User form) throws UserException{
        User user = userDao.queryUser(form);
        if(user != null){
            return user;
        }else{
            throw new UserException("用户名或密码错误");
        }
    }
    @Override
    public User queryUserByLoginacct(String loginacct) {
        return userDao.queryByLoginacct(loginacct);
    }

    @Override
    public List<User> pageQuery(Map<String, Object> map) {
        return userDao.pageQuery(map);
    }

    @Override
    public int queryUserCount(Map<String, Object> map) {
        return userDao.queryUserCount(map);
    }

    @Override
    public void addUser(User form) throws UserException {
        User dbuser = this.queryUserByLoginacct(form.getLoginacct());
        if(dbuser != null){
            throw new UserException();
        }
        userDao.addUser(form);
    }

    @Override
    public void deleteUsers(Map<String, Object> map) {
        userDao.deleteUsers(map);
    }

    @Override
    public void deleteUser(Integer userid) {
        userDao.deleteUserById(userid);
    }

    @Override
    public User queryUserById(Integer id) {
        return userDao.queryUserById(id);
    }

    @Override
    public void updateUser(User form) {
        userDao.updateUser(form);
    }
}
