function signLoad(signId){
	var signs = signId.split("#");
	for(i = 0; i < signs.length; i++){
		var isSign = document.getElementById(signs[i]);
		if(isSign.value != null && isSign.value != ""){
			var sign = document.getElementById(isSign.id + "Sign");
			URL = basePath + "/signservice?userId=" + isSign.value;
			sign.src = URL;
			sign.style.display = "";
			isSign.style.display = "none";
		}
	}
}


function sign(check){
	check.style.display = "none";
	check.value = userId;
	var name = check.id;
	var sign = document.getElementById(name + "Sign");
	var URL = basePath + "/signservice?userId=" + userId;
	sign.src = URL;
	sign.style.display = "";
}