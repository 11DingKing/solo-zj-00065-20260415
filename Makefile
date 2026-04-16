.PHONY: build up down logs migrate createsuperuser shell ps restart clean

# Docker Compose 命令
COMPOSE = docker compose

# 默认目标
help:
	@echo "可用的 make 命令:"
	@echo "  make build          - 构建 Docker 镜像"
	@echo "  make up             - 启动所有服务（后台运行）"
	@echo "  make up-fg          - 启动所有服务（前台运行）"
	@echo "  make down           - 停止并删除所有容器"
	@echo "  make logs           - 查看所有服务日志"
	@echo "  make logs-app       - 查看 app 服务日志"
	@echo "  make logs-worker    - 查看 celery_worker 服务日志"
	@echo "  make logs-beat      - 查看 celery_beat 服务日志"
	@echo "  make logs-flower    - 查看 flower 服务日志"
	@echo "  make logs-nginx     - 查看 nginx 服务日志"
	@echo "  make migrate        - 运行数据库迁移"
	@echo "  make createsuperuser- 创建 Django 超级用户"
	@echo "  make shell          - 进入 Django shell"
	@echo "  make ps             - 查看所有服务状态"
	@echo "  make restart        - 重启所有服务"
	@echo "  make clean          - 清理所有容器、网络和卷"

# 构建镜像
build:
	$(COMPOSE) build

# 后台启动所有服务
up:
	$(COMPOSE) up -d

# 前台启动所有服务
up-fg:
	$(COMPOSE) up

# 停止并删除所有容器
down:
	$(COMPOSE) down

# 查看所有服务日志
logs:
	$(COMPOSE) logs -f

# 查看 app 服务日志
logs-app:
	$(COMPOSE) logs -f app

# 查看 celery_worker 服务日志
logs-worker:
	$(COMPOSE) logs -f celery_worker

# 查看 celery_beat 服务日志
logs-beat:
	$(COMPOSE) logs -f celery_beat

# 查看 flower 服务日志
logs-flower:
	$(COMPOSE) logs -f flower

# 查看 nginx 服务日志
logs-nginx:
	$(COMPOSE) logs -f nginx

# 运行数据库迁移
migrate:
	$(COMPOSE) run --rm app python manage.py migrate

# 创建超级用户
createsuperuser:
	$(COMPOSE) run --rm app python manage.py createsuperuser

# 进入 Django shell
shell:
	$(COMPOSE) run --rm app python manage.py shell

# 查看服务状态
ps:
	$(COMPOSE) ps

# 重启所有服务
restart:
	$(COMPOSE) restart

# 清理所有容器、网络和卷（谨慎使用）
clean:
	$(COMPOSE) down -v --remove-orphans
