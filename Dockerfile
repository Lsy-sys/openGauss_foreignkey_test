# 使用openGauss官方镜像
FROM enmotech/opengauss:latest

# 设置环境变量
ENV GS_PASSWORD=Enmo@123
ENV PGDATA=/var/lib/opengauss/data

# 暴露端口
EXPOSE 5432

# 创建数据目录
RUN mkdir -p /var/lib/opengauss/data

# 复制初始化脚本
COPY ./scripts/ /docker-entrypoint-initdb.d/

# 设置权限
RUN chmod +x /docker-entrypoint-initdb.d/*.sh
