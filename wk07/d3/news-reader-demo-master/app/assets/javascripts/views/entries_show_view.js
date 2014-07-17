NewReader.Views.EntryShowView = Backbone.View.extend({
  
  initialize: function(options) {
    this.entry = options.entry;
  },
  
  tagName: "li", 
  
  className: "entries",
  
  template: JST["entry_show"],
  
  render: function () {
    var renderedContent = this.template({entry: this.entry});
    this.$el.html(renderedContent);
    return this;
  }
  
});