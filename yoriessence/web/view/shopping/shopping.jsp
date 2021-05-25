<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.yoriessence.shopping.vo.ShoppingCart" %>
<%
	ShoppingCart sc=(ShoppingCart)request.getAttribute("sc");
%>
<%@ include file="/view/common/header.jsp"%>
   <style>
 		    .or>td{
            border: 1px gray solid;
        }
        
        .fonttext{
            font-size:30px;
        }
        .pod{
            /* border: 1px red solid; */
            height: 300px;
            width:300px;
        }
        #check{
            /* border: 1px red solid; */
            width:50px;
            height:50px;
        }
        .chogo{
            /* border: 1px red solid; */
            height:130px;
            width:1600px;
            position: absolute;
            top:40%;
            left:10%;
            font-size:30px;
            text-align:center;  
        }
        #jan{
            /* border: 1px red solid; */
            position: absolute;
            top:30%;
            left: 45%;
            font-size:50px;
            width:200px;
        }
        .button{
            position: absolute;
            height:52px;
            width:102px;
            top:12%;
            left:322%;
            font-size:38px;
        }
</style> 
	<div>
        <h2 id="jan">장바구니</h2>
        <table class="chogo">
            <tr class="or">
                <td><input type="checkbox" class="checkbox"></td>
                <td>상품</td>
                <td>상품명</td>
                <td>가격</td>
                <td>수량</td>
                <td>배송비</td>
                <td>주문하기</td>
            </tr>
            <tr class="or">
                <td id="check"><input type="checkbox" class="checkbox"></td>
                <td><img src="" alt="" class="pod"></td>
                <td class="fonttext"><%=sc.getProductname() %></td>
                <td class="fonttext"><%=sc.getProductprice() %></td>
                <td class="fonttext">
                    <p><%=sc.getProductnumber() %>EA</p>
                </td>
                <td class="fonttext"><%=sc.getProductshopify() %>원</td>
                <td>
                    <button onclik="test" class="fonttext">주문하기</button>
                    <br><br>
                    <button class="fonttext">삭제하기</button>
                </td>
            </tr>
        </table>
    </div>
    
    
<!-- 결제 api: https://docs.iamport.kr/implementation/payment 참고하여 추가할것! -->
<!-- <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script>
	var IMP = window.IMP; // 생략가능
	IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	
	// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
	// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드

	IMP.request_pay({
	    pg : 'kakao', // version 1.1.0부터 지원.
	    /*
			'kakao':카카오페이,
			html5_inicis':이니시스(웹표준결제)
			'nice':나이스페이
			'jtnet':제이티넷
			'uplus':LG유플러스
			'danal':다날
			'payco':페이코
			'syrup':시럽페이
			'paypal':페이팔
		*/
	    pay_method : 'card',
	    /*
			'samsung':삼성페이,
			'card':신용카드,
			'trans':실시간계좌이체,
			'vbank':가상계좌,
			'phone':휴대폰소액결제
		*/
	    merchant_uid : 'merchant_' + new Date().getTime(),
	    name : '주문명:결제테스트',
	    /* 결제창에서 보여질 이름 */
	    amount : 100,
	    /* 가격 */
	    buyer_email : 'iamport@siot.do',
	    buyer_name : '구매자이름',
	    buyer_tel : '010-1234-5678',
	    buyer_addr : '서울특별시 강남구 삼성동',
	    buyer_postcode : '123-456',
	    m_redirect_url : 'https://www.yourdomain.com/payments/complete'
	    /*
	    	모바일 결제시,
	    	결제가 끝나고 랜딩되는 URL을 지정
	    	(카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
	    */
	}, function(rsp) {
	    if ( rsp.success ) {
	        var msg = '결제가 완료되었습니다.';
	        msg += '고유ID : ' + rsp.imp_uid;
	        msg += '상점 거래ID : ' + rsp.merchant_uid;
	        msg += '결제 금액 : ' + rsp.paid_amount;
	        msg += '카드 승인번호 : ' + rsp.apply_num;
	    } else {
	        var msg = '결제에 실패하였습니다.';
	        msg += '에러내용 : ' + rsp.error_msg;
	    }
	    alert(msg);
	});
	/* https://admin.iamport.kr/payments 환불페이지 실수로결제했을때 사용가능함*/
</script>  -->
<%@ include file="/view/common/footer.jsp"%>