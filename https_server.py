#!/usr/bin/env python3
"""
HTTPS服务器配置
为本地开发环境提供HTTPS支持
"""

import http.server
import ssl
import os
import sys

# 生成自签名证书（仅用于开发环境）
def generate_self_signed_cert():
    """生成自签名SSL证书"""
    cert_file = "localhost.crt"
    key_file = "localhost.key"
    
    if not os.path.exists(cert_file):
        # 使用OpenSSL生成证书（需要安装OpenSSL）
        print("生成自签名SSL证书...")
        os.system(f'openssl req -x509 -newkey rsa:4096 -keyout {key_file} -out {cert_file} -days 365 -nodes -subj "/C=CN/ST=Guangdong/L=Shenzhen/O=FinanceTax/CN=localhost"')
    
    return cert_file, key_file

class HTTPSRequestHandler(http.server.SimpleHTTPRequestHandler):
    def do_GET(self):
        # 强制HTTPS重定向（可选）
        if self.headers.get('X-Forwarded-Proto') == 'http':
            self.send_response(301)
            self.send_header('Location', f'https://{self.headers["Host"]}{self.path}')
            self.end_headers()
            return
        
        # 添加安全头
        self.send_header('Strict-Transport-Security', 'max-age=31536000; includeSubDomains')
        self.send_header('X-Content-Type-Options', 'nosniff')
        self.send_header('X-Frame-Options', 'SAMEORIGIN')
        self.send_header('X-XSS-Protection', '1; mode=block')
        
        super().do_GET()

def run_https_server(port=443):
    """启动HTTPS服务器"""
    try:
        # 切换到网站目录
        os.chdir(os.path.dirname(os.path.abspath(__file__)))
        
        # 生成证书
        cert_file, key_file = generate_self_signed_cert()
        
        # 创建HTTP服务器
        server_address = ('0.0.0.0', port)
        httpd = http.server.HTTPServer(server_address, HTTPSRequestHandler)
        
        # 包装为HTTPS
        httpd.socket = ssl.wrap_socket(
            httpd.socket,
            keyfile=key_file,
            certfile=cert_file,
            server_side=True
        )
        
        print(f"HTTPS服务器启动在 https://0.0.0.0:{port}/")
        print(f"可以通过以下地址访问：")
        print(f"- https://www.0slm.com.cn/")
        print(f"- https://www.ninsuna.com/")
        print("注意：首次访问需要接受安全证书")
        
        httpd.serve_forever()
        
    except Exception as e:
        print(f"启动HTTPS服务器失败: {e}")
        print("备用方案：使用HTTP服务器")
        os.system("python -m http.server 80 --bind 0.0.0.0")

if __name__ == "__main__":
    run_https_server()