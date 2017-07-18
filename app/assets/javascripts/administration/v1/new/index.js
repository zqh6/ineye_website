/*
 *= require administration/v1/shared/share.js
 *= require_self
 */

$(function(){
	$('.js-delete-one-new').on('click',function(){
		$.ajax({
			url: "/administration-api/v1/new/"+$(this).attr('data-new-id'),
			type: "delete",
			data: {

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
	});
})
