<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<script type='text/javascript'>

function __jsmsgLink(msg, url, mode) {
	//alert(msg + ", " + url + ", " + mode);
	//alert(msg);
 
	if (mode == 'P') {
		parent.location.replace(url);
	} else if (mode == 'O') {
		opener.location.replace(url);
	} else if (mode == 'T') {
		top.location.replace(url);
	} else if (mode == 'OC') {
		opener.location.replace(url);
		window.close();
	} else if(mode == 'CC') {
		location.href = url;
		//location.reload(url);
	} else {
		location.replace(url);
	}
}

function __gotoURL(url, mode) {

	if (mode == 'T') {
		top.location.replace(url);
	} else if (mode == 'O') {
		opener.location.replace(url);
		window.close();
	} else if (mode == 'OP') {
		opener.parent.location.replace(url);
		window.close();		
	} else if (mode == 'OT') {
		opener.top.location.replace(url);
		window.close();
	} else if (mode == 'P') {
		parent.location.replace(url);
	} else if(mode == 'CC') {
		location.href = url;
	} else {
		location.replace(url);
	}
}

function __pageReload(mode) {
	
	if (mode == 'O' || mode == 'C') {
		opener.location.reload();
	} else if(mode == 'P') {
		parent.location.reload();
	} else if(mode == 'T') {
		top.location.reload();
	}
	if (mode == 'C') {
		window.close();
	}
	
}

function __jsmsgReload(msg, mode) {
	alert(msg);
	if (mode == 'O' || mode == 'C') {
		top.opener.location.reload();
	} else if (mode == 'P') {
		parent.location.reload();
	} else if (mode == 'T') {
		top.location.reload();
	} 
	
	if (mode == 'C') {
		top.window.close();
	}
}

function __jsmsgClose(msg) {

	if(msg != '') {
		alert(msg);
	}
	window.close();
}

</script>
<script type='text/javascript'>
	; ${excute_script} ;
</script>
