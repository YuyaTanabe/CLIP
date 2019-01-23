// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
  //= require activestorage
  //= require turbolinks
  //= require jquery
  //= require bootstrap-sprockets
  //= require_tree .


$(function(){
function resize(){
getHeight = $('body').height();//変数を関数外でも使うのでvarは付けません。
windowHeight = window.innerHeight;
scrollHeight = getHeight-windowHeight;//最大スクロール値の計算
}
resize();//読み込み時の処理
window.onresize = resize;//リサイズのイベントハンドラ
$(window).scroll(function () {
ScrollTop = $(document).scrollTop();
bgPosition = 1/scrollHeight*ScrollTop+10;
$('body').css(
{backgroundPositionY: bgPosition+"%"}
);
});
});
