/*
 *= require administration/v1/shared/share.js
 *= require_self
 */

$(function(){
	$('.js-create').on('click', submitData);
})

function submitData(){
  formDom = $('.js-form');
  var requestData = {
    "name": $('#name').val(),
    "phone_number": $('#phone_number').val(),
    "role_code": $('#role_code').val()
  };
  if($('.js-id').val()!=null && $('.js-id').val()!=''){
    requestData['office_id'] = $('#office_id').val();
    requestData['honour_brief_introduction'] = $('#honour_brief_introduction').val();
    requestData['honour_specific'] = $('#honour_specific').val();
    requestData['good_at_field'] = $('#good_at_field').val();
    requestData['work_time'] = $('#work_time').val();
    requestData['detailed_introduction'] = $('#detailed_introduction').val();
  }

	$.ajax({
		url: formDom.attr('action'),
		type: formDom.attr('method'),
		data: requestData,
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

