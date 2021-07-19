/* Logs#stats airportPieChart
---------------------------- */


$(document).on('turbolinks:load', function( ){

  if (location.pathname == '/logs/stats') {

    var ctx1 = document.getElementById("airportPieChart").getContext("2d");

    if (airportPieChart) {
      airportPieChart.destroy();
    }

    var airportPieChart = new Chart(ctx1, {
      type: 'pie',
      data: {
        labels: gon.airport,
        datasets: [{
            backgroundColor: [
              "#B0D4BA",
              "#D3C684",
              "#c97586",
              "#bbbcde",
              "#93b881",
              "#e6b422",
              "#aecbcd",
              "#DBA784",
              "#A4A1A2"
            ],
            data: gon.airport_num,
            borderColor: "#e6e6e6"
        }]
      },
      options: {
        title: {
          display: false,
          //グラフタイトル
          text: '利用した空港'
        }
      }
    });



  /* Logs#stats airlinePieChart
  ---------------------------- */


    var ctx2 = document.getElementById("airlinePieChart").getContext("2d");

    if (airlinePieChart) {
     airlinePieChart.destroy();
    }

    var airlinePieChart = new Chart(ctx2, {
      type: 'pie',
      data: {
        labels: gon.airline, //データ項目のラベル
        datasets: [{
            backgroundColor: [
              "#B0D4BA",
              "#D3C684",
              "#c97586",
              "#bbbcde",
              "#93b881",
              "#e6b422",
              "#aecbcd",
              "#DBA784",
              "#A4A1A2"
            ],
            data: gon.airline_num, //グラフのデータ
            borderColor: "#e6e6e6"
        }]
      },
      options: {
        title: {
          display: false,
          //グラフタイトル
          text: '利用した航空会社'
        }
      }
    });


  }  //if終了

}); //turbolinks無効化終了