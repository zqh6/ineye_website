/**
 * Created by Administrator on 2017/5/10.
 */

$('.slide').ckSlide({
    autoPlay:true,
});
$(".slide.slide-left").ckSlide({
    autoPlay:true,
    add:true,
    // seamless:true,
    dir:"x",
});


$(".aboutHos li div a img").animate({
    width: "540px",
    height: "340px"
})

$(".centerNav li").click(function () {
    var i = $(this).index();
    console.log(i);
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

bannerListFn(
    $(".banner"),
    $(".img-btn-list"),
    $(".left-btn"),
    $(".right-btn"),
    2000,
    true
);
