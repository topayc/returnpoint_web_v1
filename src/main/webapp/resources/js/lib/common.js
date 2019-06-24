function isEmpty(obj){
	if(typeof obj.value.trim() == "undefined" || obj.value.trim() == null || obj.value.trim() == ""){
		return true
	}else{
		return false
	}
}


function setCookie(name, value, expiredays) {
	var today = new Date();
	    today.setDate(today.getDate() + expiredays);
	    document.cookie = name + '=' + escape(value) + '; path=/; expires=' + today.toGMTString() + ';'
} 


function getCookie(name) {
    var cName = name + "="; 
    var x = 0; 
    while ( x <= document.cookie.length ) {
        var y = (x+cName.length); 
        if ( document.cookie.substring( x, y ) == cName ) 
        { 
            if ( (endOfCookie=document.cookie.indexOf( ";", y )) == -1 ) 
                endOfCookie = document.cookie.length;
            return unescape( document.cookie.substring( y, endOfCookie ) ); 
        } 
        x = document.cookie.indexOf( " ", x ) + 1; 
        if ( x == 0 ) 
            break; 
    } 
    return ""; 
} 

function closePopupNotToday(elem){	             
	setCookie('notToday','Y', 1);
	$("#" + elem).hide('fade');
} 

function changeLang(value){
	location.href="/locale/change.do?lang=" + value.trim() + "&returnUrl="+ location.href;
}


