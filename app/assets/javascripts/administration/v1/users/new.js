/*
 *= require administration/v1/shared/share.js
 *= require_self
 */

$(function(){
	$('.js-create').on('click', submitData);
})

function submitData(){
	$.ajax({
		url: "/administration-api/v1/users",
		type: "post",
		data: {
			"name": $('#name').val(),
			"phone_number": $('#phone_number').val(),
			"role_code": $('#role_code').val()
		},
		dataType: "json"
	})
		.done(function( data ) {
			if(data['success']){
				window.location.href='/administration/v1/users';
			}else{
				alert(data['message']);
			}
		})
		.fail(function( xhr, status, errorThrown ) {
			alert(JSON.parse(xhr.responseText)['message']);
			return false;
		})
		.always(function( xhr, status ) {
		});
}

