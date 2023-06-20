from django import forms
from .models import User
from django.contrib.auth.hashers import check_password

class LoginForm(forms.Form): #사용자 입력을 받아 전달해줌 #Form클래스
    user_id = forms.CharField(max_length=64, 
                              label="사용자 아이디",
                              error_messages = {"required":"아이디를 입력해 주세요"})
    
    password = forms.CharField(max_length=64, 
                               label = "비밀번호", 
                               widget = forms.PasswordInput,
                               error_messages={"required":"비밀번호를 입력해 주세요"}
                               )
    #user_id ,password는 input tag / html구조를 클래스 만든다고 생각 
    #widget : input 태그의 타입

    #오버라이딩(+a , 재정의, 기능 추가)
    #로그인 검사
    def clean(self):
        #cleaned_data : 유효성 검증을 통과한 데이터
        #super().clean():부모클래스의 유효성 검증이된 데이터 받아오기
        cleaned_data = super().clean() #변수명 고정

        user_id = cleaned_data.get("user_id")
        password = cleaned_data.get("password")

        #"", None, 등이 들어오는 것 방지 위한 코드
        if user_id and password: #제대로된 값이 들어 왔다면
            try:
                user = User.objects.get(user_id = user_id)
            except User.DoesNotExist:
                self.add_error("user_id", "아이디가 없습니다.")
                return
            except User.MultipleObjectsReturned:
                self.add_error("user_id", "중복된 아이디 입니다. 다시 회원가입하세요")
                return 

            if not check_password(password, user.password): #유효하지 못한 패스워드 #db의 데이터와 입력 비밀번호가 틀리면 error
                self.add_error("password", "비밀번호가 틀렸습니다.")
            else:
                # 여기까지 온 경우
                #1. 클라이언트가 아이디와 비밀번호를 잘 입력했다.(기본 유효성 검증 - 부모클래스가 해줌)
                #2. 클라이언트가 입력한 아이디에 해당하는 사용자가 있고, 비밀번호도 맞다. (오버라이딩으로 구현)
                self.uid = user.id #pk를 저장해줌 #self는 login form 객체 #폼에다 pk저장
                #여기까지 유효성검증 + 오버라이딩 다 통과
                
                 

                
                
            

