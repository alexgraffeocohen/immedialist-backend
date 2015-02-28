import Ember from 'ember';

export default Ember.ArrayController.extend({
  actions: {
    createListItem: function() {
      var listItemAttrs = this.get('listItemAttrs');
      var typeForForm = listItemAttrs.type;
      var listItem = this.store.createRecord('listItem', listItemAttrs);
      this.set('listItemAttrs', {type: typeForForm});
      listItem.save();
    }
  },
  listItemAttrs: {},
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
