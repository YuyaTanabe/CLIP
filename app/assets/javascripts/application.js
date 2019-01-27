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


// 背景画像を固定
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


// page topボタン
$(function(){
var topBtn=$('#pageTop');
  topBtn.hide();
  //◇ボタンの表示設定
  $(window).scroll(function(){
    if($(this).scrollTop()>80){
      //---- 画面を80pxスクロールしたら、ボタンを表示する
      topBtn.fadeIn();
    }else{
      //---- 画面が80pxより上なら、ボタンを表示しない
      topBtn.fadeOut();
    }
  });
  //◇ボタンをクリックしたら、スクロールして上に戻る
  topBtn.click(function(){
    $('body,html').animate({
    scrollTop: 0},800);
    return false;
  });
});


// ナビバーの文字を変化させる
$(function(){
  $('.nav_menu').mouseover(function(){
      $(this).css({'color': '#ffa500'});
      $(this).css({'font-size': '20px'});
  });

  $('.nav_menu').mouseout(function(){
      $(this).css({'color': ''});
      $(this).css({'font-size': ''});
  });
});



// page bottomボタン
$(function(){
var bottomBtn=$('#pageBottom');
  //◇ボタンの表示設定
  $(window).scroll(function(){
    if($(this).scrollTop()<500){
      //---- 画面を500pxスクロールするまで、ボタンを表示する
      bottomBtn.fadeIn();
    }else{
      //---- 画面が500pxより下なら、ボタンを表示しない
      bottomBtn.fadeOut();
    }
  });
  //◇ボタンをクリックしたら、スクロールしてページ最下部へ
  bottomBtn.click(function(){
    $('body,html').animate({
    scrollTop: $(document).height()},800);
    return false;
  });
});


// フラッシュメッセージの消える時間
$(function(){
  $(".alert-danger").fadeOut(6000);
});

$(function(){
  $(".alert-success").fadeOut(6000);
});

