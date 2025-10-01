# Smart Library Team Project




<p align="center">
<img width="720" height="405" alt="SMARTLIBRARY" src="https://github.com/user-attachments/assets/63deeadf-52b8-4df6-b396-f53ec3372cd0" />  
</p>


-----------------------------------------------------------------------------------------------------------------

<br>

## 📚 프로젝트 소개

**스마트 도서관**은 공공 도서관 이용자에게 도서의 정보와 함께 대출 가능 여부를 실시간으로 제공하고, 도서관 내 스터디룸 예약 서비스까지 함께 제공하는 웹 사이트입니다.   
도서관까지 직접 갈 필요 없이 소장 도서 및 한 달 이내 출간 예정 도서를 확인하고, 원하는 날 스터디룸을 예약하고, 공지 사항 게시판에서 도서관의 소식을 듣고, 건의 사항 게시판을 통해 도서관 관리자에게 더 좋은 의견을 제시하세요!


## 🔗 Link
* **Github Repository** : https://github.com/ehxhfl921/smart_library
* **Presentation** : https://youtu.be/yucgrZen3zY

<br>

-----------------------------------------------------------------------------------------------------------------

<br>

## 📖 주요 기능

* **메인 페이지**   
  도서 검색 페이지로 이어지는 소장 도서 검색창, 이달의 도서 슬라이드 카드, 도서관 이용 안내   

* **회원 가입**   
  유효성 검사 적용, 아이디 중복 검사, 이메일 인증 후 가입   
  
* **아이디 찾기**   
  가입 시 입력한 이름과 이메일로 **이메일 인증 후** 아이디 찾기   
  
* **비밀번호 찾기**   
  가입 시 입력한 아이디와 이메일로 **이메일 인증 후** 비밀번호 재설정   
  
* **스터디룸 예약**   
  원하는 날짜, 원하는 스터디룸 예약 신청 - **관리자 승인 후** 이용   
  
* **소장 도서 검색**   
  제목 혹은 저자로 검색 후 도서 제목, 저자, 발행 기관, 발행일, 대출 가능 여부 확인   
  
* **출간 예정 도서**   
  <출판유통통합전산망> 기준 한 달 이내 출간 예정 도서 목록 확인   
  \- 도서 클릭 시 [외부 사이트](https://bnk.kpipa.or.kr/home/v3/addition/adiPromoUpcomingBooktypeList) 로 이동하여 자세한 도서 정보 확인   
  
* **공지 사항 게시판**   
  관리자가 작성한 도서관 공지 사항 확인   
  
* **건의 사항 게시판**   
  **로그인 한** 일반 사용자라면 누구나 건의 사항 작성, 관리자와 댓글로 소통   
  *-관리자와 게시글 작성자 본인만 접근 가능한 프라이빗한 페이지*   
     
* **내 서재**   
  \- 로그인 사용자 전용 페이지   
  + **도서 대출 현황**   
  로그인 사용자의 도서 대출 현황   
  + **스터디룸 예약 현황**   
  로그인 사용자의 스터디룸 예약 현황 *-승인 혹은 대기 중인 예약건 예약 취소 기능*
  + **작성한 건의 사항**   
  로그인 사용자가 작성한 건의 사항 목록 *-클릭 시 해당 건의 사항 상세 페이지로 이동*   

* **운영/관리**   
  \- 관리자 전용 운영 및 관리 페이지   
  + **회원 관리**   
    회원 정보 열람/수정/삭제
  + **도서 관리**   
    도서 정보 열람/수정/삭제, 이달의 도서로 등록/삭제, 신규 도서 등록
  + **스터디룸 예약 관리**   
    스터디룸 예약 내역 확인, 예약 승인/거절/취소
  + **도서관 정보 관리**   
    도서관 이름, 전화번호, 위치 및 휴관일 정보 관리

<br>

-----------------------------------------------------------------------------------------------------------------

<br>

## ⚙ 개발 환경   

<div align="center">
<br>
<img src="https://img.shields.io/badge/java-%23ED8B00.svg?style=for-the-badge&logo=openjdk&logoColor=white"> <img src="https://img.shields.io/badge/python-3776AB?style=for-the-badge&logo=python&logoColor=white"> <img src="https://img.shields.io/badge/html5-E34F26?style=for-the-badge&logo=html5&logoColor=white"> <img src="https://img.shields.io/badge/css3-1572B6?style=for-the-badge&logo=css&logoColor=white">
<img src="https://img.shields.io/badge/javascript-F7DF1E?style=for-the-badge&logo=javascript&logoColor=black"> <br>
<img src="https://img.shields.io/badge/oracle-F80000?style=for-the-badge&logo=oracle&logoColor=white"> <img src="https://img.shields.io/badge/spring-6DB33F?style=for-the-badge&logo=spring&logoColor=white"> <img src="https://img.shields.io/badge/apachemaven-C71A36.svg?style=for-the-badge&logo=apachemaven&logoColor=white"> <img src="https://img.shields.io/badge/apache%20tomcat-%23F8DC75.svg?style=for-the-badge&logo=apache-tomcat&logoColor=black"> <img src="https://img.shields.io/badge/Visual%20Studio%20Code-0078d7.svg?style=for-the-badge&logo=visual-studio-code&logoColor=white"> <img src="https://img.shields.io/badge/git-F05032?style=for-the-badge&logo=git&logoColor=white"> 
<br><br>
</div>

### 📒 Language & Framework / Library
  * Language :   
    * Java 11
  * Framework:   
    * Spring Framework v.5.3.39
    * Mybatis v.3.5.19
  * Library :   
    * JSTL v.1.2
    * Lombok v.1.18.38
    * HikariCP v.7.0.2
    * Jackson v.2.19.2
    * Javax.mail v.1.6.2
    * Commons-fileupload v.1.6.0
    * flatpickr v.4

### 📗 IDE / Development Tools
  * Spring Tool Suite 3 (based on Eclipse)
  * Visual Studio Code
  * Git
    
### 📘 Database
  * Oracle Database

### 📕 Server
  * Apache Tomcat v.9.0.108
  
<br>

-----------------------------------------------------------------------------------------------------------------

<br>

## 🗃 프로젝트 구조
```
📦smart_library
 ┣ 📂src/📂main/📂java/📂net/📂koreate/
 ┃ ┣ 📂board/                          # 공지 사항, 건의 사항 게시판
 ┃ ┣ 📂book/                           # 도서
 ┃ ┣ 📂common/                         # 공통 (홈 컨트롤러, 컨트롤러 어드바이스, 인터셉터, 유틸리티)
 ┃ ┣ 📂library/                        # 도서관 정보
 ┃ ┣ 📂room/                           # 스터디룸
 ┃ ┗ 📂user/                           # 회원
 ┣ 📂src/📂main/📂resources/📂prop/  # 설정 파일
 ┃ ┣ 📜db.properties
 ┃ ┗ 📜mail.properties
 ┣ 📂src/📂main/📂webapp/               
 ┃ ┣ 📂resources/           # CSS, 이미지
 ┃ ┗ 📂WEB-INF/📂views/    # 뷰 페이지 
 ┗ 📜smart_library.sql     # 초기 DB 스키마
```

## 🧰 설치 및 실행

### ✔ 필수 요구 사항
* Java 11 (or newer)
* Apache Tomcat v.9.0.108
* Maven v.3.6.x (or newer)
* Oracle Database
* Your prefered IDE
  \- Spring Tool Suite(STS)

### ✔ 설정 변경
**1. DB 설정 변경**
```properties
# src/main/resources/prop/db.properties
# db.username=your_username
# db.password=your_password
db.driver=oracle.jdbc.driver.OracleDriver
db.url=jdbc:oracle:thin:@localhost:1521:xe
db.username=smart_library
db.password=1234
```

**2. 메일 발송 설정 변경**
```properties
# src/main/resources/prop/mail.properties
# gmail.username=your_gmail
# gmail.password=your_password
gmail.username=example@gmail.com
gmail.password=abcd efgh igkl mnop
```

**3. 이미지 경로 변경**
  1. BookController.java (파일 저장 경로)
  ```java
  // uploadPath = "your_upload_path";
  private String uploadPath = "C:/Users/사용자명/Desktop/SmartLibrary/cover";
  ```
  2. servlet-context.xml (웹 접근 경로 매핑)
  ```xml
  <!-- location="your_uploadFile_location" -->
  <resources mapping="/images/**" location="file:///C:/Users/사용자명/Desktop/SmartLibrary/cover/" />
  ```   

<br>

-----------------------------------------------------------------------------------------------------------------

<br>

## 📝 ERD

<img width="814" height="467" alt="FINAL_PROJECT" src="https://github.com/user-attachments/assets/f352a921-6462-4849-bca4-590849b4c722" />

## 💾 Tables
> **member** \- 회원 정보 테이블   
> **book** \- 도서 정보 테이블   
> **book_loan** \- 도서 대출 정보 테이블   
> **book_of_the_month** \- 이달의 도서 테이블   
> **studyroom** \- 스터디룸 정보 테이블   
> **studyroom_reservation** \- 스터디룸 예약 정보 테이블   
> **notice** \- 공지 사항 테이블   
> **suggestion** \- 건의 사항 테이블   
> **suggestion_reply** \- 건의 사항 댓글 테이블   
> **library_info** \- 도서관 정보 테이블   
> **upcoming_books** \- 출간 예정 도서 테이블   

<br>

-----------------------------------------------------------------------------------------------------------------


## 🧸 프로젝트 멤버

<table>
  <tr>
    <th width="100">담당자</th>
    <th>담당 기능</th>
  </tr>
  <tr>
    <td>⭐김도은</td>
    <td>프로젝트 설계(DB, Class, UI/UX etc.), 아이디 중복 체크, 아이디 찾기, 비밀번호 찾기, 이메일 발송, 이미지 업로드, 도서 검색, 스터디룸 예약, 공지 사항/건의 사항 상세 페이지 및 댓글 기능, 내 서재(도서 대출 현황/스터디룸 예약 현황), 관리자 - 도서 관리(도서 신규 등록/수정/삭제, 이달의 도서로 등록/삭제), 관리자 - 스터디룸 예약 관리(스터디룸 예약 승인/거절/취소), 관리자 - 도서관 정보 관리(도서관 정보 수정), 출간 예정 도서 데이터 수집(파이썬 크롤링), 개인정보처리방침 공개 페이지, 로그인 체크 및 권한 체크, 페이징 처리, 페이지별 버튼 노출 조건 분기</td>
  </tr>
  <tr>
    <td>&nbsp;&nbsp;&nbsp;김진주</td>
    <td>회원 가입(유효성 검사), 로그인, 로그아웃, 아이디 찾기, 비밀번호 찾기, 회원 정보 수정, 회원 탈퇴, 관리자 - 회원 관리(회원 정보 열람/수정/삭제), 스터디룸 예약, 관리자 - 스터디룸 예약 관리(스터디룸 예약 승인/거절/취소), 페이징 처리</td>
  </tr>
  <tr>
    <td>&nbsp;&nbsp;&nbsp;김효진</td>
    <td>공지 사항 목록/상세 페이지, 공지 사항 작성/수정/삭제, 건의 사항 목록/상세 페이지, 건의 사항 작성/수정/삭제, 내 서재(작성한 건의 사항), 출간 예정 도서 페이지, 페이징 처리</td>
  </tr>  
  <tr>
    <td>&nbsp;&nbsp;&nbsp;이동윤</td>
    <td>자료 조사</td>
  </tr>
  <tr>
    <td>&nbsp;&nbsp;&nbsp;조반석</td>
    <td>자료 조사</td>
  </tr>
  <tr>
    <td>&nbsp;&nbsp;&nbsp;하진이</td>
    <td>자료 조사</td>
  </tr>
</table>


-----------------------------------------------------------------------------------------------------------------

## 💌 연락처

* **김도은** : ✉ ehxhfl921@gmail.com    
* **김진주** : ✉ kpearl0416@gmail.com   
* **김효진** : ✉ djduebfu3747@gmail.com
* **이동윤** : ✉ -
* **조반석** : ✉ -
* **하진이** : ✉ -

-----------------------------------------------------------------------------------------------------------------
