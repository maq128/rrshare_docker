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
