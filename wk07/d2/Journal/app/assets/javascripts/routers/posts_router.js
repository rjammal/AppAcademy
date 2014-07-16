Journal.Routers.PostsRouter = Backbone.Router.extend({
  routes: {
    "": "postsIndex",
    "posts/new": "newPostForm", 
    "posts/:id/edit": "editPostForm",
    "posts/:id": "postShow", 
  },
  
  postsIndex: function() {
    Journal.Collections.posts.fetch();
    var view = new Journal.Views.PostsIndex({
      collection: Journal.Collections.posts
    });
    this._swapDisplay(view);
  },
  
  postShow: function(id) {
    var post = new Journal.Models.Post({
      id: id
    });
    var that = this;
    post.fetch({
      success: function(post) {
        var view = new Journal.Views.PostShow({
          post: post
        });
        that._swapDisplay(view);  
      }
    });
  },
  
  newPostForm: function() {
    var post = new Journal.Models.Post();
    var viewForm = new Journal.Views.PostFormView({model: post});
    this._swapDisplay(viewForm);
  }, 
  
  editPostForm: function(id) {
    var view = this;
    var post = new Journal.Models.Post({id: id});
    post.fetch({
      success: function () {
        var viewForm = new Journal.Views.PostFormView({model: post});
        view._swapDisplay(viewForm);
      }
    });
  },
  
  _swapDisplay: function(newView) {
    if(this.currentView) {
      this.currentView.remove();
    }
    this.currentView = newView;
    $('div#content').html(newView.render().$el);
  }
  
});