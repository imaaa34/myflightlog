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



// 円グラフ表示

nv.addGraph(function() {
  var donutChart = nv.models.pieChart()
  		.x(function(d) {
        return d.label
      })
  		.y(function(d) {
        return d.value
      })
  		.showLabels(true)
  		.showLegend(false)
  		.labelThreshold(.05)
  		.labelType("key")
  		.color(["#965251", "#00b3ca", "#7dd0b6", "#e38690", "#ead98b"])
  		.tooltipContent(
        function(key, y, e, graph) { return 'Custom tooltip string' }
      ) // This is for when I turn on tooltips
  		.tooltips(false)
  		.donut(true)
  		.donutRatio(0.35);

  	// Insert text into the center of the donut
  	function centerText() {
			return function() {
        var svg = d3.select("svg");

    		var donut = svg.selectAll("g.nv-slice").filter(
          function (d, i) {
            return i == 0;
          }
        );

        // Insert first line of text into middle of donut pie chart
        donut.insert("text", "g")
            .text("Line One")
            .attr("class", "middle")
            .attr("text-anchor", "middle")
        		.attr("dy", "-.55em")
        		.style("fill", "#000");
        // Insert second line of text into middle of donut pie chart
        donut.insert("text", "g")
            .text("Line Two")
            .attr("class", "middle")
            .attr("text-anchor", "middle")
        		.attr("dy", ".85em")
        		.style("fill", "#000");
      }
    }

  // Put the donut pie chart together
  d3.select("#chart-circle svg")
    .datum(seedData())
    .transition().duration(300)
    .call(donutChart)
    .call(centerText())
    .call(pieSlice());

  return donutChart;
});


// Seed data to populate donut pie chart
function seedData() {
  return [
    {
      "label": "One",
      "value": 25
    },
    {
      "label": "Two",
      "value": 25
    },
    {
      "label": "Three",
      "value": 25
    },
    {
      "label": "Four",
      "value": 25
    },
    {
      "label": "Five",
      "value": 25
    }
  ];
}