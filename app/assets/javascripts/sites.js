core.Sites = {};

$(document).on("ready page:load", function() {
  if ($('h3#site-info').size() > 0) {
    core.Sites.readySiteSubmissionTags()
  } 
});

core.Sites.readySiteSubmissionTags = function() {
  $('.tags').tagsInput();
}