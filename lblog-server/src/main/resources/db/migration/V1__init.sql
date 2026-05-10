-- ============================================================
-- LBlog 数据库初始化 - V1: 创建所有表
-- ============================================================

-- 1. 用户表
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL COMMENT '登录名',
  `password_hash` varchar(255) NOT NULL COMMENT '加密密码',
  `nickname` varchar(100) DEFAULT NULL COMMENT '显示名称',
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `avatar` varchar(500) DEFAULT NULL COMMENT '头像URL',
  `role` varchar(20) NOT NULL DEFAULT 'author' COMMENT '角色：admin/author',
  `status` tinyint NOT NULL DEFAULT 1 COMMENT '1-正常，0-禁用',
  `last_login_at` datetime DEFAULT NULL COMMENT '最后登录时间',
  `login_count` int DEFAULT 0 COMMENT '登录次数',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL COMMENT '软删除时间',
  `is_delelte` int DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_username` (`username`),
  UNIQUE KEY `uk_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户表';

-- 2. 分类表
CREATE TABLE IF NOT EXISTS `categories` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '分类名',
  `slug` varchar(100) NOT NULL COMMENT 'URL标识',
  `parent_id` bigint DEFAULT NULL COMMENT '父分类ID',
  `description` varchar(255) DEFAULT NULL COMMENT '分类描述',
  `sort_order` int NOT NULL DEFAULT 0 COMMENT '排序',
  `created_by` bigint DEFAULT NULL COMMENT '创建者用户ID',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL COMMENT '软删除时间',
  `is_delelte` int DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='分类表';

-- 3. 标签表
CREATE TABLE IF NOT EXISTS `tags` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL COMMENT '标签名',
  `slug` varchar(100) NOT NULL COMMENT 'URL标识',
  `created_by` bigint DEFAULT NULL COMMENT '创建者用户ID',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL COMMENT '软删除时间',
  `is_delelte` int DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='标签表';

-- 4. 专栏表
CREATE TABLE IF NOT EXISTS `series` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '专栏名称',
  `slug` varchar(255) NOT NULL COMMENT 'URL标识',
  `description` text COMMENT '专栏简介',
  `cover_image_url` varchar(500) DEFAULT NULL COMMENT '封面图URL',
  `category_id` bigint DEFAULT NULL COMMENT '所属分类ID',
  `is_completed` tinyint NOT NULL DEFAULT 0 COMMENT '0-未完结，1-已完结',
  `sort_order` int NOT NULL DEFAULT 0 COMMENT '排序',
  `created_by` bigint DEFAULT NULL COMMENT '创建者用户ID',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL COMMENT '软删除时间',
  `is_delelte` int DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_created_by` (`created_by`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='专栏表';

-- 5. 文章元数据表
CREATE TABLE IF NOT EXISTS `posts` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL COMMENT '文章标题',
  `slug` varchar(255) NOT NULL COMMENT 'URL标识',
  `excerpt` text COMMENT '摘要',
  `featured_image` varchar(500) DEFAULT NULL COMMENT '特色图片',
  `status` tinyint NOT NULL DEFAULT 0 COMMENT '0-草稿，1-已发布，2-私密',
  `author_id` bigint DEFAULT NULL COMMENT '作者用户ID',
  `category_id` bigint DEFAULT NULL COMMENT '所属分类ID',
  `view_count` int NOT NULL DEFAULT 0 COMMENT '浏览量',
  `like_count` int NOT NULL DEFAULT 0 COMMENT '点赞数',
  `published_at` datetime DEFAULT NULL COMMENT '发布时间',
  `comment_count` int NOT NULL DEFAULT 0 COMMENT '评论数',
  `comment_enable` int NOT NULL DEFAULT 0 COMMENT '是否允许评论',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL COMMENT '软删除时间',
  `is_delelte` int DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_slug` (`slug`),
  KEY `idx_author_id` (`author_id`),
  KEY `idx_category_id` (`category_id`),
  KEY `idx_status_published` (`status`, `published_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文章元数据表';

-- 6. 文章内容表
CREATE TABLE IF NOT EXISTS `post_contents` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL COMMENT '关联文章ID',
  `body` longtext NOT NULL COMMENT '文章正文（Markdown/HTML）',
  `format` varchar(20) NOT NULL DEFAULT 'markdown' COMMENT '内容格式',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `is_delelte` int DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文章内容表';

-- 7. 文章标签关联表
CREATE TABLE IF NOT EXISTS `post_tags` (
  `post_id` bigint NOT NULL,
  `tag_id` bigint NOT NULL,
  PRIMARY KEY (`post_id`, `tag_id`),
  KEY `idx_tag_id` (`tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='文章标签关联表';

-- 8. 专栏文章关联表
CREATE TABLE IF NOT EXISTS `series_posts` (
  `series_id` bigint NOT NULL,
  `post_id` bigint NOT NULL,
  `sort_order` int NOT NULL DEFAULT 0 COMMENT '专栏内排序',
  PRIMARY KEY (`series_id`, `post_id`),
  KEY `idx_post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='专栏文章关联表';

-- 9. 点赞记录表
CREATE TABLE IF NOT EXISTS `like_records` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL COMMENT '文章ID',
  `visitor_id` varchar(64) NOT NULL COMMENT '浏览器指纹',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_post_visitor` (`post_id`, `visitor_id`),
  KEY `idx_post_id` (`post_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='点赞记录表';

-- 10. 评论表
CREATE TABLE IF NOT EXISTS `comments` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `post_id` bigint NOT NULL COMMENT '文章ID',
  `parent_id` bigint DEFAULT NULL COMMENT '父评论ID',
  `root_id` bigint DEFAULT NULL COMMENT '根评论ID',
  `user_id` bigint DEFAULT NULL COMMENT '评论用户ID',
  `author_name` varchar(100) DEFAULT NULL COMMENT '评论者名称',
  `author_avatar` varchar(500) DEFAULT NULL COMMENT '评论者头像',
  `reply_to_uid` bigint DEFAULT NULL COMMENT '回复目标用户ID',
  `reply_to_name` varchar(100) DEFAULT NULL COMMENT '回复目标用户名称',
  `content` text NOT NULL COMMENT '评论内容',
  `status` tinyint DEFAULT 0 COMMENT '0-待审核，1-已发布，2-已删除',
  `like_count` int DEFAULT 0 COMMENT '点赞数',
  `reply_count` int DEFAULT 0 COMMENT '回复数',
  `ip_address` varchar(45) DEFAULT NULL COMMENT 'IP地址',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `deleted_at` datetime DEFAULT NULL COMMENT '软删除时间',
  `is_delelte` int DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`),
  KEY `idx_post_id` (`post_id`),
  KEY `idx_parent_id` (`parent_id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='评论表';

-- 11. 用户令牌表
CREATE TABLE IF NOT EXISTS `user_tokens` (
  `id` BIGINT PRIMARY KEY AUTO_INCREMENT,
  `user_id` BIGINT NOT NULL COMMENT '用户ID',
  `token_hash` VARCHAR(64) NOT NULL COMMENT 'SHA-256(token)',
  `token_type` VARCHAR(10) NOT NULL COMMENT 'ACCESS / REFRESH',
  `expires_at` DATETIME NOT NULL COMMENT '过期时间',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `revoked` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否吊销',
  `replaced_by` VARCHAR(64) DEFAULT NULL COMMENT 'rotation: 被哪个新 token_hash 替换',
  CONSTRAINT `fk_token_user` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户令牌表';

CREATE UNIQUE INDEX `uk_token_hash` ON `user_tokens`(`token_hash`);
CREATE INDEX `idx_user_id` ON `user_tokens`(`user_id`);
CREATE INDEX `idx_expires` ON `user_tokens`(`expires_at`);

-- 12. 图片库表
CREATE TABLE IF NOT EXISTS `images` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
  `url` VARCHAR(500) NOT NULL COMMENT '访问URL',
  `storage_path` VARCHAR(500) NOT NULL COMMENT '存储路径（磁盘路径或OSS key）',
  `original_name` VARCHAR(255) NOT NULL COMMENT '原始文件名',
  `mime_type` VARCHAR(50) NOT NULL COMMENT 'MIME类型',
  `file_size` BIGINT NOT NULL DEFAULT 0 COMMENT '文件大小（字节）',
  `width` INT DEFAULT NULL COMMENT '图片宽度',
  `height` INT DEFAULT NULL COMMENT '图片高度',
  `md5` VARCHAR(32) DEFAULT NULL COMMENT '文件MD5，用于去重',
  `created_by` BIGINT DEFAULT NULL COMMENT '上传者用户ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` DATETIME DEFAULT NULL COMMENT '软删除时间',
  INDEX `idx_md5` (`md5`),
  INDEX `idx_url` (`url`(191)),
  INDEX `idx_created_by` (`created_by`),
  INDEX `idx_created_at` (`created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图片库';

-- 13. 图片引用关系表
CREATE TABLE IF NOT EXISTS `image_usages` (
  `id` BIGINT AUTO_INCREMENT PRIMARY KEY COMMENT '主键',
  `image_id` BIGINT NOT NULL COMMENT '图片ID',
  `ref_type` VARCHAR(20) NOT NULL COMMENT '引用类型：post / user / album / ...',
  `ref_id` BIGINT NOT NULL COMMENT '引用对象ID',
  `field` VARCHAR(20) NOT NULL COMMENT '引用字段：body / featured_image / avatar / cover / ...',
  INDEX `idx_image_id` (`image_id`),
  INDEX `idx_ref` (`ref_type`, `ref_id`),
  UNIQUE KEY `uk_usage` (`image_id`, `ref_type`, `ref_id`, `field`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='图片引用关系';

-- 14. 角色表
CREATE TABLE IF NOT EXISTS `roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL COMMENT '角色标识',
  `label` varchar(100) DEFAULT NULL COMMENT '角色显示名称',
  `description` varchar(255) DEFAULT NULL COMMENT '角色描述',
  `sort_order` int DEFAULT 0 COMMENT '排序',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色表';

-- 15. 权限表
CREATE TABLE IF NOT EXISTS `permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(100) NOT NULL COMMENT '权限编码',
  `label` varchar(100) DEFAULT NULL COMMENT '权限显示名称',
  `module` varchar(50) DEFAULT NULL COMMENT '所属模块',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='权限表';

-- 16. 用户角色关联表
CREATE TABLE IF NOT EXISTS `user_roles` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`),
  KEY `idx_role_id` (`role_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='用户角色关联表';

-- 17. 角色权限关联表
CREATE TABLE IF NOT EXISTS `role_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `permission_id` bigint NOT NULL COMMENT '权限ID',
  PRIMARY KEY (`id`),
  KEY `idx_role_id` (`role_id`),
  KEY `idx_permission_id` (`permission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='角色权限关联表';

-- 18. 站点配置表
CREATE TABLE IF NOT EXISTS `site_config` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `config_key` varchar(100) NOT NULL COMMENT '配置键',
  `config_value` text COMMENT '配置值',
  `created_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_config_key` (`config_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='站点配置表';
