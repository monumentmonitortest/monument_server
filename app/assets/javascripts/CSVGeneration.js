core.CsvReports = {};

$(document).on("ready page:load", function() {
  if ($('h2#csv-reports').size() > 0) {
    core.CsvReports.readySiteReport();
    core.CsvReports.changeURL()
  } 
});


core.CsvReports.readySiteReport = function() {
  $( "select.site-select" ).change(function(e) {
    core.CsvReports.changeURL()
  });

  $( "input.from-date" ).change(function(e) {
    core.CsvReports.changeURL()
  });

  $( "input.to-date" ).change(function(e) {
    core.CsvReports.changeURL()
  });
} 

core.CsvReports.changeURL = function(e) {
  var id = $('select#site_id').children("option:selected").val()
  var fromDate = $('input.from-date').val()
  var toDate = $('input.to-date').val()
  
  var href = $( "#site-specific-report" ).attr("href")
  
  var newLink = href.split('?')[0] + '?site_id=' + id + '&from_date=' + fromDate + '&to_date=' + toDate
  $( "#site-specific-report" ).attr("href", newLink)
}