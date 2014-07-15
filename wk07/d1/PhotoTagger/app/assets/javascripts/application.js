// This is a manifest file that'll be compiled into application.js,
// which will include all the files listed below.
//
// Any JavaScript/Coffee file within this directory,
// lib/assets/javascripts, vendor/assets/javascripts, or
// vendor/assets/javascripts of plugins, if any, can be referenced
// here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll
// appear at the bottom of the the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE
// PROCESSED, ANY BLANK LINE SHOULD GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.serializeJSON
//= require underscore
//
//= require_tree ./models
//= require_tree ../templates
//= require_tree ./views
//
//= require_tree .

PhotoTagger.initialize = function() {
    var photos = [];
    
    $(function() {
        PhotoTagger.Photo.fetchByUserID(currentUserId, function() {
            var photoView = new PhotoTagger.PhotoListView(PhotoTagger.Photo.all);
            $('div#content').html(photoView.render().$el)
            var photoFormView = new PhotoTagger.PhotoFormView();
            $('div#content').append(photoFormView.render().$el);
        });
    })
}