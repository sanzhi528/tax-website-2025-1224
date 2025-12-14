#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
网站功能测试脚本
用于验证网站各项功能是否正常工作
"""

import urllib.request
import json
import time
import os

def test_website_accessibility():
    """测试网站可访问性"""
    print("🔍 测试网站可访问性...")
    
    urls_to_test = [
        "http://localhost:62972",
        "http://127.0.0.1:62972"
    ]
    
    for url in urls_to_test:
        try:
            response = urllib.request.urlopen(url, timeout=10)
            if response.status == 200:
                print(f"✅ {url} - 访问成功 (状态码: {response.status})")
            else:
                print(f"⚠️ {url} - 访问异常 (状态码: {response.status})")
        except Exception as e:
            print(f"❌ {url} - 访问失败: {e}")
    
    print()

def test_file_accessibility():
    """测试关键文件可访问性"""
    print("📁 测试关键文件可访问性...")
    
    files_to_test = [
        "css/style.css",
        "js/main.js", 
        "images/LOGO图标.jpg"
    ]
    
    base_url = "http://localhost:62972"
    
    for file_path in files_to_test:
        url = f"{base_url}/{file_path}"
        try:
            response = urllib.request.urlopen(url, timeout=10)
            if response.status == 200:
                print(f"✅ {file_path} - 加载成功")
            else:
                print(f"⚠️ {file_path} - 加载异常 (状态码: {response.status})")
        except Exception as e:
            print(f"❌ {file_path} - 加载失败: {e}")
    
    print()

def test_responsive_design():
    """测试响应式设计"""
    print("📱 测试响应式设计...")
    
    # 检查CSS文件是否包含响应式媒体查询
    css_file = "css/style.css"
    if os.path.exists(css_file):
        with open(css_file, 'r', encoding='utf-8') as f:
            css_content = f.read()
            
        responsive_checks = [
            ("媒体查询", "@media"),
            ("Flex布局", "display: flex"),
            ("Grid布局", "grid-template-columns"),
            ("移动端适配", "max-width: 768px")
        ]
        
        for check_name, check_string in responsive_checks:
            if check_string in css_content:
                print(f"✅ {check_name} - 已实现")
            else:
                print(f"⚠️ {check_name} - 未找到")
    else:
        print("❌ CSS文件不存在")
    
    print()

def test_company_info():
    """测试公司信息显示"""
    print("🏢 测试公司信息显示...")
    
    # 检查HTML文件中的公司信息
    html_file = "index.html"
    if os.path.exists(html_file):
        with open(html_file, 'r', encoding='utf-8') as f:
            html_content = f.read()
        
        info_checks = [
            ("公司名称", "财务税务代理公司"),
            ("联系电话", "0755-8521-6839"),
            ("公司地址", "广东深圳市龙岗区龙岗街道龙岗路东森大厦"),
            ("LOGO图片", "images/LOGO图标.jpg"),
            ("导航菜单", "nav-menu"),
            ("服务项目", "services-grid")
        ]
        
        for info_name, info_string in info_checks:
            if info_string in html_content:
                print(f"✅ {info_name} - 存在")
            else:
                print(f"❌ {info_name} - 缺失")
    else:
        print("❌ HTML文件不存在")
    
    print()

def generate_report():
    """生成测试报告"""
    print("=" * 50)
    print("📊 网站功能测试报告")
    print("=" * 50)
    print()
    
    test_website_accessibility()
    test_file_accessibility()
    test_responsive_design()
    test_company_info()
    
    print("=" * 50)
    print("🎯 测试完成！")
    print("💡 提示：请确保服务器正在运行 (端口 62972)")
    print("🌐 访问地址: http://localhost:62972")
    print("=" * 50)

if __name__ == "__main__":
    generate_report()