# 部署指南：电商生成式 AI 演示

## 概述

本文档说明如何在华为云上部署电商生成式 AI 演示应用。

---

## 前置条件

1. 华为云账号（已开通以下服务）：
   - CCE (容器服务)
   - OBS (对象存储)
   - CSS (向量数据库)
   - CDN (内容分发)
   - ELB (负载均衡)
   - IAM (身份认证)
   - KMS (密钥管理)
   - MaaS (ModelArts) API 访问权限

2. Docker 和 kubectl 客户端

---

## 部署步骤

### 步骤 1: 创建基础网络

```bash
cd infra
terraform init
terraform plan
terraform apply
```

### 步骤 2: 创建 CCE 集群

通过控制台创建 CCE 集群，或使用 terraform：

```bash
# 参考华为云 CCE 文档创建集群
```

### 步骤 3: 制作 Docker 镜像

```bash
# 构建 Streamlit 应用镜像
docker build -t ecommerce-genai-suite:latest .

# 推送到 SWR 或其他镜像仓库
docker tag ecommerce-genai-suite:latest your-registry/ecommerce-genai-suite:latest
docker push your-registry/ecommerce-genai-suite:latest
```

### 步骤 4: 部署到 CCE

```bash
# 使用 kubectl 部署
kubectl apply -f deployment.yaml
```

### 步骤 5: 配置 CDN

1. 登录 CDN 控制台
2. 创建加速域名
3. 配置回源到 CCE 的 ELB

---

## 验证

1. 访问 CDN 提供的 URL
2. 验证各个功能是否正常工作

---

## 清理资源

```bash
terraform destroy
```

---
