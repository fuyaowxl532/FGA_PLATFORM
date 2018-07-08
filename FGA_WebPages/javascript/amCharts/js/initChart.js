var Myamchart = {
    createChart: function (id, data) {//idÎªÔªËØid£¬data£º[{"country": "USA", "visits": 4025,"color": "#FF0F00"}, {"country": "China","visits": 1882,"color": "#FF6600"}]
        var chart = AmCharts.makeChart(id, {
            "theme": "none",
            "type": "serial",
            "startDuration": 2,
            "dataProvider": eval(data),
            "valueAxes": [{
                "position": "left",
                "axisAlpha": 0,
                "gridAlpha": 0
            }],
            "graphs": [{
                "balloonText": "[[category]]: <b>[[value]]</b>",
                "colorField": "color",
                "fillAlphas": 0.85,
                "lineAlpha": 0.1,
                "type": "column",
                "topRadius": 1,
                "valueField": "visits"
            }],
            "depth3D": 40,
            "angle": 30,
            "chartCursor": {
                "categoryBalloonEnabled": false,
                "cursorAlpha": 0,
                "zoomable": false
            },
            "categoryField": "country",
            "categoryAxis": {
                "gridPosition": "start",
                "axisAlpha": 0,
                "gridAlpha": 0

            },
            "exportConfig": {
                "menuTop": "20px",
                "menuRight": "20px",
                "menuItems": [{
                    "icon": '/lib/3/images/export.png',
                    "format": 'png'
                }]
            }
        }, 0);
    }
}
