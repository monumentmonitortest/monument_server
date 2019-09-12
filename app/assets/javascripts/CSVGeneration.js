core.CsvReports = {};

$(document).on("ready page:load", function() {
  if ($('h2#csv-reports').size() > 0) {
    core.CsvReports.readySiteReport();
  } 
});


core.CsvReports.readySiteReport = function() {
  $( "select.site-select" ).change(function(e) {
    var id = $('select#site_id').children("option:selected").val()
    var href = $( "#site-specific-report" ).attr("href")
    var newLink = href.split('?')[0] + '?site_id=' + id
    $( "#site-specific-report" ).attr("href", newLink)
  });
} 