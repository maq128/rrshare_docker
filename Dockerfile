FROM alpine:latest

# ENV GLIBC_VERSION=2.29-r0

# https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub
COPY sgerrand.rsa.pub /etc/apk/keys/sgerrand.rsa.pub

# https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-${GLIBC_VERSION}.apk
COPY glibc-2.29-r0.apk /glibc-2.29-r0.apk

# https://github.com/sgerrand/alpine-pkg-glibc/releases/download/${GLIBC_VERSION}/glibc-bin-${GLIBC_VERSION}.apk
COPY glibc-bin-2.29-r0.apk /glibc-bin-2.29-r0.apk

# http://appdown.rrys.tv/rrshareweb_centos7.tar.gz
COPY rrshareweb_centos7.tar.gz /rrshare/rrshareweb_centos7.tar.gz

RUN echo http://mirrors.aliyun.com/alpine/latest-stable/main > /etc/apk/repositories \
 && echo http://mirrors.aliyun.com/alpine/latest-stable/community >> /etc/apk/repositories \
 && apk update \
 && apk add libstdc++ tzdata \
 && cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
 && echo 'Asia/Shanghai' > /etc/timezone \
 && apk add /glibc-2.29-r0.apk \
 && apk add /glibc-bin-2.29-r0.apk \
 && rm -rf /glibc-2.29-r0.apk \
 && rm -rf /glibc-bin-2.29-r0.apk \
 && apk del tzdata \
 && mkdir -p /rrshare \
 && mkdir -p /opt/work/store \
 && tar zxvf /rrshare/rrshareweb_centos7.tar.gz -C /rrshare/ \
 && rm -rf /rrshare/rrshareweb_centos7.tar.gz

RUN sed -i "s/http:\/\/www\.zmzfile\.com\/file\//http:\/\/file.apicvn.com\/file\//g" /rrshare/rrshareweb/web/build/static/js/main.*.js \
 && sed -i "s/http:\/\/file\.zmzfile\.com:6100\/file\/list/http:\/\/file.apicvn.com\/file\/list\?aaaaa/g" /rrshare/rrshareweb/rrshareweb

WORKDIR /
VOLUME ["/opt/work/store","/opt/work/conf"]
EXPOSE 3001

CMD ["sh", "-c", "if [ ! -f /opt/work/conf/rrshare.db ]; then echo 'conf not found,build!' && mkdir -p /opt/work/conf && mv /rrshare/rrshareweb/conf/* /opt/work/conf/ && ln -s /opt/work/conf/rrshare.db /rrshare/rrshareweb/conf/ &&   ln -s /opt/work/conf/rrshare.json /rrshare/rrshareweb/conf/ ; else echo 'file found,link!' && rm -f /rrshare/rrshareweb/conf/* && ln -s /opt/work/conf/rrshare.db /rrshare/rrshareweb/conf/ &&   ln -s /opt/work/conf/rrshare.json /rrshare/rrshareweb/conf/ ; fi; /rrshare/rrshareweb/rrshareweb"]
