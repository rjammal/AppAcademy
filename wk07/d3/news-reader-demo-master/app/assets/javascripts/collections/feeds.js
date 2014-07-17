NewReader.Collections.Feeds = Backbone.Collection.extend({
  url: "api/feeds", 
  model: NewReader.Models.Feed,
  
  getOrFetch: function(id) {
    var feeds = this; 
    
    var feed = this.get(id);
    if (feed){
      return feed; 
    } else {
      var newFeed = new NewReader.Models.Feed({
        id: id
      });
      newFeed.fetch({
        success: function(){
          feeds.add(newFeed);
        }
      });
      return newFeed; 
    }
  }
});
