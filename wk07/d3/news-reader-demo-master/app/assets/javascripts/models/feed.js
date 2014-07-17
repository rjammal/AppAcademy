NewReader.Models.Feed = Backbone.Model.extend({

  urlRoot: "api/feeds",

  entries: function() {
    this._entries =   this._entries || 
                      new NewReader.Collections.Entries([], {feed: this});
    return this._entries;
  },
  
  parse: function(response) {
    var entries = response.latest_entries
    if (entries){
      this.entries().set(entries, {parse: true});
      delete response.latest_entries;
    }
    
    return response;
  }
});