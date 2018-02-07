//= require administration/v1/shared/amazeui.dialog.min.js

$(function () {

	$('.js-alert-logout-confirm').on('click', showLogoutConfirm);

	function showLogoutConfirm() {
		$('#logout-confirm').modal({
			onConfirm: function(options) {
				logout()
			},
			onCancel: function() {
			}
		});
	}

	function logout(){
		var userId = $('.js-logout-confirm').attr('data-users-id');
		$.ajax(
			{
				url: "/administration-api/v1/sessions/"+userId,
				type: "delete",
				dataType: "json"
			}
		)
			.done(function( data ) {
				if(data['success']){
					window.location.href = "/administration/v1/sessions/new";
				}else{
					alert(data['message']);
					return false;
				}
				return true;
			})
			.fail(function( xhr, status, errorThrown ) {
			})
			.always(function( xhr, status ) {
			});
	}
})
