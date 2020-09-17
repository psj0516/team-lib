<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <jsp:include page="/WEB-INF/views/include/head.jsp" />
    <link
      href="/css/member/join.css"
      rel="stylesheet"
      type="text/css"
      media="all"
    />
    <title>아이디 확인</title>
  </head>
  <body>
    <div id="window-wrapper">
      <div class="input-box">
        <form action="/member/joinIdDupCheck" method="post" name="cfrm">
          <table>
            <tr>
              <c:choose>
                <c:when test="${ requestScope.isIdDup }">
                  <td colspan="2">
                    <p>사용중인 ID입니다.</p>
                  </td>
                </c:when>
                <c:otherwise>
                  <td><p>사용가능한 ID입니다.</p></td>
                  <td>
                    <button
                      type="button"
                      class="button-custom small-button"
                      onclick="result()"
                    >
                      사용하기
                    </button>
                  </td>
                </c:otherwise>
              </c:choose>
            </tr>
            <tr>
              <td>
                <input type="text" name="id" value="${ requestScope.id }" />
              </td>
              <td>
                <button type="submit" id="btn" class="button-custom">
                  중복 확인
                </button>
              </td>
            </tr>
          </table>
        </form>
      </div>
    </div>
    <script>
      function result() {
        // 현재창(자식창)의 id값을 부모창(join.jsp)의 id 입력상자에 넣기
        opener.document.joinForm.id.value = cfrm.id.value;
        close(); // window.close(); // 현재창 닫기
      }
    </script>
  </body>
</html>
