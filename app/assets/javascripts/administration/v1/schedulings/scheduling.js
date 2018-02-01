$(function(){
  //初始化医生排班
  for(var s=0;s<$(".doctorList").length;s++){
    getVal($(".doctorList").eq(s));
  }

    $(".doctors input[type=checkbox]").click(function(){
      $(this).attr('checked','checked').siblings().removeAttr('checked');
      getVal($(this).parents(".doctorList"));
    })
    $(".workingExperts p").click(function(){
      if($(this).next().css("display")=="none"){
        $(".doctorList").hide()
        $(this).next().show();
      }else{
        $(".doctorList").hide()
        $(this).next().hide();
      }

    })
    var doctorDate = [];
    //选择功能和替换排班内容  data为后台ajax传过来的排班信息
    function getVal(dom,data){
      var doctor = !data?[]:data;
      doctorDate =[];
      for(var l=0;l<$(dom).find(".doctors").length;l++){
        for(var i =0;i< $(dom).find(".doctors").eq(l).find("input[type=checkbox]").length;i++){
          if($(dom).find(".doctors").eq(l).find("input[type=checkbox]").eq(i).is(":checked")){
              var thisDate = {
                user_id: $(dom).find(".doctors").eq(l).find(".doctorName").attr("data-user-id"),
                user_name:$(dom).find(".doctors").eq(l).find(".doctorName").html(),
                outpatient_service_type:$(dom).find(".doctors").eq(l).find("input[type=checkbox]").eq(i).next().html()
              }
              var doctormsg = {
                user_id: $(dom).find(".doctors").eq(l).find(".doctorName").attr("data-user-id"),
                outpatient_service_type:$(dom).find(".doctors").eq(l).find("input[type=checkbox]").eq(i).attr("name")
              }
              doctor.push(thisDate);
              doctorDate.push(doctormsg);
          }
        }

      }
      var schedulingdoctor = "";
      for(var i =0;i<doctor.length;i++){
        schedulingdoctor +="<span class='schedulingdoctormsg'>"+doctor[i].user_name+" "+doctor[i].outpatient_service_type +"</span>;"
      }
      $($(dom).parents(".doctorListCon").find("p")).html(schedulingdoctor);
      if(doctor.length==0){
        $($(dom).parents(".doctorListCon").find("p")).html("请选择排班医生 <i class='am-selected-icon am-icon-caret-down fr'></i>")
      }
      return doctor;

    }
    $(".saveDoctor").click(function(){
      $(this).parents(".doctorListCon").find(".doctorList").hide()
       $.ajax({
                url: '/administration-api/v1/schedulings',
                type: "POST",
                contentType: 'application/json',
                dataType: "json",
                data: JSON.stringify({
                    office_time_id: $(this).parents(".workingExperts").prev().attr("data-office-time-id"),
                    users:doctorDate,
                    week:$(this).parents(".am-tab-panel").attr("data-week-key")
                })
            })
                .done(function( data ){

                })
                .fail(function( xhr, status, errorThrown ) {
                })
                .always(function( xhr, status ) {
                });


    })



  })
