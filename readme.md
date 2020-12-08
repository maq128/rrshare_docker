# 人人影视web下载器（rrshare for docker）

## 打包

```sh
docker build --tag rrshare_docker .
```

## 运行

```sh
mkdir ./rrdata
mkdir ./rrconf
docker run -d -p 3001:3001 -v `pwd`/rrdata:/opt/work/store  -v `pwd`/rrconf:/opt/work/conf --name rrshare rrshare_docker
```

## 使用

[http://localhost:3001/](http://localhost:3001/)

缺省的解锁密码是 `123456`

如果要用帐号登录，需通过手机端的 `人人影视app` 注册帐号。

## 关于几个需下载的文件

在构建这个镜像的过程中，本来有 4 个文件是需要在线下载的：

- https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
- https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-2.29-r0.apk
- https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.29-r0/glibc-bin-2.29-r0.apk
- http://appdown.rrys.tv/rrshareweb_centos7.tar.gz

但问题是，前 3 个在境内下载非常慢，第 4 个在境外无法访问。所以这里只好使用离线版本了。
