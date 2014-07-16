Journal.Views.PostShow = Backbone.View.extend({
  template: JST["post_show"], 
  
  initialize: function (options) {
    this.post = options.post;
  },
  
  render: function() {
    this.$el.html(this.template({
      post: this.post
    }));
    return this;
  }

});