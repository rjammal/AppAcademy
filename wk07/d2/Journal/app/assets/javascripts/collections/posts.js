Journal.Collections.Posts = Backbone.Collection.extend({
  url: function() {
    return "/api/posts";
  }, 
  model: Journal.Models.Post
  
});

Journal.Collections.posts = new Journal.Collections.Posts(); 