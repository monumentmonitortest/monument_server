// TODO - if page has class do this...
$(document).ready(function(){ 
  readyBulkUpload();
}) 

function readyBulkUpload() {
  Dropzone.options.filesField = {
    url: "/bulk_upload",
    addRemoveLinks: true,
    autoProcessQueue: false,
    uploadMultiple: true,
    accept: function(file, done) {
      $("div#files-field").css({"height": "auto"});
      done();
    },
    init: function() {
      var myDropzone = this;
  
      var form = document.getElementById('dropzone-form-id');
      form.addEventListener('submit', function(event) {
        // stop the form's submit event
        if(myDropzone.getQueuedFiles().length > 0){
          event.preventDefault();
          event.stopPropagation();
          myDropzone.processQueue();
        }
      });
  
      myDropzone.on("sendingmultiple", function(file, xhr, formData) {
        formData.append("site_id", $('#myDropzoneForm_site_id').val());
        
          var reliable = $('#tpl').find('#reliable').is(':checked')
          var date = $('#tpl').find('#record_taken').val()
          var typeName = $('#tpl').find('#type_name').val()
          
          var emailAddress = $('#tpl').find('#email_address').val()
          var number = $('#tpl').find('#number').val()
          var instaUsername = $('#tpl').find('#insta_username').val()
          var twitterUsername = $('#tpl').find('#twitter_username').val()
          
          formData.append('reliable', reliable);
          formData.append('date_taken', date);
          formData.append('type_name', typeName);
  
          formData.append('email_address', emailAddress);
          formData.append('number', number);
          formData.append('insta_username', instaUsername);
          formData.append('twitter_username', twitterUsername);
  
      });
    },
    successmultiple: function(data,response) {
      $('#tpl').toggleClass('hidden')
      $('#response').toggleClass('hidden')
      
      var textnode = document.createTextNode(response);
      var div = document.getElementById('response')
      div.innerHTML += response.toString()
    }
  };
}
