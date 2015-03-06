function sinAndCos() {
  var subscribe = [],
      unsubscribe = [];

  subscribe = [{x: 25.04, y: 12}, {x: 26.04, y: 13}, {x: 27.04, y: 14}, {x: 28.04, y: 15}, {x: 29.04, y: 16}, {x: 30.04, y: 16}]
  unsubscribe = [{x: 25.04, y: 2}, {x: 26.04, y: 1}, {x: 27.04, y: 0}, {x: 28.04, y: 0}, {x: 29.04, y: 2}, {x: 30.04, y: 3}]


  return [
    {
      values: subscribe,
      key: "Подписались",
      color: "#ff7f0e"
    },
    {
      values: unsubscribe,
      key: "Отписались",
      color: "#2ca02c"
    }
  ];
}


$(function() {
  nv.addGraph(function() {
    var chart = nv.models.lineChart()
      .margin({left: 100})
      .showLegend(true)
      .useInteractiveGuideline(true)
    ;
    var myData = sinAndCos();

    chart.xAxis
      .tickFormat(d3.format(',r'))
    ;

    chart.yAxis
      .tickFormat(d3.format(',r'));

    d3.select('#statistics1') 
      .datum(myData)
      .transition().duration(500)
      .call(chart);

    nv.utils.windowResize(chart.update);

    return chart;
  });

});