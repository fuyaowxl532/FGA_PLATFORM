$(document).ready(function () {

    var horizontalStocked = new Chartist.Bar('#ct-chart4', {
        labels: ['1st','2nd', '3rd'],
        series: [
            
            [st1],
            [st2],
            [st3],

            
        ]
    }, { 
        seriesBarDistance: 50,
        reverseData: true,
        horizontalBars: true,
        axisY: {
            offset: 25
        }
    });

   
});