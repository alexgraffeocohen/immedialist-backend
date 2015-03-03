import Ember from 'ember';

export default Ember.ObjectController.extend({
  actions: {
    deleteListItem: function() {
      var listItem = this.get('model');
      listItem.deleteRecord();
      listItem.save();
    }
  },
  typeIcon: function() {
    switch(this.get('model.itemType').toLowerCase()) {
      case "movie":
        return "fa-film"
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
  }.property('model.itemType'),
  typeColor: function() {
    switch(this.get('model.itemType').toLowerCase()) {
      case "movie":
        return "list-group-item-info"
      break;
      case "song":
        return "list-group-item-success"
      break;
      case "album":
        return "list-group-item-success"
      break;
      case "book":
        return "list-group-item-danger"
      break;
      case "actor":
        return "list-group-item-warning"
      break;
      case "director":
        return "list-group-item-warning"
      break;
      case "author":
        return "list-group-item-warning"
      break;
      case "artist":
        return "list-group-item-warning"
      break;
    }
  }.property('model.itemType')
});
