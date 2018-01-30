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
    //选择功能和替换排班内容  data为后台ajax传过来的排班信息
    function getVal(dom,data){
      var doctor = !data?[]:data;
      console.log($(dom).find(".doctors input[type=checkbox]").length);
      for(var l=0;l<$(dom).find(".doctors").length;l++){
        for(var i =0;i< $(dom).find(".doctors").eq(l).find("input[type=checkbox]").length;i++){
          if($(dom).find(".doctors").eq(l).find("input[type=checkbox]").eq(i).is(":checked")){
              doctor.push($(dom).find(".doctors").eq(l).find("input[type=checkbox]").eq(i).val());
          }else{
          }
        }

      }
      $($(dom).parents(".doctorListCon").find("p")).html(doctor);
      if(doctor.length==0){
        $($(dom).parents(".doctorListCon").find("p")).html("请选择排班医生 <i class='am-selected-icon am-icon-caret-down fr'></i>")
      }
      return doctor;

    }
    $(".saveDoctor").click(function(){
      $(this).parents(".doctorListCon").find(".doctorList").hide()
    })
  })
