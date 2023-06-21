from django.contrib import admin
from .models import User

# Register your models here.
#관리자 페이지와 모델 연결
class UserAdmin(admin.ModelAdmin):
    list_display = ('user_id', 'useremail', 'registered_dttm')

admin.site.register(User, UserAdmin)
