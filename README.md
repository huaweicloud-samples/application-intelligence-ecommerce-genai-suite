# E-Commerce GenAI Demo: Huawei Cloud Best Practice

![License](https://img.shields.io/badge/license-MIT--0-blue.svg)
![Huawei Cloud](https://img.shields.io/badge/华为云-最佳实践-ff4d00.svg)

> Huawei Cloud Best Practice (Architecture-equivalent adaptation)

---

## Overview

Huawei Cloud Best Practice (Same-Shaped Architecture, Not Code Translation)

### Core Features

This demo application includes four core AI use cases, covering the full-chain intelligent needs of e-commerce scenarios:

1. **Product Design Image Generation** - Uses Huawei Cloud MaaS image generation capability (Qwen-Image) to automatically generate product design concept images based on text descriptions. This feature helps designers quickly generate creative prototypes, significantly shortening the product design cycle. The system supports Chinese and English input, and generated images can be directly used for product display or market research.

2. **Product Description Generation** - Based on Huawei Cloud MaaS language generation capability (DeepSeek-V4-Flash/GLM-5.2), automatically generates product copy that meets e-commerce platform specifications. This feature can intelligently generate attractive product descriptions based on product attributes, target audiences, and marketing scenarios, including titles, highlights, and specifications, greatly improving product listing efficiency.

3. **Landing Page Generation** - Intelligently generates marketing landing page content, including hero section slogans, product advantage introductions, and call-to-action button copy. Combined with MaaS platform's content understanding and generation capabilities, this feature helps operations teams quickly create high-quality marketing pages and improve conversion rates.

4. **Product Image Background Correction** - Uses image processing capability (Qwen-Image-Edit) to automatically identify product images and replace backgrounds, transforming casually taken product photos into professional product display images. This feature supports various scenarios including background blur, background replacement, and white background generation, significantly reducing post-processing costs for product images.

### Use Cases

This project is suitable for the following scenarios: e-commerce platform operators needing to batch-generate product content; product managers quickly validating product concept designs; marketing teams creating promotional materials; and developers learning architecture design for cloud-native AI applications.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                     Huawei Cloud Architecture                        │
├─────────────────────────────────────────────────────────────────────┤
│  CDN → ELB + CCE → Streamlit → MaaS API                          │
│                                        │                           │
│    OBS → Translation → CSS → IAM → KMS                            │
└─────────────────────────────────────────────────────────────────────┘
```

---

## Services Used

| Service | Purpose |
|---------|---------|
| MaaS (DeepSeek/Qwen/BGE) | LLM/Image/Embeddings |
| CCE | Container Platform |
| CDN | Content Delivery |
| ELB | Load Balancer |
| CSS | Vector Database |
| OBS | Object Storage |
| IAM | Identity |
| KMS | Key Management |

---

## Quick Start

```bash
cd infra
terraform init
terraform apply
```

---

## License

MIT-0 License
