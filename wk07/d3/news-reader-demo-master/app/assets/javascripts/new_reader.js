window.NewReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function() {

    NewReader.feeds = new NewReader.Collections.Feeds(); 
    NewReader.feeds.fetch();
    
    var $rootEl = $("#content");
    new NewReader.Routers.AppRouter({
      $rootEl: $rootEl
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewReader.initialize();
});
