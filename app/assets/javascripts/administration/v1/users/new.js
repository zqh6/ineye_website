/*
 *= require_self
 */

$(function(){

  showOrHide($('#role_code').val()=='common_user');
	$('.js-create').on('click', submitData);
	$('#role_code').on('change', showOrHideUserEditInputs);
});

function changeStr(strValue) {
    return strValue.replace(/\r\n/g, '</p><p>').replace(/\n/g, '</p><p>').replace(/\s/g, ' ');
}

function showOrHideUserEditInputs(){
  var dom = $(this);
  showOrHide(dom.val()=='common_user');
};

function showOrHide(ifTrue){
  if(ifTrue){
    //var doctorInputsDom = $($('#doctors-inputs').html());
    $('.doctors-inputs-vector').show();
  }else{
    $('.doctors-inputs-vector').hide();
  }
}

function submitData(){
  var formDom = $('.js-form');
  var roleCode= $('#role_code').val();
  var requestData = {
    "name": $.trim($('#name').val()),
    "phone_number": $('#phone_number').val(),
    "role_code": roleCode,
    "official_account": $('#official_account').val()
  };
  if(roleCode=='common_user'){
    var officeIds = $('#office_id').val();
    if(officeIds==null||''==officeIds){
      alert('请选择科室');
      return;
    }
    requestData['office_ids'] = officeIds;
    requestData['user_order'] = $('#user_order').val();
    requestData['honour_brief_introduction'] = $('#honour_brief_introduction').val();
    requestData['honour_specific'] = changeStr($('#honour_specific').val());
    requestData['good_at_field'] = changeStr($('#good_at_field').val());
    requestData['work_time'] = $('#work_time').val();
    requestData['detailed_introduction'] = changeStr($('#detailed_introduction').val());
    requestData['doctor_level'] = $('#doctor_level').val();
  }
  console.log(requestData);
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

