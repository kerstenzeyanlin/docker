FROM scratch
USER root
# init
ENV TIME_ZONE="Asia/Taipei"
# timezone
RUN echo $TIME_ZONE > /etc/timezone
RUN dpkg-reconfigure --frontend noninteractive tzdata
# 上面內容功能是先將時區名稱加至/etc/timezone檔案
# 再執行dpkg-reconfigure設定時區
# 如此一來預設值就在台灣的時區
# 不用再手動變更
LABEL org.label-schema.license="GPL-2.0"
ADD https://github.com/debuerreotype/docker-debian-artifacts/raw/af5a0043a929e0c87f7610da93bfe599ac40f29b/stretch/rootfs.tar.xz /
CMD ["bash"]
