NewReader.Collections.Entries = Backbone.Collection.extend({
  
  model: NewReader.Models.Entry,
  
  initialize: function(models, options) {
    this.feed = options.feed;
  },
  
  url: function () {
    return this.feed.url() + "entries";
  }, 
  
  comparator: function(entry1, entry2){
    if (entry1.get("published_at") < entry2.get("published_at")){
      return 1;
    } else if (entry1.get("published_at") > entry2.get("published_at")){
      return -1;
    } else {
      return 0;
    }
  }
});

