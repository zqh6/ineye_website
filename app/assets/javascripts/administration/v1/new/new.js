//= require kindeditor
//= require_self

$(function(){
	$('.js-create-new').on('click', a);

	function a(){
		$.ajax({
			url: "/administration-api/v1/new",
			type: "post",
			data: {
				"title": $('#title').val(),
				"vice_title": $('#vice_title').val(),
				"occurred_at": $('#occurred_at').val(),
				"classify": $('#classify').val(),
				"key_words": $('#key_words').val(),
				"content": $('body.ke-content').innerHTML
			},
			dataType: "json"
		})
		.done(function( data ) {
		})
		.fail(function( xhr, status, errorThrown ) {
			alert('异常');
			return false;
		})
		.always(function( xhr, status ) {
		});
	}
})

