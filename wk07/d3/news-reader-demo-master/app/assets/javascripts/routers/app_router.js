NewReader.Routers.AppRouter = Backbone.Router.extend({
  initialize: function(options){
    this.$rootEl = options.$rootEl;
  },
  
  routes: {
    "": "feedIndex", 
    "feeds/:id": "feedShow"
  },
  
  feedIndex: function () {
    
    NewReader.feeds.fetch()
    
    var indexView = new NewReader.Views.FeedIndexView({
      collection: NewReader.feeds
    });
    this._swapView(indexView);
  }, 
  
  feedShow: function(id){
    
    var feed = NewReader.feeds.getOrFetch(id);
    feed.fetch();
    var showView = new NewReader.Views.FeedShowView({feed: feed}); 
    this._swapView(showView);
  },
  
  _swapView: function(view){
    this.currentView && this.currentView.remove();
    this.currentView = view; 
    this.$rootEl.html(this.currentView.render().$el)
  }
  
  
});