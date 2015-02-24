import Ember from 'ember';

export default Ember.ArrayController.extend({
  actions: {
    createListItem: function(newListItem) {
      var listItem = this.store.createRecord('listItem', newListItem);
      this.set('newListItem', {type: newListItem.type});
      listItem.save();
    }
  },
  newListItem: {},
  types: [
    "movie",
    "actor",
    "director",
    "song",
    "album",
    "artist",
    "book",
    "author"
  ]
});
