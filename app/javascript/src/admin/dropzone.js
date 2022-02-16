import Dropzone from "dropzone";

Dropzone.options.dropzoneform = {
  url: "/admin/bulk_upload",
  addRemoveLinks: true,
  autoQueue: false,
  autoProcessQueue: false,
  uploadMultiple: true,
  parallelUploads: 100,
  maxFiles: 100,paramName: 'file',
  dictDefaultMessage: 'Drag an image here to upload, or click to select one',
  init: function() {
    this.on('success', function(file, resp){
      console.log(file);
      console.log(resp);
    });
    this.on('thumbnail', function(file) {
      if (file.accepted !== false) {
        if (file.width < 640 || file.height < 480) {
          file.rejectDimensions();
        }
        else {
          file.acceptDimensions();
        }
      }
    });
    this.on("addedfile", file => {
      console.log(`File added: ${file.name}`);
    });
    this.on('sending', function(file, xhr, formData) {
      console.log('sending')
    });
  },
  accept: function(file, done) {
    file.acceptDimensions = done;
    file.rejectDimensions = function() {
      done('The image must be at least 640 x 480px')
    };
  }
};




// NOT WORKING
// const newDropzone = new Dropzone("#uploadForm", {
// const newDropzone = Dropzone.options.uploadForm = {
//   url: "/admin/bulk_upload",
//   addRemoveLinks: true,
//   autoQueue: false,
//   autoProcessQueue: false,
//   uploadMultiple: true,
//   parallelUploads: 100,
//   maxFiles: 100,
//   previewsContainer: '#dz-preview-container',

//   init: function() {
//     // var myDropzone = this;
//     console.log("FIRED!")
    
//     var form = document.getElementById('uploadForm');
//     form.addEventListener('submit', function(e) {
//       // stop the form's submit event
//       // this.element.querySelector("button[type=submit]").addEventListener("click", function(e) {
//       // if(this.getQueuedFiles().length > 0){
//         e.preventDefault();
//         // e.stopPropagation();
//         debugger
//         this.processQueue();
//         console.log('hello')
//       // }
//     });

//     this.on("addedfile", file => {
//       console.log(`File added: ${file.name}`);
//     });
//     this.on('sending', function(file, xhr, formData) {
//       console.log('hey')
//     });

    
//     this.on("sendingmultiple", function(file, xhr, formData) {
//       console.log('send multiple')
//       formData.append("site_id", $('#myDropzoneForm_site_id').val());
      
//       var reliable = $('#tpl').find('#reliable').is(':checked')
//       var date = $('#tpl').find('#record_taken').val()
//       var submittedAt = $('#tpl').find('#submitted_at').val()
//       var typeName = $('#tpl').find('#type_name').val()
      
//       var participantId = $('#tpl').find('#participant_id').val()
//       var comment = $('#tpl').find('#comment').val()
      
//       formData.append('reliable', reliable);
//       formData.append('record_taken', date);
//       formData.append('submitted_at', submittedAt);
//       formData.append('type_name', typeName);
//       formData.append('comment', comment);
//       formData.append('participant_id', participantId);
//     });
    
//     this.on("successmultiple", function(data,response) {
//       $('#tpl').toggleClass('hidden')
//       $('#response').toggleClass('hidden')
      
//       var textnode = document.createTextNode(response);
//       var div = document.getElementById('response')
//       div.innerHTML += response.toString()
//     });
//   }
// }
// // });
// export default newDropzone

