
$(document).ready(function(){ 
  readyCSVExport();
 }) 

function readyCSVExport() {
  $( ".js-csv" ).click(function(e) {
    e.preventDefault()
    var options = $( ".image-options").val()
    var reliable = $( "input:checkbox").first().attr("value")

    $.ajax({
      url: "results",
      type: 'POST',
      data: { filter: options, reliable_filter: reliable },
      dataType: 'text',
      success: function(result) {
        var uri = 'data:application/csv;charset=UTF-8,' + encodeURIComponent(result);
        window.open(uri, 'site-data.csv');
      }
  });
    alert( "CSV download complete (disable popups if it hasn't)" );
  })
}