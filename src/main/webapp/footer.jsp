<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<body>
    <footer>
        <div class="container">
            <div class="top">
                <div>
                    <div class="texttext">
                        <h5>고객센터 1522-1522</h5>
                        <h5>이메일 justice2250@naver.com</h5>
                    </div>
                    <ul>
                        <a href="<c:url value='/community/one_qna.bo?page=1'/>"><li><i class="fa-solid fa-comment-dots"></i>1:1 문의</li></a>
                        <a href="<c:url value='/community/faq.bo?page=1'/>"><li><i class="fa-solid fa-comments"></i>자주하는 질문</li></a>
                        <a href="<c:url value='/community/notice.bo?page=1'/>"><li><i class="fa-solid fa-check"></i>공지사항</li></a>
                    </ul>
                </div>
                <div class="texttext">
                    <h5>사업자 입점문의 1522-1522</h5>
                    <h5>이메일 justice2250@naver.com</h5>
                </div>
                <ul>
                    <a href="<c:url value='/login/sel_login.jsp'/>"><li><i class="fa-solid fa-note-sticky"></i>입점신청</li></a>
                </ul>
            </div>
            <hr>
            <div class="bottom">
                <div>
                    <img src="<c:url value='/resources/images/logo.png'/>" width="8%">
                    <p>copyright 2022. ChanggiFood All rights reserved.<br>design by sujin.</p>
                </div>
                <div>
                    <a href="#"><i class="fa-brands fa-facebook-f"></i></a>
                    <a href="#"><i class="fa-brands fa-instagram"></i></a>
                    <a href="#"><i class="fa-brands fa-twitter"></i></a>
                </div>
            </div>
        </div>
    </footer>
</body>