from django.shortcuts import render,redirect
from .models import Board
from .forms import BoardForm
from user.models import User
from django.http import Http404

from django.core.paginator import Paginator



# Create your views here.
def board_list(request):
    #모든 게시글을 조회
    all_boards = Board.objects.all().order_by('-id') #-가 붙으면 내림차순
    #boards에 사용자들이 작성한 글 list로 들어와있음
    #QueryString으로 들어오는 page Parameter 받기
    page = int(request.GET.get("page",1)) #page param이 없으면 1페이지를 받겠다.

    paginator = Paginator(all_boards, 3) #all_boards를 3개씩 쪼갠다.
    
    boards = paginator.get_page(page)#board에서 몇페이지 볼건지 들어옴

    return render(request, 'board_list.html', {"boards":boards})

def board_write(request):
    if not request.session.get("user"): #로그인 안했으면 유저의 로그인으로 가라
        return redirect("/user/login")


    if request.method == 'POST':
        form = BoardForm(request.POST)

        if form.is_valid():
            #새로운 Board모델 객체 생성
            board = Board()
            board.title = form.cleaned_data['title']
            board.contents = form.cleaned_data['contents']

            #writer에 저장해야 할 것은? pk가 아닌, User 객체를 저장
            #1. user의 pk 가져오기
            user_pk = request.session.get('user')
            #2. user_pk를 이용해서 User 모델 객체 가져오기
            writer = User.objects.get(pk=user_pk)

            board.writer = writer

            #저장
            board.save()

            return redirect("/board/list")


    else:
        form = BoardForm()
    return render(request, "board_write.html",{"form":form})
#board폼 가져와서 폼만들어서 전달 

def board_detail(request, pk):
    # pk에 해당하는 글 가져오기
    try:
        board = Board.objects.get(pk=pk)
    except Board.DoesNotExist:
        raise Http404("게시글을 찾을 수 없습니다.") 
    return render(request, 'board_detail.html', {'board': board})

