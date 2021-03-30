## <사용 환경>
- Java JDK 1.8
- Mybatis 3.5 mybatis-spring
- HTML5/CSS3/JavaScript
- BootStrap 3
- J-Query(ajax), Spring Rest API
- Servlet/JSP Servlet 4.0
- Spring- framework(AOP, MVC)  v5.2.13
- Spring tx/ Spring security
- Oracle DatatBase 11g 기준(SQL/저장공간 구성)

Java 언어를 사용하여 MVC구조인 Spring으로 웹 사이트를 구현하였습니다. 필요한 데이터를 사용하기 위해서는 OracleDB로  MyBatis로 매핑을 하여 사용하였습니다.

## <스크린 샷 및 설명

- 회원가입
![image](https://user-images.githubusercontent.com/66732896/112924723-a151cf00-914b-11eb-85ce-d642ade15111.png)

-회원 가입과 동시에 사용자로써 권한이 주어지고 입력된 데이터들이 DB에 저장이 됩니다.

- 로그인
![image](https://user-images.githubusercontent.com/66732896/112925056-32c14100-914c-11eb-97ce-58ee051ac3aa.png)


-스프링 시큐리티를 이용 하였으며 사용자에 대해 권한이 인증이 된다면 로그인이 됩니다. 로그인시 db에 저장된 권한에 따라 사용 기능을 구분합니다.

- 마이 페이지
![image](https://user-images.githubusercontent.com/66732896/112925199-7156fb80-914c-11eb-99a2-085ca20e6409.png)

-본인일 경우에만 가능하며, 수정 데이터를 입력 시 DB에 수정이 되도록 구현하였습니다.

- 커뮤니티 게시판

<게시물 목록 조회>

![image](https://user-images.githubusercontent.com/66732896/112925344-af541f80-914c-11eb-8da1-8e1672048780.png)

<페이지 2로 목록 조회>

![image](https://user-images.githubusercontent.com/66732896/112925549-00fcaa00-914d-11eb-963e-5c50c1621745.png)

<Info 로만 조회 시>

![image](https://user-images.githubusercontent.com/66732896/112925483-e88c8f80-914c-11eb-939c-bd2e6e992e19.png)

-게시판/댓글 목록, 페이징, 분류 및 검색에 따른 결과를 REST API 방식으로 AJAX를 통해 데이터만 주고 받도록 구현하였으며 DB에 저장된 게시물 수에 따라 혹은 검색 조건에 따른 게시물 수에 따라 페이징 번호가 부여됩니다.

- 상세 보기 

![image](https://user-images.githubusercontent.com/66732896/112926119-f098ff00-914d-11eb-85ef-a9741d910ff0.png)

- 사용자로써 회원이 인증이 될 시 게시판 및 댓글 글쓰기/수정 및 삭제 가능하며, 업로드 파일 호출은 AJAX를 이용하였습니다. 댓글 목록 호출 및 페이징은 게시물과 동일합니다.

사용자가 필요로 하는 기능만을 구현했기에 쉽고 편리하게 사용할 수 있으며, 취업생들끼리 정보 및 팁들을 소통하며 도움이 되어 성공적인 취업을 도모하는 웹 사이트입니다.
