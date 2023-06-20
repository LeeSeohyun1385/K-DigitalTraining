"""my_community URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path , include

from .views import home
#교재 user에서 갖고오는거 X

urlpatterns = [
    path('admin/', admin.site.urls),
    #include('user.urls') : user App에 있는 urls.py에 urlpatterns에 등록되어 있는 모든 url을 한꺼번에 포함(등록)
    path('user/', include('user.urls')),
    path('board/', include('board.urls')),
    path('',home)
]
#메인프로젝트의 url
#user/ : 사용자가 user을 요청하면 사용할 수 있게 할 것이다.

