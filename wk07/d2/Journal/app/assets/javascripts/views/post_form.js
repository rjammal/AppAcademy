Journal.Views.PostFormView = Backbone.View.extend({
  template: JST["post_form"],
  
  model: Journal.Models.Post,
  
  render: function() {
    this.$el.html(this.template({post: this.model}));
    return this;
  },
  
  events: {
    'click #post-form input[type="submit"]': "createPost" 
  },
  
  createPost: function(event) {
    event.preventDefault();
    var view = this;
    var formData = $('#post-form').serializeJSON();
    this.model.save({post: formData}, {
      success: function() {
        Backbone.history.navigate("", {trigger: true});
      }, 
      error: function(model, errors) {
        view.render().$el.prepend(
          errors.responseJSON.join("<br>")
        )
      }
    });
  }
});