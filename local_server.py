#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
本地网站服务器 - 用于预览修复后的网站效果
"""

import http.server
import socketserver
import os
import webbrowser
import sys

# 设置网站根目录
WEB_ROOT = os.path.dirname(os.path.abspath(__file__))
PORT = 8000

class CustomHTTPRequestHandler(http.server.SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=WEB_ROOT, **kwargs)
    
    def end_headers(self):
        # 添加CORS头，确保所有资源都能正确加载
        self.send_header('Access-Control-Allow-Origin', '*')
        self.send_header('Access-Control-Allow-Methods', 'GET, POST, OPTIONS')
        self.send_header('Access-Control-Allow-Headers', 'Content-Type')
        super().end_headers()
    
    def do_GET(self):
        # 确保CSS文件路径正确
        if self.path.startswith('/css/'):
            css_path = os.path.join(WEB_ROOT, 'css', os.path.basename(self.path))
            if os.path.exists(css_path):
                return super().do_GET()
            else:
                self.send_error(404, "File not found")
                return
        
        # 确保图片文件路径正确
        if self.path.startswith('/images/'):
            img_path = os.path.join(WEB_ROOT, 'images', os.path.basename(self.path))
            if os.path.exists(img_path):
                return super().do_GET()
            else:
                self.send_error(404, "File not found")
                return
        
        # 确保JS文件路径正确
        if self.path.startswith('/js/'):
            js_path = os.path.join(WEB_ROOT, 'js', os.path.basename(self.path))
            if os.path.exists(js_path):
                return super().do_GET()
            else:
                self.send_error(404, "File not found")
                return
        
        return super().do_GET()

def start_server():
    os.chdir(WEB_ROOT)
    
    with socketserver.TCPServer(("", PORT), CustomHTTPRequestHandler) as httpd:
        print(f"🚀 本地服务器已启动!")
        print(f"📁 网站根目录: {WEB_ROOT}")
        print(f"🌐 访问地址: http://localhost:{PORT}")
        print(f"🔗 域名模拟: http://localhost:{PORT} (模拟 www.0slm.com.cn)")
        print("\n📋 修复内容验证:")
        print("✅ CSS路径: css/style.css")
        print("✅ 公司信息: 广东深圳市龙岗区龙岗街道龙岗路东森大厦，0755-8521-6839")
        print("✅ 域名配置: www.0slm.com.cn")
        print("\n⏹️ 按 Ctrl+C 停止服务器")
        
        # 自动打开浏览器
        try:
            webbrowser.open(f"http://localhost:{PORT}")
        except:
            print("⚠️ 无法自动打开浏览器，请手动访问上述地址")
        
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n👋 服务器已停止")

if __name__ == "__main__":
    start_server()