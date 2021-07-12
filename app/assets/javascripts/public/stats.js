/* Logs#stats airportPieChart
---------------------------- */


$(document).on('turbolinks:load', function( ){

  if (location.pathname == '/logs/stats') {
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
  }  //if終了

}); //turbolinks無効化終了