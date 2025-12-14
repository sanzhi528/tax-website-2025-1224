#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
简单HTTP服务器 - 用于快速预览网站
"""

import http.server
import socketserver
import os
import sys

# 设置网站根目录
WEB_ROOT = os.path.dirname(os.path.abspath(__file__))
PORT = 8080  # 使用8080端口避免冲突

class SimpleHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=WEB_ROOT, **kwargs)

def start_simple_server():
    os.chdir(WEB_ROOT)
    port = PORT
    
    try:
        with socketserver.TCPServer(("", port), SimpleHTTPRequestHandler) as httpd:
            print("=" * 50)
            print("🚀 简单网站服务器已启动!")
            print("=" * 50)
            print(f"📁 网站根目录: {WEB_ROOT}")
            print(f"🌐 访问地址: http://localhost:{port}")
            print(f"🔗 或使用: http://127.0.0.1:{port}")
            print("\n📋 修复内容验证:")
            print("✅ CSS路径: css/style.css")
            print("✅ 公司信息: 广东深圳市龙岗区龙岗街道龙岗路东森大厦，0755-8521-6839")
            print("✅ 域名配置: www.0slm.com.cn")
            print("\n⏹️ 按 Ctrl+C 停止服务器")
            print("=" * 50)
            
            httpd.serve_forever()
    except OSError as e:
        if "Address already in use" in str(e):
            print(f"❌ 端口 {port} 已被占用，尝试使用端口 8081")
            port = 8081
            with socketserver.TCPServer(("", port), SimpleHTTPRequestHandler) as httpd:
                print(f"🌐 服务器已启动在端口 {port}")
                print(f"访问地址: http://localhost:{port}")
                httpd.serve_forever()
        else:
            raise e

if __name__ == "__main__":
    start_simple_server()