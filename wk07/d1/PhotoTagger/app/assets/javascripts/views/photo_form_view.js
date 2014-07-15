PhotoTagger.PhotoFormView = function () {
    this.template = JST["photo_form"]
    
    this.$el = $('<div>');
    
    var view = this;
    this.$el.on('submit', function(event) {
        view.submit(event);
    });
}

_.extend(PhotoTagger.PhotoFormView.prototype, {
    
    render: function() {
        this.$el.html(this.template())
        return this;
    }, 
    
    submit: function(event) {
        event.preventDefault();
        var photo = new PhotoTagger.Photo($('#photo_form').serializeJSON());
        photo.save(function() {
            console.log('saved!');
            $('#photo_form')[0].reset();
        });
    }
});

