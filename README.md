## CoreBlog-Docker

本项目是[CoreBlog](https://github.com/inbjo/CoreBlog)的docker镜像。

## 使用说明
```bash
cd ~ #CoreBlog安裝目录 可自定义
git clone https://github.com/inbjo/CoreBlog-Docker
cd CoreBlog-Docker
chmod +x ./install.sh && ./install.sh #执行安装脚本
```
然后根据需要编辑项目中的.env文件，.env文件内容如下：  
```text
NGINX_HOST_HTTP_PORT=8080 #Nginx监听的http端口
NGINX_HOST_HTTPS_PORT=4430 #Nginx监听的https端口
```
> 建议保持默认，然后在宿主机安装Nginx再反向代理即可。

编辑完毕后执行`docker-compose up`启动docker服务。然后访问`http://x.x.x.x:8080`进入安装引导程序。
> `docker-compose up -d`可以让docker容器保持后台运行。  
>如果存在问题请加QQ群[862180297](https://jq.qq.com/?_wv=1027&k=5l6VXeo)寻求帮助。  

详细文档请查看[文档](https://www.inbjo.com/docs/1.7/docker)
