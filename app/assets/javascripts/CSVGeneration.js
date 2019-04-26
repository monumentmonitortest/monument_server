
$(document).ready(function(){ 
  readyCSVExport();
 }) 

function readyCSVExport() {
  $( ".js-csv" ).click(function(e) {
    e.preventDefault()
    var options = $( ".image-options").val()
    var reliable = $( "input:checkbox").first().attr("value")
    
    var pageURL = $(location).attr("href");
    var siteId = /sites\/(\d+)/.exec(pageURL)[1];

    $.ajax({
      url: "csv/results",
      type: 'POST',
      data: { filter: options, reliable_filter: reliable, site_id: siteId },
      dataType: 'text',
      success: function(result) {
        var uri = 'data:application/csv;charset=UTF-8,' + encodeURIComponent(result);
        window.open(uri, 'site-data.csv');
      }
  });
    alert( "CSV download complete (disable popups if it hasn't)" );
  })
}