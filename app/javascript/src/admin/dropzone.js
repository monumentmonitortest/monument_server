import Dropzone from "dropzone";

const newDropzone = new Dropzone("#dropzoneform", {
  url: "/admin/bulk_upload",
  autoProcessQueue: false,
  uploadMultiple: true,
  parallelUploads: 100,
  maxFiles: 100,
  previewsContainer: '#dz-preview-container',

  init: function() {
    var myDropzone = this;
    
    var form = document.getElementById('dropzoneform');
    form.addEventListener('submit', function(e) {
      e.preventDefault();
      myDropzone.processQueue();
    });

    this.on("addedfile", file => {
      console.log(`File added: ${file.name}`);
    });
    this.on('sending', function(file, xhr, formData) {
      console.log('hey')
    });

    
    this.on("sendingmultiple", function(file, xhr, formData) {
      console.log('send multiple')
      formData.append("site_id", $('#myDropzoneForm_site_id').val());
      
      var reliable = $('#tpl').find('#reliable').is(':checked')
      var date = $('#tpl').find('#record_taken').val()
      var submittedAt = $('#tpl').find('#submitted_at').val()
      var typeName = $('#tpl').find('#type_name').val()
      
      var participantId = $('#tpl').find('#participant_id').val()
      var comment = $('#tpl').find('#comment').val()
      
      formData.append('reliable', reliable);
      formData.append('record_taken', date);
      formData.append('submitted_at', submittedAt);
      formData.append('type_name', typeName);
      formData.append('comment', comment);
      formData.append('participant_id', participantId);
    });
    
    this.on("successmultiple", function(data,response) {
      $('#tpl').toggleClass('hidden')
      $('#response').toggleClass('hidden')
      
      var textnode = document.createTextNode(response);
      var div = document.getElementById('response')
      div.innerHTML += response.toString()
    });
  }
});

