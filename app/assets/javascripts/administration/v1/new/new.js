/*
 *= require kindeditor
 *= require administration/v1/shared/share.js
 *= require_self
 */
$(function(){
	$('.js-create-new').on('click', submitData);
})

function submitData(){
	$.ajax({
		url: "/administration-api/v1/new",
		type: "post",
		data: {
			"title": $('#title').val(),
			"vice_title": $('#vice_title').val(),
			"occurred_at": $('#occurred_at').val(),
			"classify": $('#classify').val(),
			"aim_at_platform": $('#aim_at_platform').val(),
			"key_words": $('#key_words').val(),
            "scan_rails_path": $('#scan_rails_path').val(),
            "state": $('#state').val(),
			"content": content.html()
		},
		dataType: "json"
	})
		.done(function( data ) {
			if(data['success']){
				window.location.href='/administration/v1/new';
			}else{
				alert(data['message']);
			}
		})
		.fail(function( xhr, status, errorThrown ) {
			alert('异常');
			return false;
		})
		.always(function( xhr, status ) {
		});
}

