/**
 * Created by Administrator on 2017/5/10.
 */


$(".aboutHos li div a img").animate({
    width: "540px",
    height: "340px"
})

$(".centerNav li").click(function () {
    var i = $(this).index();
    $(".middle .column").hide().eq(i).show();
    console.log(this);
    $(this).addClass("active").siblings().removeClass("active");
    if($(".middle .column").eq(i).hasClass("aboutHos")){
        $(".aboutHos li div a img").animate({
            width: "540px",
            height: "340px"
        })
    }else {
        $(".aboutHos li div a img").animate({
            width:0,
            height:0
        })
    }
})

