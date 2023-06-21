#from django.http import HttpResponse
from user.models import User
from django.shortcuts import render

def home(request):
    #세션에 저장된 로그인한 사용자의 pk 꺼내기
    uid = request.session.get("user")
    
    if uid:
        #모델에서 uid에 해당하는 사용자 정보 가져오기
        user_model = User.objects.get(pk=uid) #SELECT * FROM  tb_user WHERE id=uid #pk : id
        #return HttpResponse(f"{user.user_id} / {user.useremail}") #session에 있는 사용자 정보 조회
        return render(request, "home.html", {"user_model": user_model })

    #return HttpResponse("Home!")
    return render(request, "home.html")