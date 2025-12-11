// 主JavaScript文件 - 增强网站功能

// 页面加载完成后执行
document.addEventListener('DOMContentLoaded', function() {
    console.log('网站已加载完成');
    
    // 初始化所有功能
    initNavigation();
    initSmoothScrolling();
    initServiceCards();
    initContactForm();
    initScrollEffects();
    
    // 添加加载动画
    addFadeInAnimations();
    
    // 检查LOGO加载状态
    checkLogoLoading();
});

// 导航功能初始化
function initNavigation() {
    const navbar = document.querySelector('.navbar');
    const navLinks = document.querySelectorAll('.nav-menu a');
    
    // 滚动时导航栏样式变化
    window.addEventListener('scroll', function() {
        if (window.scrollY > 100) {
            navbar.style.background = 'rgba(255, 255, 255, 0.95)';
            navbar.style.backdropFilter = 'blur(10px)';
        } else {
            navbar.style.background = '#fff';
            navbar.style.backdropFilter = 'none';
        }
    });
    
    // 导航链接点击效果
    navLinks.forEach(link => {
        link.addEventListener('click', function(e) {
            // 移除所有active类
            navLinks.forEach(l => l.classList.remove('active'));
            // 添加active类到当前链接
            this.classList.add('active');
        });
    });
}

// 平滑滚动功能
function initSmoothScrolling() {
    const links = document.querySelectorAll('a[href^="#"]');
    
    links.forEach(link => {
        link.addEventListener('click', function(e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                const offsetTop = targetElement.offsetTop - 70; // 减去导航栏高度
                
                window.scrollTo({
                    top: offsetTop,
                    behavior: 'smooth'
                });
            }
        });
    });
}

// 服务卡片交互效果
function initServiceCards() {
    const serviceCards = document.querySelectorAll('.service-card');
    
    serviceCards.forEach(card => {
        card.addEventListener('mouseenter', function() {
            this.style.transform = 'translateY(-10px)';
        });
        
        card.addEventListener('mouseleave', function() {
            this.style.transform = 'translateY(0)';
        });
        
        // 点击卡片跳转
        card.addEventListener('click', function() {
            const link = this.querySelector('.service-link');
            if (link) {
                window.location.href = link.href;
            }
        });
    });
}

// 联系表单处理
function initContactForm() {
    const contactForm = document.querySelector('.contact-form form');
    
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // 获取表单数据
            const formData = new FormData(this);
            const name = formData.get('name') || this.querySelector('input[type="text"]').value;
            const phone = formData.get('phone') || this.querySelector('input[type="tel"]').value;
            const message = formData.get('message') || this.querySelector('textarea').value;
            
            // 简单验证
            if (!name || !phone || !message) {
                showAlert('请填写所有必填字段', 'error');
                return;
            }
            
            // 模拟提交成功
            showAlert('咨询提交成功！我们会尽快联系您', 'success');
            this.reset();
        });
    }
}

// 滚动效果
function initScrollEffects() {
    const sections = document.querySelectorAll('section');
    
    const observerOptions = {
        root: null,
        rootMargin: '0px',
        threshold: 0.1
    };
    
    const observer = new IntersectionObserver(function(entries) {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('fade-in');
            }
        });
    }, observerOptions);
    
    sections.forEach(section => {
        observer.observe(section);
    });
}

// 添加淡入动画
function addFadeInAnimations() {
    const elements = document.querySelectorAll('.service-card, .about-content, .contact-content');
    
    elements.forEach((element, index) => {
        element.style.animationDelay = `${index * 0.2}s`;
        element.classList.add('fade-in');
    });
}

// 检查LOGO加载状态
function checkLogoLoading() {
    const logo = document.querySelector('.nav-logo img');
    
    if (logo) {
        logo.addEventListener('load', function() {
            console.log('LOGO图片加载成功');
        });
        
        logo.addEventListener('error', function() {
            console.warn('LOGO图片加载失败，使用备用方案');
            // 创建文字LOGO作为备用
            this.style.display = 'none';
            const textLogo = document.createElement('div');
            textLogo.textContent = '财';
            textLogo.style.cssText = 'width: 40px; height: 40px; background: #667eea; color: white; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-size: 1.2rem; font-weight: bold;';
            this.parentNode.insertBefore(textLogo, this);
        });
    }
}

// 显示提示消息
function showAlert(message, type) {
    // 移除现有提示
    const existingAlert = document.querySelector('.custom-alert');
    if (existingAlert) {
        existingAlert.remove();
    }
    
    // 创建新提示
    const alert = document.createElement('div');
    alert.className = `custom-alert ${type}`;
    alert.textContent = message;
    alert.style.cssText = `
        position: fixed;
        top: 100px;
        right: 20px;
        padding: 15px 20px;
        border-radius: 5px;
        color: white;
        font-weight: 500;
        z-index: 10000;
        animation: slideIn 0.3s ease;
        ${type === 'success' ? 'background: #28a745;' : 'background: #dc3545;'}
    `;
    
    document.body.appendChild(alert);
    
    // 3秒后自动移除
    setTimeout(() => {
        alert.style.animation = 'slideOut 0.3s ease';
        setTimeout(() => alert.remove(), 300);
    }, 3000);
}

// 添加动画样式
const style = document.createElement('style');
style.textContent = `
    @keyframes slideIn {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }
    
    @keyframes slideOut {
        from { transform: translateX(0); opacity: 1; }
        to { transform: translateX(100%); opacity: 0; }
    }
    
    .nav-menu a.active {
        color: #667eea !important;
        font-weight: 600;
    }
    
    .service-card {
        cursor: pointer;
    }
`;

document.head.appendChild(style);

// 页面性能优化
window.addEventListener('load', function() {
    // 预加载重要资源
    const importantImages = ['images/LOGO图标.jpg'];
    importantImages.forEach(src => {
        const img = new Image();
        img.src = src;
    });
    
    console.log('所有资源加载完成');
});

// 错误处理
window.addEventListener('error', function(e) {
    console.error('页面发生错误:', e.error);
});