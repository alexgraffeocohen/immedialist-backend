import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    deleteListItem: function() {
      var listItem = this.get('model');
      listItem.deleteRecord();
      listItem.save();
    }
  },
  mediaType: function() {
    return this.get('model.mediaType').toLowerCase();
  }.property('model.mediaType'),
  itemType: function() {
    return this.get('model.itemClass').dasherize();
  }.property('model.itemClass'),
  itemName: function() {
    return this.get('model.name').dasherize();
  }.property('model.name'),
  itemDOMID: function() {
    return "#" + this.get('itemName');
  }.property('model.name'),
  componentName: function() {
    return this.get('itemType') + '-detail';
  }.property('model.mediaType'),
  resolved: function() {
    return this.get('model.resolved');
  }.property('model.resolved'),
  typeIcon: function() {
    switch(this.get('mediaType')) {
      case "movie":
        return "fa-film"
      break;
      case "show":
        return "fa-video-camera"
      break;
      case "actor":
        return "fa-user"
      break;
      case "director":
        return "fa-user"
      break;
      case "author":
        return "fa-user"
      break;
      case "artist":
        return "fa-user"
      break;
      case "song":
        return "fa-music"
      break;
      case "album":
        return "fa-music"
      break;
      case "book":
        return "fa-book"
      break;
    }
  }.property('mediaType')
});
