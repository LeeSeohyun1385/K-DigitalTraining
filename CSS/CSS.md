# CSS

> Cascade Style Sheet
>
> Cascade : 부모 엘리먼트를 스타일링하면 그 성질이 자손에게 정해지는 성질

## 1. 속성

- id
  - 전체 문서에서 단 하나만 부여
  - 중복된 id값 존재하지 않음(오류나지 않고 랜더링됨)
- class
  - 중복이 가능하게 부여 가능
- name
  - form

## 2. 선택자

> style sheet는 head에서 작업

### 2-1. Tag 선택자

- 태그명{속성}
- getElementsByTag

### 2-2. id 선택자

- #id명{속성}
- getElementById

### 2-3. class 선택자

- .클래스명{속성}
- getElementsByClass
- 여러 클래스 동시 선택 가능
- 태그명.클래스명
  - 태그 중 특정 클래스만 선택
- +) :hover 속성 : 마우스 올렸을 때

### 2-4. 관계 선택자

- 부모, 형제, 자식, 자손
  - CSS에서는 자식, 자손 위주

#### 2-4-1. 자식 선택자★

- 부모 > 자식
- .부모클래스명 > .자식클래스명 {속성}

#### 2-4-2. 자손 선택자

- 부모 자손
- .부모클래스명 .자식클래스명 {속성}

### 2-5. 속성 선택자(attribute selector)

- [속성명="속성값"]
  - 태그명[속성명="속성값"]

### 2-6. 가상 선택자

> 있을 수도 있고, 없을 수도 있는데, 있으면 선택

#### 2-6-1. not selector

- 선택자1:not(선택자2)
  - 선택자1 중에 선택자2가 "아닌 것"
  - cs1:not(.cs2) {속성}

#### 2-6-2. :nth-child

- .cs1:nth-child(n){속성명}
  - n : 숫자
  - n 번째 요소(Element)
  - 짝수 : 2n , 홀수 : 2n-1