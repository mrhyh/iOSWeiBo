

//插入网络封面
function insertCoverImage(url, alt){
	var html = '<img src="' + url + '" alt="' + alt + '" />';
	$("#zss_field_cover .cover_empty").hide();
	$("#zss_field_cover .cover_show").show();
	$("#zss_field_cover .cover_show").html(html);
}

//插入本地封面
function insertCoverLocalImage(imageNodeIdentifier, localImageUrl){
	var imageContainerIdentifier = 'img_container_' + imageNodeIdentifier;

	var imgContainerStart = '<span id="' + imageContainerIdentifier+'" class="img_container" contenteditable="false" data-failed="Tap to try again!">';
	var imgContainerEnd = '</span>';
	var image = '<img data-wpid="' + imageNodeIdentifier + '" src="' + localImageUrl + '" alt="" />';
	var html = imgContainerStart + image + imgContainerEnd + '<div class="cover_tips"><div class="cover_tips_icon">'
            +'<img src="imgs/compose_cover_change.png" /></div><div class="cover_tips_title">选择封面</div>'
            +'</div>';


	$("#zss_field_cover .cover_empty").hide();
	$("#zss_field_cover .cover_show").show();
	$("#zss_field_cover .cover_show").html(html);
}

String.prototype.gblen = function() {
	var len = 0;
	for (var i=0; i<this.length; i++) {
		if (this.charCodeAt(i)>127 || this.charCodeAt(i)==94) {
			 len += 2;
		 } else {
			 len ++;
		 }
	 }
	return len;
}

function stringLengthCut(str,len){
	if(str.gblen() <= len){
		return str;
	}
	str = str.substr(str.length-1)
	return stringLengthCut(str,len);
}

var weico = {
	titleRecommend:false, //是否进行过标题文字限制提示
	imageRecommend:false, //是否进行过图片文字限制提示
	bak : ""
}

$(function(){
	//添加导语点击事件
	$("#zss_field_lead").click(function(){
		ZSSEditor.callback("callback-lead-tap");
	});
	
	//封面点击事件
    $("#zss_field_cover").click(function(){
    	ZSSEditor.callback("callback-cover-tap");
    });

	document.getElementById("zss_field_title").addEventListener("input", function() {
    	var content = document.getElementById("zss_field_title").innerText
    	var currentLen = content.gblen();
    	if(currentLen > 64){
		document.getElementById("zss_field_title").style.color = "red";
		if(!weico.titleRecommend){
			if(typeof(ZSSEditor) != "undefined"){
			    //进行提示
				weico.titleRecommend = true;
				ZSSEditor.callback("callback-title-oversize");
			}
		}
    	}else{
		document.getElementById("zss_field_title").style.color = "";
    	}

    }, false);
})

//插入导语内容
function insertLeadContent(text){
	var content = text;
	var len = content.gblen();
	if(len > 0){
	    $("#zss_field_lead").show();
	}
	else{
	    $("#zss_field_lead").hide();
	}
	//var html = '<p>'+text+'</p>';
	var html = ''+text+'';
	$("#zss_field_lead").html(html);
	$(document.body).scrollTop(0);

}


