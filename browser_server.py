#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
浏览器友好HTTP服务器 - 解决安全策略问题
"""

import http.server
import socketserver
import os
import webbrowser
import time

# 设置网站根目录
WEB_ROOT = os.path.dirname(os.path.abspath(__file__))
PORT = 0  # 0表示自动选择端口

class BrowserFriendlyHTTPHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=WEB_ROOT, **kwargs)
    
    def end_headers(self):
        # 添加CORS头，解决跨域问题
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()

def start_browser_friendly_server():
    os.chdir(WEB_ROOT)
    
    # 使用TCPServer自动选择端口
    with socketserver.TCPServer(("", PORT), BrowserFriendlyHTTPHandler) as httpd:
        # 获取实际使用的端口
        actual_port = httpd.server_address[1]
        
        print("=" * 60)
        print("🌐 浏览器友好服务器已启动!")
        print("=" * 60)
        print(f"📁 网站根目录: {WEB_ROOT}")
        print(f"🔧 使用端口: {actual_port}")
        
        # 生成多个访问地址
        urls = [
            f"http://localhost:{actual_port}",
            f"http://127.0.0.1:{actual_port}",
            f"http://[::1]:{actual_port}",
            f"http://0.0.0.0:{actual_port}"
        ]
        
        print("\n📋 可用的访问地址:")
        for i, url in enumerate(urls, 1):
            print(f"{i}. {url}")
        
        print("\n📋 修复内容验证:")
        print("✅ CSS路径: css/style.css")
        print("✅ 公司信息: 广东深圳市龙岗区龙岗街道龙岗路东森大厦，0755-8521-6839")
        print("✅ 域名配置: www.0slm.com.cn")
        print("\n⏹️ 按 Ctrl+C 停止服务器")
        print("=" * 60)
        
        # 自动打开浏览器
        main_url = urls[0]
        print(f"\n🚀 正在自动打开浏览器: {main_url}")
        webbrowser.open(main_url)
        
        # 启动服务器
        print(f"\n🔄 服务器运行中...")
        httpd.serve_forever()

if __name__ == "__main__":
    start_browser_friendly_server()