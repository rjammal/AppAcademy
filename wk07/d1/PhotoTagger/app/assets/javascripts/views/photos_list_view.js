PhotoTagger.PhotoListView = function(photos) {
    this.photos = photos;
    this.$el = $('<div>');
    var that = this;
    PhotoTagger.Photo.on("add", function() {
        that.render();
    });
}

_.extend(PhotoTagger.PhotoListView.prototype, {
    render: function () {
        var $ul = $('<ul>')
        this.photos.forEach(function(photo) {
            var $li = $('<li>')
            $li.text(photo.attributes.title)
            $ul.append($li)
        })
        
        this.$el.html($ul);
        return this;
    }
})