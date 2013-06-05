<%@ page language="java" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
	<head>
		<title>表单页面demo</title>
		<%@ include file="/form/formbase.jspf" %>
	</head>
    <body onload="init()">
        <form method="post">
            <input type="text" name="NAME" id="BBB"/>
            <input type="text" name="ZCDAFF" id="aaa" class="Wdate" onClick="WdatePicker()" />
            
            
	        <select id="CCZ" name="CCZ">
                <%= Dictionary.get("") %>
	        <select>

            <input type="radio" name="DFDF" value = "Apple" checked>苹果<br>
            <input type="radio" name="DFDF" value = "Orange" >桔子<br>
            <input type="radio" name="DFDF" value = "Mango">芒果<br>
            
            <input type="checkbox" name="ADFGFG" value="ck1" checked>     
            <input type="checkbox" name="ADFGFG" value="ck2">     
            <input type="checkbox" name="ADFGFG" value="ck3" checked>     
            <input type="checkbox" name="ADFGFG" value="ck4">     
            <input type="checkbox" name="ADFGFG" value="ck5"> 
            
            
            <input type="submit" value="保存" />
        </form>
    </body>
</html>
