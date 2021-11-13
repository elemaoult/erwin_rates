/* Imports */
import * as am4core from "@amcharts/amcharts4/core";
import * as am4charts from "@amcharts/amcharts4/charts";
import am4themes_dark from "@amcharts/amcharts4/themes/dark";
import am4themes_animated from "@amcharts/amcharts4/themes/animated";
import Rails from "@rails/ujs"

const initAmCharts = () => {
  am4core.useTheme(am4themes_dark);
  am4core.useTheme(am4themes_animated);

  // Create chart instance
  let chart = am4core.create("chartdiv", am4charts.XYChart);
  chart.scrollbarX = new am4core.Scrollbar();

  const loadDataInGraphs = () => {
    Rails.ajax({
      url: "/freelancer_expertises_data",
      type: "post",
      dataType:"json",
      success: function(data) {
        // console.log(`data from`, data)
        const resultArray = Array.from(data["result"])
        chart.data = resultArray;
      },
      error: function(data) {
        // console.log(data)
      }
    })
  }

  loadDataInGraphs()

  // Create axes
  let categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
  categoryAxis.dataFields.category = "daily_rate_interval";
  categoryAxis.renderer.grid.template.location = 0;
  categoryAxis.renderer.minGridDistance = 30;
  categoryAxis.renderer.labels.template.horizontalCenter = "right";
  categoryAxis.renderer.labels.template.verticalCenter = "middle";
  categoryAxis.renderer.labels.template.rotation = 270;
  categoryAxis.tooltip.disabled = true;
  categoryAxis.renderer.minHeight = 110;

  let valueAxis = chart.yAxes.push(new am4charts.ValueAxis());
  valueAxis.renderer.minWidth = 50;

  // Create series
  let series = chart.series.push(new am4charts.ColumnSeries());
  series.sequencedInterpolation = true;
  series.dataFields.valueY = "count";
  series.dataFields.categoryX = "daily_rate_interval";
  series.tooltipText = "[{categoryX}: bold]{valueY}[/]";
  series.columns.template.strokeWidth = 0;

  series.tooltip.pointerOrientation = "vertical";

  series.columns.template.column.cornerRadiusTopLeft = 10;
  series.columns.template.column.cornerRadiusTopRight = 10;
  series.columns.template.column.fillOpacity = 0.8;

  // on hover, make corner radiuses bigger
  let hoverState = series.columns.template.column.states.create("hover");
  hoverState.properties.cornerRadiusTopLeft = 0;
  hoverState.properties.cornerRadiusTopRight = 0;
  hoverState.properties.fillOpacity = 1;

  series.columns.template.adapter.add("fill", function(_fill, target) {
    return chart.colors.getIndex(target.dataItem.index);
  });

  // Cursor
  chart.cursor = new am4charts.XYCursor();

  return chart; 
}

export { initAmCharts }

// Note: Use Rails.ajax if possible | /\
// =>
// fetch("/freelancer_expertises_data", {
//   headers: {
//   'Content-Type': 'application/json'
//   },
//   method: 'POST',
//   dataType:"json"
// })
//   .then(response => response.text())
//   .then((data) => {
//     const resultArray = Array.from(JSON.parse(data)["result"])
//     chart.data = resultArray;
//   })
