import Ember from 'ember';

export default Ember.ObjectController.extend({
  typeIcon: function() {
    switch(this.get('model.type')) {
      case "movie":
        return "fa-film"
      break;
      case "actor":
        return "fa-user"
      break;
      case "song":
        return "fa-music"
      break;
    }
  }.property('model.type'),
  typeColor: function() {
    switch(this.get('model.type')) {
      case "movie":
        return "list-group-item-info"
      break;
      case "song":
        return "list-group-item-success"
      break;
    }
  }.property('model.type')
});
