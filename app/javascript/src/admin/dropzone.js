import Dropzone from "dropzone";

if (document.getElementById('bulk-upload')) {
  readyBulkUpload();
  readyAutoParticipantFill()
  readyAutoDateFille()
}

if (document.getElementById('drop-upload')) {
  readyDropUpload();
}

// ------------ ********* --------------
// Dropzone for drop upload
// ------------ ********* --------------
function readyDropUpload() {
  const newDropzone = new Dropzone("#simpledropzone", {
    url: "/admin/drop_upload",
    acceptedFiles: ".jpg, .jpeg",

    init: function() {
      var myDropzone = this

      this.on("success", function(data,response) {
        var filename = data['upload']['filename']
        var textnode = document.createTextNode(response);

        var div = document.getElementById('response')
        div.innerHTML += filename + ": " + response.toString() + "<br/>"
      });

      this.on("error", function(data,response) {
        var filename = data['upload']['filename']
        var textnode = document.createTextNode(response);
        var div = document.getElementById('error')
        div.innerHTML += filename + ": " + response.toString() + "<br/>"
      });
    }
  });
}


// ------------ ********* --------------
// Dropzone for old bulk upload
// ------------ ********* --------------
function readyBulkUpload() {
  const bulkDropzone = new Dropzone("#bulkdropzone", {
    url: "/admin/bulk_upload",
    autoProcessQueue: false,
    autoQueue: true,
    uploadMultiple: true,
    parallelUploads: 2,
    maxFiles: 100,
    ignoreHiddenFiles: true,
    // acceptedFiles: '*.jpg',
    previewsContainer: '#dz-preview-container',
  
    init: function() {
      var myDropzone = this;
      console.log('initialized bulk dropzone')
      var form = document.getElementById('bulkdropzone');
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
}


function readyAutoParticipantFill() {
  document.getElementById('participant_id').addEventListener('change', (e) => {
    console.log(e)
    console.log(this.value)
    if (this.value.includes("@")) {
      document.getElementById("type_name option[value='EMAIL']").attr("selected", true);
    } else if (this.value.includes("+")) {
      document.getElementById("type_name option[value='WHATSAPP']").attr("selected", true);
    } else {
      return true
    }
 });
}

function readyAutoDateFille() {
  document.getElementById('record_taken').addEventListener('change', (e) => {
    document.getElementById('submitted_at').val(this.value)
  })
}