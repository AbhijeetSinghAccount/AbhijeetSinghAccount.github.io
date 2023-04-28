//Define countries boundry
//Define state boundry

var India=countries.filter(ee.Filter.eq('country_na', 'India'));

//Import Kerala shapefile
var Kerala=ee.FeatureCollection(table);
//Import rainfall data
var chirps=ee.ImageCollection('UCSB-CHG/CHIRPS/PENTAD')
.select('precipitation')
.filterBounds(Kerala);
var point=ee.Geometry.Point([76.271,10.850]);
var center=Map.setCenter(76.271,10.850);
var means=ee.ImageCollection(ee.List.sequence(1,12)
.map(function(m){
return chirps.filter(ee.Filter.calendarRange(m, m, 'month'))
  .mean()
  .set('month', m);
}));

var start=ee.Date('2018-01-01');
var months=ee.List.sequence(0,36);
var dates=months.map(function(index){
  return start.advance(index, 'month');
});

//Group by month, and then reduce within groups by mean()
//The result is an image collection with one image for each month

var byMonth=ee.ImageCollection.fromImages(
  dates.map(function(date){
    var begining=date;
    var end=ee.Date(date).advance(1,'month');
    var mean=chirps.filterDate(begining, end)
    .mean()
    .set('date', date);
    
    var month=ee.Date(date).getRelative('month','year').add(1);
    return mean.subtract(
      means.filter(ee.Filter.eq('month',month)).first())
      .set('date', date);
      
  }));
  
var rainfall_palette ='ff0000, ffffff, 0000ff';
Map.addLayer(
byMonth.first().clip(Kerala), {'min':-1, 'max':1, 'palette':rainfall_palette}, 'anomaly');

var chart= ui.Chart.image.series({
  imageCollection: byMonth,
  region: point,
  reducer:ee.Reducer.mean(),
  scale:10000,
  xProperty:'date'
});
  
   print(chart);
