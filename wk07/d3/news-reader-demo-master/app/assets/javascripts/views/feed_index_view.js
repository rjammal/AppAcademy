NewReader.Views.FeedIndexView = Backbone.View.extend({
  
  initialize: function(){
    this.formView = new NewReader.Views.FeedFormView({
      collection: this.collection
    });
    
    this.listenTo(
      this.collection,
      "sync remove add",
      this.render
    );
  },
  
  events: {
    "click button.delete-feed": "deleteFeed"
  },
  
  template: JST['feed_index'], 
  
  render: function() {
    var renderedContent = this.template({
      feeds: this.collection
    });

    this.$el.html(renderedContent);
    
    var formContent = this.formView.render().$el;
    this.$el.append(formContent);
    this.formView.delegateEvents();
    
    return this;
  }, 
  
  deleteFeed: function(event) {
    event.preventDefault();
    var $button = $(event.currentTarget);
    var id = $button.data("feed-id");
    var feed = this.collection.get(id);
    feed.destroy();
  }
});

