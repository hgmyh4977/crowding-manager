package cn.myh.crowdfunding.web.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

/**
 * description: ServerStartUpListener <br>
 * date: 2020/9/2 22:58 <br>
 * author: myh <br>
 * version: 1.0 <br>
 */
public class ServerStartUpListener implements ServletContextListener {
        @Override
        public void contextInitialized(ServletContextEvent sce) {
            ServletContext servletContext = sce.getServletContext();
            String path = servletContext.getContextPath();
            servletContext.setAttribute("APP_PATH",servletContext.getContextPath());
        }

        @Override
        public void contextDestroyed(ServletContextEvent sce) {

        }

}
