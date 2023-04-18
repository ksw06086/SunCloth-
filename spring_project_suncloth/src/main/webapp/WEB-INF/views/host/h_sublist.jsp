<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<td>판매상태*</td>
	<td>
 		<input type = "radio" name = "state" id = "saleing" value = "판매중" checked>
 		<label for = "saleing">판매중</label>&emsp;
 		<input type = "radio" name = "state" id = "notstock" value = "품절">
  		<label for = "notstock">품절</label>&emsp;
  		<input type = "radio" name = "state" id = "saleready" value = "판매대기">
  		<label for = "saleready">판매대기</label>&emsp;
  		<input type = "radio" name = "state" id = "salestop" value = "판매중지">
		<label for = "salestop">판매중지</label>&emsp;
  	</td>
</tr>
  				
<tr>
	<td>재고 *</td>
	<td><input type = "number" id = "stock" name = "stock" min = "1" value = "${stockvo.count}">ea
	</td>
</tr>
	     	
<tr>
	<td>최대구매수량</td>
	<td>
  	최대 <input type = "number" id = "maxcount" name = "maxcount" min = "1" value = "${stockvo.maxcount}">개 까지 구매 가능
	</td>