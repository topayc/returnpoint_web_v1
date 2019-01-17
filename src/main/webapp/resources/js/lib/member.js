//이메일 형식 체크 
function checkEmail(str) {
	//var pattern = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/;
	var pattern = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	if (str.match(pattern) != null) {
		return true;
	} else {
		return false;
	}
} 

	// 공백 체크
function checkSpace(str) { 
	return (str.search(/\s/) != -1) ;
} 

//비밀번호 패턴 체크 (8자 이상, 문자, 숫자, 포함여부 체크) 
function checkPasswordPattern(str) { 
	var pattern1 = /[0-9]/;	// 숫자 
	var pattern2 = /[a-zA-Z]/;	// 문자 
	//var pattern3 = /[~!@#$%^&*()_+|<>?:{}]/;	// 특수문자
	if(!pattern1.test(str) || !pattern2.test(str) || str.length < 8 || str.length > 12) { 
		return false; 
	} else { 
		return true; 
	} 
}		

//휴대폰 숫자 체크
function checkPhonePattern(str) { 
	var pattern1 = /[0-9]/;	// 숫자
	return pattern1.test(str) ;
}