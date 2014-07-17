NewReader.Views.FeedFormView = Backbone.View.extend({
  
  template: JST["feed_form"],
  
  events: {
    "submit form": "createFeed"
  },
  
  render: function() {
    var renderedContent = this.template();
    
    this.$el.html(renderedContent);
    
    return this; 
  },
  
  createFeed: function(event) {
    event.preventDefault();

    $form = $(event.currentTarget); 
    formData = $form.serializeJSON();
    this.collection.create(formData);
    
  }
  
});