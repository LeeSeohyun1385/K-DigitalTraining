User

- User 정보는 unique
- User:A,B,C - pk:1,2,3

<게시글>

- unique
- pk : 글 번호 / 내용, 제목
- user.fk : 누가 글 작성했는지 알기 위해 User 테이블의 pk 참조

\*Foreign Key(참조키, 외래키)

- 참조 무결성 제약 조건 (Relation Integrity)
- MySQL->RDBMS : Table끼리 관계가 있음
- 키에 중복 가능
- 반드시 참조하는 테이블에 pk에 해당하는 Data가 있어야한다.
- pk:fk ---> 1:N 관계

on_delete

- on : event(사건) / ~할 때
- 삭제할 때
- writer(user.User)가 삭제 될 때
- CASCADE
  A유저가 탈퇴했을 때 게시글에 탈퇴한 회원의 게시글 존재 : 참조무결성 위반 <-- 이에 대한 처리
- PROTECT
  탈퇴한 유저의 글 fk가 NULL값

{"boards":boards} -> attribute

암호화가 되어있는 user로 게시물 작성하는게 좋음

model에서 **str**에 제목만 뽑았기 때문에 boards에 제목만 보임

쿼리셋(QS): 조회한 결과물 - 쿼리셋 타입의 리스트 / 리스트 요소는 하나의 로우(커서)

- 커서: 순서대로 데이터를 뽑아옴
- 커서를 통해 데이터를 순차적으로 조회

{"board":boards}
board라는 이름으로 board리스트를 받아왔다.

{% for board in boards %}
{% endfor %}

- 5개 반복해서 꺼냄

{{ board.id }}
관리자 페이지에서 입력한 것이 페이지에 잘 표시가 됨

/board/list/ 에 잘 보여짐

**str**: 어떠한 객체를 텍스트 형태로 표현할때 어떻게 표현할 것인지 오버라이딩
user_id로 나오게 오버라이딩해서 id가 보임
{{ board.writer.user_id }}가 정석 but 오버라이딩 했기 때문에 id객체로 표현됨

{% ifequel -> if ~~ == ~ %}

views.py -> def boardwrite
사용자가 입력한 폼을 저장
사용자가 제목, 내용 잘 입력 했으면

cleaned data ; 유혀성검증을 정상적으로 통과한데이터
통과한 데이터가 들어있음

\*어제내용
session에 user이라는 이름으로 uid 저장해놓음 -> 사용자의 pk를 들고있음

\*\*def board_write(request): 몰라

#writer에 저장해야 할 것은? pk가 아닌, User 객체를 저장
세션에서 유저아이디 꺼내고 유저아이디 조회
session에 user라는 이름으로 저장해뒀으니 이름 그대로 가져옴

def board_write(request):
사용자가 입력한 글 가져와서 유효성 검사 통과하면
데이터베이스에 저장한다.
title컨텐츠에 넣어줫고
롸이터에 저장(객체를 집어넣어 관리)
pk를 로그인한 사용자의 프라이머리키를 가져와서 조회를 했고
유저 객체를 롸이터에 넣어감
저장
정상적으로 끝나면 보드에 리스트로 돌아감

GET 방식

- QueryString
- pass parameter
  - view -> pk안에 글번호 들어옴
  - <int:pk> view pk의 이름, 정수형으로 받아올 수 있게 세팅
  - <pk> 문자열 형식

사용자가 보낸 pk 로 db에서 조회
attribute 전달

django model data delete/update 검색해서 직접 해보기.

예외처리
return

- 1. 반환
- 2. 함수 즉시 종료
- error만 추가되고 유효성 검사를 끝냄. 밑에 잇는거 안하겠따.

get방식 : 404not found에러가 주로 뜸
page not found

raise
오류를 강제로 발생시킴

로그아웃을 했을 때 board/write에 못들어오게 하기

---

페이지네이션
view/board_list
QS방식으로

클라이언트가 서버에게 보내는 것은 다 문자열로 들어옴
문자열로 들어오는 데이터를 정수로 바꿔줌

모든데이터(all_boards) 10개 ->3개씩 :1페이지에 3개씩 : 총페이지수 4개

쿼리스트링
?로 시작
?page=3

onclick="location.href='/user/login'"
클릭했을 때 사용자(client)의 (주소로)위치를 옮겨줌

로그인한 상태에서 로그인 버튼 안보이개ㅔ - 조건문

pk가 들어옴 -> {{board.id}}

board_list.html

---

0327 새로운 프로젝트
\*Up Casting 1.목적
2.up casting 목적파악
-"자식은 부모다" 대입 후 말이 되면 상속

\*클래스: 명사 , 메소드: 동사 , 변수: 명사, 상태

\*유효성검증
clean메소드 오버라이딩
비밀번호 같은지 다른지 유효성검증을 추가적으로 수행

\*유효성 검사에 통과하지 못할 때 이동할 경로 (view)

\*Form에서 유효성검사할 수 있게 구성(Form에서 검증, viwe에서 처리(응답만 해줌))
요청에 대한 입력값을 검증
검증 결과 : 검증성공, 검증실패

세션
로그인정보가 정상적으로 들어왔을 때 정보 저장
view에서 form_valid(검증성공)메소드 호출
사용자가 입력한 form이 성공적인 유효성 검증을 마쳤다.

\*view : client가 요청했을 때 일을 처리하는 역할
요청에 대한 결과 보여줌 - view에서 유효성 검증 등의 임무X

로그인 성공시 self.user_id(멤버변수) 를 이용해 user.id(pk) 만듦

\*상품목록
사용자 입력 받기 - form view 필요
상품목록 나열 - list view 필요

\*template_name으로 나열한거 보여줌

product_list 라는 템플릿으로 product리스트가 들어감, object_list라는 변수명으로 들어감
object_list : 따로설정X 알아서 설정하는 것

\*humanize 필터
사람들이 일반적으로 사용하는 문자열 필터

\*base64인코딩
이미지->text로 변환-> 저장

\*OrderForm(froms.Form)
view가 form에게 request정보를 저장 -> form도 request 정보를 받음
form에는 request 정보가 없음

##RESTful API

\*상태 전송
-> 처리결과 -성공 -실패
-> Data
서버 -> 클라이언트
-page -Data

\*상태를 전송하는 방식
페이지를 보낼때, 데이터를 보낼때 특징이 다름
HTTP = 비연결성 통신 :client와 server연결이 끊어짐/ 클라이언트가 서버에게 요청해서 응답받자마자 클라이언트의 소유되고 연결 끊어진 상태

HTML:비연결 통신방식/ 동기 통신방식
Data(Jason,XML) :연결 통신방식 / 비동기 통신방식

동기 : 대기 (비유-무전기)
비동기 : 대기x (전화)

CSR(client side rendering) -> REST 필요
SSR(server side rendering)

REST란?
자원(DB)
CRUD를 수행하기 위해서 HTTP메소드를 이용해서 Data를 어떻게 할지 정의
how? CRUD
무엇을? DB

명사만 씀

jason 키 : 문자열만 올 수 있음
jSONArray

Django serializer
serializer : 직렬화
데이터 직렬화, 역직렬화 다룰것

serializers.py
ProductSerializer
product모델의 구조를 jsom구조로 만들어줌

새로운 view만들어줌 api_views.py
template 없이 데이터만 주고받는 view

API의 결과물 ->json array
'http://127.0.0.1:8000/api/products'

데이터 조회
'http://127.0.0.1:8000/api/products/'

\*비동기 방식, 연결
마우스를 올렸을때 데이터에 대한 정보 조회
javascript 로 구현
script tag 안쪽에 자바스크립트 작성
함수의 범위 구분 {} <- python에서 :

비동식 통신의 요청 함수: fetch
fetch의 결과 :then함수 - "fetch를 하고 나서" -> 데이터가 들어옴
response라는 것을 매개변수로 받는 함수가 들어온 것

마우스가 위로 올라 왔을 때 : event -> productmouseover을 실행하겠다.
-> 앵커태그
on -> event : ~했을 때

const코드
response를 받아오고 json으로 받아오고 json을 표시만 해줌
response객체를 json으로 바꾸고 나서 json데이터를 팝업창에 뿌려준다.
