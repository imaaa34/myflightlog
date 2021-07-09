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
});


/* Logs#stats airlinePieChart
---------------------------- */

$(document).on('turbolinks:load', function( ){
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
});