/*
 *= require administration/v1/shared/share
 *= require_self
 */

 $(function(){
 	$('.js-submit').on('click', function(){
		$.ajax(
			{
				url: "/administration-api/v1/sessions",
				type: "post",
				data: {
					"phone_number": $('.js-phone-number').val(),
					"password": $('.js-password').val()
				},
				dataType: "json"
			}
		)
			.done(function( data ) {
				if(data['success']){
					$('.js-error-vector').html("&nbsp;");
					window.location.href = "/administration/v1/dashboards/~";
				}else{
					console.log(data);
					$('.js-error-vector').html(data['message']);
					return false;
				}
				return true;
			})
			.fail(function( xhr, status, errorThrown ) {
				console.log(data);
				$('.js-error-vector').html(data['message']);
				return false;
			})
			.always(function( xhr, status ) {
			});
	});
 })
