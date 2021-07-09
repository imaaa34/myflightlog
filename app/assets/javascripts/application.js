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
  var ctx = document.getElementById("airportPieChart");
  var airportPieChart = new Chart(ctx, {
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

  var ctx = document.getElementById("airlinePieChart");
  var airlinePieChart = new Chart(ctx, {
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
  


/* Logs#graph yearLineChart
---------------------------- */

  var ctx = document.getElementById("yearLineChart");
  var yearLineChart = new Chart(ctx, {
    type: 'line',
    data: {
     //データ項目のラベル
      labels: ['1月', '2月', '3月', '4月', '5月', '6月', '7月', '8月', '9月', '10月', '11月', '12月'],
      datasets: [
        {
         //凡例のラベル
          label: 'フライト数(2020年)',
          data: [35, 34, 37, 35, 34], //グラフのデータ
          borderColor: "rgba(200,112,126,1)",
          backgroundColor: "rgba(0,0,0,0)"
        },
        {
         //凡例のラベル
          label: 'フライト数(2021年)',
          data: [35, 34, 37, 35, 34], //グラフのデータ
          borderColor: "rgba(80,126,164,1)",
          backgroundColor: "rgba(0,0,0,0)"
        }
      ],
    },
    options: {
      title: {
        display: true,
        //グラフタイトル
        text: 'フライト数グラフ'
      },
      scales: {
        yAxes: [{
          ticks: {
            suggestedMax: 10,  //最大値
            suggestedMin: 0,  //最小値
            stepSize: 1, //縦ラベルの数値単位
            callback: function(value, index, values){
              return  value +  '回' //縦軸の単位
            }
          }
        }]
      },
    }
  });
});