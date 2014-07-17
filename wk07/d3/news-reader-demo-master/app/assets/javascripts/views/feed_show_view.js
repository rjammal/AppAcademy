NewReader.Views.FeedShowView = Backbone.View.extend({

  initialize: function (options) {
    //this.entryView = new NewReader.Views.
    this.feed = options.feed;
    this.listenTo(
      this.feed, 
      "sync", 
      this.render
    );
  },
  
  events: {
    "click #refresh": "refresh"
  },

  template: JST["feed_show"], 
  
  render: function () {
    var renderedContent = this.template({
      feed: this.feed
    });
    this.$el.html(renderedContent);
    
    return this;
  },
  
  refresh: function (event) {
    event.preventDefault();
    this.feed.fetch();
  }
  
});