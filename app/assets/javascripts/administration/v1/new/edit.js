//= require kindeditor
//= require_self

$(function(){
	$('.js-create-new').on('click', submitData);
})

function submitData(){
	$.ajax({
		url: "/administration-api/v1/new/"+$('.js-id').val(),
		type: "put",
		data: {
			"title": $('#title').val(),
			"vice_title": $('#vice_title').val(),
			"occurred_at": $('#occurred_at').val(),
			"classify": $('#classify').val(),
			"key_words": $('#key_words').val(),
			"content": content.html()
		},
		dataType: "json"
	})
	.done(function( data ) {
		if(data['success']){
			window.location.href='/administration/v1/new/'+$('.js-id').val();
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