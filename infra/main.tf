# ============================================================================
# 华为云 电商生成式 AI Terraform 配置
# ============================================================================
# 基于电商生成式 AI 参考应用适配
# 架构：CDN + CCE + 盘古大模型
# ============================================================================

terraform {
  required_version = ">= 1.5"

  required_providers {
    huaweicloud = {
      source  = "huaweicloud/huaweicloud"
      version = "~> 1.70"
    }
  }
}

provider "huaweicloud" {
  region = var.region
}

# ============================================================================
# 变量定义
# ============================================================================

variable "region" {
  description = "华为云区域"
  type        = string
  default     = "cn-north-4"
}

variable "project_name" {
  description = "项目名称"
  type        = string
  default     = "ec-genai-20260820"
}

# ============================================================================
# Layer 1: VPC 网络
# ============================================================================

resource "huaweicloud_vpc" "main" {
  name                  = "${var.project_name}-vpc"
  cidr                  = "10.4.0.0/16"
  enterprise_project_id = "0"
}

resource "huaweicloud_vpc_subnet" "main" {
  name       = "${var.project_name}-subnet"
  vpc_id     = huaweicloud_vpc.main.id
  cidr       = "10.4.1.0/24"
  gateway_ip = "10.4.1.1"
}

# ============================================================================
# Layer 2: 安全组
# ============================================================================

resource "huaweicloud_networking_secgroup" "main" {
  name        = "${var.project_name}-sg"
  description = "Security group for gen AI demo"
}

resource "huaweicloud_networking_secgroup_rule" "ingress_http" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 8501
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = huaweicloud_networking_secgroup.main.id
}

# ============================================================================
# Layer 3: OBS
# ============================================================================

resource "huaweicloud_obs_bucket" "assets" {
  bucket        = "${var.project_name}-assets"
  acl           = "private"
  storage_class = "STANDARD"
}

# ============================================================================
# Layer 4: KMS
# ============================================================================

resource "huaweicloud_kms_key" "main" {
  key_alias       = "${var.project_name}-cmk"
  key_description = "KMS key for gen AI demo"
  key_algorithm   = "AES_256"
}

# ============================================================================
# 输出
# ============================================================================

output "vpc_id" {
  description = "VPC ID"
  value       = huaweicloud_vpc.main.id
}

output "obs_bucket" {
  description = "OBS Bucket"
  value       = huaweicloud_obs_bucket.assets.bucket
}

output "kms_key_id" {
  description = "KMS Key ID"
  value       = huaweicloud_kms_key.main.id
}

# ============================================================================
# 说明
# ============================================================================
#
# 以下资源需要通过控制台创建：
#
# 1. CCE 集群 - 容器平台 (部署 Streamlit)
# 2. CDN - 内容分发
# 3. ELB - 负载均衡
# 4. CSS - 向量数据库
#
# AI 能力通过调用盘古 API 实现：
#
# - 盘古大模型 (LLM)
# - 盘古 image (图像生成)
# - 盘古 embeddings (向量嵌入)
# - 机器翻译服务
#
# ============================================================================
