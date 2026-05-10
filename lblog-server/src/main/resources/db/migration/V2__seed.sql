-- ============================================================
-- LBlog 种子数据 - V2: 测试数据
-- ============================================================

-- 1. 用户表
INSERT INTO `users` (`id`, `username`, `password_hash`, `nickname`, `email`, `avatar`, `role`, `status`, `created_at`, `updated_at`, `is_delelte`) VALUES
(1, 'ekko', '{noop}admin123', 'Ekko', 'ekko@example.com', '/avatars/ekko.png', 'admin',  1, NOW(), NOW(), 0),
(2, 'alice', '{noop}alice123', 'Alice', 'alice@example.com', NULL, 'author', 1, NOW(), NOW(), 0),
(3, 'bob',   '{noop}bob123',   'Bob',   'bob@example.com',   NULL, 'author', 1, NOW(), NOW(), 0)
ON DUPLICATE KEY UPDATE `username` = VALUES(`username`);

-- 2. 分类表
INSERT INTO `categories` (`id`, `name`, `slug`, `parent_id`, `description`, `sort_order`, `created_by`, `created_at`, `updated_at`, `is_delelte`) VALUES
(1, '后端',    'backend',  NULL, '后端开发技术',          0, 1, NOW(), NOW(), 0),
(2, '前端',    'frontend', NULL, '前端开发技术',          1, 1, NOW(), NOW(), 0),
(3, 'DevOps',  'devops',   NULL, '运维与自动化部署',      2, 1, NOW(), NOW(), 0),
(4, '数据库',  'database', NULL, '数据库技术与优化',      3, 1, NOW(), NOW(), 0)
ON DUPLICATE KEY UPDATE `name` = VALUES(`name`);

-- 3. 标签表
INSERT INTO `tags` (`id`, `name`, `slug`, `created_by`, `created_at`, `updated_at`, `is_delelte`) VALUES
(1, 'Java',         'java',         1, NOW(), NOW(), 0),
(2, 'Spring Boot',  'spring-boot',  1, NOW(), NOW(), 0),
(3, 'Vue.js',       'vuejs',        1, NOW(), NOW(), 0),
(4, 'JavaScript',   'javascript',   1, NOW(), NOW(), 0),
(5, 'Docker',       'docker',       1, NOW(), NOW(), 0),
(6, 'MySQL',        'mysql',        1, NOW(), NOW(), 0)
ON DUPLICATE KEY UPDATE `name` = VALUES(`name`);

-- 4. 专栏表
INSERT INTO `series` (`id`, `title`, `slug`, `description`, `cover_image_url`, `category_id`, `is_completed`, `sort_order`, `created_by`, `created_at`, `updated_at`, `is_delelte`) VALUES
(1, 'Spring Boot 实战',       'spring-boot-in-action',  '从零开始学习 Spring Boot，构建生产级应用',     NULL, 1, 0, 0, 1, NOW(), NOW(), 0),
(2, 'Vue3 入门到精通',        'vue3-from-zero-to-hero', '系统学习 Vue3 组合式 API 与项目实战',         NULL, 2, 0, 1, 1, NOW(), NOW(), 0),
(3, 'Docker 从入门到实践',    'docker-in-action',       '掌握容器化部署与编排技术',                     NULL, 3, 1, 2, 1, NOW(), NOW(), 0)
ON DUPLICATE KEY UPDATE `title` = VALUES(`title`);

-- 5. 文章元数据表
INSERT INTO `posts` (`id`, `title`, `slug`, `excerpt`, `featured_image`, `status`, `author_id`, `category_id`, `view_count`, `like_count`, `comment_count`, `comment_enable`, `published_at`, `created_at`, `updated_at`, `is_delelte`) VALUES
(1,  'Spring Boot 3.0 新特性全面解析',            'spring-boot-3-features',        '全面介绍 Spring Boot 3.0 带来的 GraalVM 原生镜像、Observability、Jakarta EE 9+ 迁移等新特性',            NULL, 1, 1, 1, 1256,  89, 23, 1, '2026-01-15 10:00:00', NOW(), NOW(), 0),
(2,  'Spring Boot 整合 MyBatis-Plus 实战',        'spring-boot-mybatis-plus',      'Spring Boot 3 中整合 MyBatis-Plus，实现高效的数据库操作',                                                NULL, 1, 1, 1, 2341, 156, 45, 1, '2026-02-01 09:00:00', NOW(), NOW(), 0),
(3,  'Java 21 虚拟线程原理与实践',                 'java-21-virtual-threads',       '深入理解 JDK 21 虚拟线程的实现原理和最佳实践',                                                            NULL, 1, 2, 1, 1893, 112, 34, 1, '2026-03-10 14:00:00', NOW(), NOW(), 0),
(4,  'Vue3 组合式 API 详解',                       'vue3-composition-api',          '全面解析 Vue3 组合式 API 的设计思路与使用技巧',                                                          NULL, 1, 1, 2,  987,  67, 12, 1, '2026-01-20 11:00:00', NOW(), NOW(), 0),
(5,  'TypeScript 5.0 新特性一览',                  'typescript-5-features',         'TypeScript 5.0 带来的装饰器、const 类型参数等新特性',                                                    NULL, 1, 2, 2,  756,  45,  8, 1, '2026-02-15 10:00:00', NOW(), NOW(), 0),
(6,  'Element Plus 组件库深度使用指南',            'element-plus-guide',            'Element Plus 组件库的最佳实践与常见问题',                                                               NULL, 1, 1, 2,  543,  34,  7, 1, '2026-03-01 09:00:00', NOW(), NOW(), 0),
(7,  'Docker Compose 生产环境部署指南',            'docker-compose-production',     '使用 Docker Compose 部署高可用生产环境应用',                                                            NULL, 1, 2, 3, 3456, 201, 56, 1, '2026-02-20 08:00:00', NOW(), NOW(), 0),
(8,  'Kubernetes 入门教程',                        'kubernetes-intro',              '从零开始学习 Kubernetes 容器编排平台',                                                                  NULL, 1, 3, 3, 2156, 134, 42, 1, '2026-03-15 10:00:00', NOW(), NOW(), 0),
(9,  'CI/CD 流水线构建最佳实践',                   'cicd-best-practices',           '基于 GitLab CI 和 Jenkins 的流水线设计实践',                                                             NULL, 1, 3, 3, 1567,  98, 29, 1, '2026-04-01 09:00:00', NOW(), NOW(), 0),
(10, 'MySQL 索引优化实战：从慢查询到毫秒级响应',   'mysql-index-optimization',       '通过真实案例讲解 MySQL 索引优化技巧，让查询飞起来',                                                    NULL, 1, 1, 4, 4321, 287, 78, 1, '2026-04-10 10:00:00', NOW(), NOW(), 0),
(11, 'MySQL 8.0 新特性详解',                       'mysql-8-features',              '窗口函数、CTE、降序索引等 MySQL 8.0 核心新特性解析',                                                    NULL, 1, 2, 4, 1876, 123, 34, 1, '2026-04-15 14:00:00', NOW(), NOW(), 0),
(12, '草稿文章: 尚未完成',                         'draft-post',                    '这是一篇草稿，status=0 不应出现在首页列表中',                                                            NULL, 0, 1, 1,    0,   0,  0, 1, NULL,             NOW(), NOW(), 0)
ON DUPLICATE KEY UPDATE `title` = VALUES(`title`);

-- 6. 文章内容表
INSERT INTO `post_contents` (`post_id`, `body`, `format`, `created_at`, `updated_at`, `is_delelte`) VALUES
(1,  '# Spring Boot 3.0 新特性全面解析\n\nSpring Boot 3.0 是基于 Spring Framework 6 构建的…',                                    'markdown', NOW(), NOW(), 0),
(2,  '# Spring Boot 整合 MyBatis-Plus\n\n## 环境搭建\n…',                                                                      'markdown', NOW(), NOW(), 0),
(3,  '# Java 21 虚拟线程\n\n## 什么是虚拟线程\n…',                                                                             'markdown', NOW(), NOW(), 0),
(4,  '# Vue3 组合式 API 详解\n\n## setup 函数\n…',                                                                             'markdown', NOW(), NOW(), 0),
(5,  '# TypeScript 5.0 新特性\n\n## 装饰器\n…',                                                                                'markdown', NOW(), NOW(), 0),
(6,  '# Element Plus 使用指南\n\n## 快速开始\n…',                                                                              'markdown', NOW(), NOW(), 0),
(7,  '# Docker Compose 生产部署\n\n## 环境要求\n…',                                                                           'markdown', NOW(), NOW(), 0),
(8,  '# Kubernetes 入门\n\n## 核心概念\n…',                                                                                  'markdown', NOW(), NOW(), 0),
(9,  '# CI/CD 最佳实践\n\n## 流水线设计\n…',                                                                                 'markdown', NOW(), NOW(), 0),
(10, '# MySQL 索引优化\n\n## 慢查询分析\n…',                                                                                   'markdown', NOW(), NOW(), 0),
(11, '# MySQL 8.0 新特性\n\n## 窗口函数\n…',                                                                                  'markdown', NOW(), NOW(), 0),
(12, '# 草稿内容',                                                                                                              'markdown', NOW(), NOW(), 0)
ON DUPLICATE KEY UPDATE `post_id` = VALUES(`post_id`);

-- 7. 文章标签关联
INSERT INTO `post_tags` (`post_id`, `tag_id`) VALUES
(1, 1), (2, 1), (3, 1),
(1, 2), (2, 2),
(4, 3), (6, 3),
(4, 4), (5, 4),
(7, 5), (8, 5), (9, 5),
(10, 6), (11, 6)
ON DUPLICATE KEY UPDATE `post_id` = VALUES(`post_id`);

-- 8. 专栏文章关联
INSERT INTO `series_posts` (`series_id`, `post_id`, `sort_order`) VALUES
(1, 1, 0), (1, 2, 1), (1, 3, 2),
(2, 4, 0), (2, 5, 1), (2, 6, 2),
(3, 7, 0), (3, 8, 1), (3, 9, 2)
ON DUPLICATE KEY UPDATE `series_id` = VALUES(`series_id`);

-- 9. 点赞记录
INSERT INTO `like_records` (`post_id`, `visitor_id`, `created_at`) VALUES
(1, 'visitor-uuid-a1b2c3d4', '2026-04-24 10:00:00'),
(1, 'visitor-uuid-e5f6g7h8', '2026-04-24 11:30:00'),
(1, 'visitor-uuid-i9j0k1l2', '2026-04-24 14:15:00'),
(10, 'visitor-uuid-a1b2c3d4', '2026-04-25 09:00:00'),
(10, 'visitor-uuid-m3n4o5p6', '2026-04-25 10:20:00')
ON DUPLICATE KEY UPDATE `post_id` = VALUES(`post_id`);
