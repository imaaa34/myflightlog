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
//= require jquery3
//= require popper
//= require bootstrap-sprockets

//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .


/* Logs#stats airportPieChart
---------------------------- */

$(document).on('turbolinks:load', function( ){
// window.onload = function(){  //ページの読み込みが完了した段階で処理が実行される
  var ctx1 = document.getElementById("airportPieChart");
  var airportPieChart = new Chart(ctx1, {
    type: 'pie',
    data: {
      labels: gon.airport,
      datasets: [{
          backgroundColor: [
              "#c97586",
              "#bbbcde",
              "#93b881",
              "#e6b422",
              "#aecbcd"
          ],
          data: gon.airport_num,
          borderColor: "#e6e6e6"
      }]
    },
    options: {
      title: {
        display: true,
        //グラフタイトル
        text: '利用した空港'
      }
    }
  });



/* Logs#stats airlinePieChart
---------------------------- */

  var ctx2 = document.getElementById("airlinePieChart");
  var airlinePieChart = new Chart(ctx2, {
    type: 'pie',
    data: {
      labels: gon.airline, //データ項目のラベル
      datasets: [{
          backgroundColor: [
              "#c97586",
              "#bbbcde",
              "#93b881",
              "#e6b422",
              "#aecbcd"
          ],
          data: gon.airline_num, //グラフのデータ
          borderColor: "#e6e6e6"
      }]
    },
    options: {
      title: {
        display: true,
        //グラフタイトル
        text: '利用した航空会社'
      }
    }
  });
// }
});



/* Logs#map GoogleMap
---------------------------- */

var map;
var marker = [];  //マーカーの配列
var markerData = gon.airport;  //空港の名前が入った配列
var center = {
  lat: 35.689614,
  lng: 139.691585
};  //中心を東京に設定

function initMap() {

  //地図を表示させる
  map = new google.maps.Map(document.getElementById('map'), {
    center: center,
    zoom: 2
  });

  // geocoderのインスタンス生成
  geocoder = new google.maps.Geocoder();

  for (var i = 0; i < markerData.length; i++) {

    //geocoder.geocodeにアドレスの配列から1つずつ取り出して渡す
    geocoder.geocode(
      {
        address: markerData[i]
      },
      function (results, status) {
        //ステータスがOKでresults[0]が存在すればマーカーを生成
        if (status == google.maps.GeocoderStatus.OK && results[0]) {
          // マーカーの追加
          marker[i] = new google.maps.Marker({
            position: results[0].geometry.location,
            map: map
          });
        }
        else {
          alert('位置の取得ができませんでした。理由：' + status);  //ステータスOK以外またはresult[0]が存在しない場合
          return;
        }
      } //function(result, status)終了
    ); //geocoder.geocode終了

  } //for終了
} //initMap()終了


