Journal.Views.PostsIndex = Backbone.View.extend({
  template: JST["posts_index"], 
  
  initialize: function() {
    var view = this;
    this.listenTo(this.collection, "sync", this.render)
  },
    
  events: {
    "click button.delete": "deleteClicked"
  },
  
  render: function() {
    var renderedContent = this.template({
      posts: this.collection
    });
    
    this.$el.html(renderedContent)
    return this;
  },
  
  deleteClicked: function(event){
    alert('delete clicked');
  }
})