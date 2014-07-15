var PhotoTagger = window.PhotoTagger = (window.PhotoTagger || {})

PhotoTagger.Photo = function (data) {
   this.attributes = _.extend({}, data);
};

_.extend(PhotoTagger.Photo.prototype, {
   
   get: function(name) {
       return this.attributes[name];
   },

   set: function(name, val) {
       this.attributes[name] = val;
       return this.attributes[name];
   },

   create: function(callback) {
       var that = this;
       if (typeof this.attributes.id === 'undefined') {
           $.ajax({
               url: "/api/photos",
               type: "post",
               data: { photo: this.attributes },
               success: function (photo) {
                   _.extend(that.attributes, photo);
                   PhotoTagger.Photo.allObj[that.attributes.id] = that;
                   PhotoTagger.Photo.populateAllArray();
                   PhotoTagger.Photo.trigger("add");
                   callback(that);
               }
           })
       } else {
           console.log("Already exists");
       }
   },

   save: function(callback) {
       if (typeof this.attributes.id === 'undefined') {
           this.create(callback)
       } else {
           var that = this;
           $.ajax({
               url: "/api/photos/" + this.attributes.id,
               type: "patch",
               data: { photo: this.attributes },
               success: function (photo) {
                   _.extend(that.attributes, photo);
                   callback(that);
               },
           })
       }
   }
});

_.extend(PhotoTagger.Photo, {

    fetchByUserID: function(userId, callback) {
       var that = this;
       $.ajax({
          url: "/api/users/" + userId + "/photos",
          type: "get",
          success: function (photos) {
              var photoObjects = photos.map(function(photo) {
                 return new PhotoTagger.Photo(photo); 
              });
              photoObjects.forEach(function(p) {
                  PhotoTagger.Photo.all[p.attributes.id] = p;
              });
              PhotoTagger.Photo.populateAllArray();
              callback();
          }
       });
    },
    
    allObj: {}, 
    
    all: [],
    
    populateAllArray: function() {
        var result = [];
        for (var key in this.all) {
            result.push(this.all[key]);
        }
        this.all = result;
    },
    
    _events: {}, 
    
    on: function(eventName, callback) {
        this._events[eventName] = this._events[eventName] || [];
        this._events[eventName].push(callback);
    },
    
    trigger: function(eventName) {
        this._events[eventName].forEach(function(callback) {
            callback(); 
        });
    }
});
