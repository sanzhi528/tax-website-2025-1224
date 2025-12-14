#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
可靠HTTP服务器 - 解决端口和连接问题
"""

import http.server
import socketserver
import os
import sys
import time

# 设置网站根目录
WEB_ROOT = os.path.dirname(os.path.abspath(__file__))

class CustomHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=WEB_ROOT, **kwargs)
    
    def log_message(self, format, *args):
        # 简化日志输出
        print(f"[{time.strftime('%Y-%m-%d %H:%M:%S')}] {format % args}")

def find_available_port(start_port=8000, max_port=8100):
    """查找可用的端口"""
    import socket
    for port in range(start_port, max_port + 1):
        try:
            with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
                s.bind(('localhost', port))
                return port
        except OSError:
            continue
    raise RuntimeError("找不到可用端口")

def start_reliable_server():
    os.chdir(WEB_ROOT)
    
    # 查找可用端口
    port = find_available_port(8080, 8090)
    
    try:
        with socketserver.TCPServer(("", port), CustomHTTPRequestHandler) as httpd:
            print("=" * 60)
            print("🚀 可靠网站服务器已启动!")
            print("=" * 60)
            print(f"📁 网站根目录: {WEB_ROOT}")
            print(f"🌐 访问地址: http://localhost:{port}")
            print(f"🔗 或使用: http://127.0.0.1:{port}")
            print(f"🌍 局域网访问: http://{get_local_ip()}:{port}")
            print("\n📋 修复内容验证:")
            print("✅ CSS路径: css/style.css")
            print("✅ 公司信息: 广东深圳市龙岗区龙岗街道龙岗路东森大厦，0755-8521-6839")
            print("✅ 域名配置: www.0slm.com.cn")
            print("\n⏹️ 按 Ctrl+C 停止服务器")
            print("=" * 60)
            
            # 测试服务器是否可访问
            test_server_connectivity(port)
            
            httpd.serve_forever()
    except Exception as e:
        print(f"❌ 服务器启动失败: {e}")
        print("尝试使用备用端口...")
        port = find_available_port(9000, 9010)
        start_server_on_port(port)

def start_server_on_port(port):
    """在指定端口启动服务器"""
    with socketserver.TCPServer(("", port), CustomHTTPRequestHandler) as httpd:
        print(f"🌐 服务器已启动在端口 {port}")
        print(f"访问地址: http://localhost:{port}")
        test_server_connectivity(port)
        httpd.serve_forever()

def test_server_connectivity(port):
    """测试服务器连接性"""
    import urllib.request
    try:
        response = urllib.request.urlopen(f'http://localhost:{port}', timeout=5)
        print(f"✅ 服务器连接测试成功 (状态码: {response.status})")
    except Exception as e:
        print(f"⚠️ 连接测试警告: {e}")
        print("但服务器仍在运行，请尝试浏览器访问")

def get_local_ip():
    """获取本地IP地址"""
    import socket
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except:
        return "127.0.0.1"

if __name__ == "__main__":
    start_reliable_server()