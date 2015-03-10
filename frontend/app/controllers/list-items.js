import Ember from 'ember';

export default Ember.ArrayController.extend({
  actions: {
    createListItem: function() {
      var listItemAttrs = this.get('listItemAttrs'),
      item = this.store.createRecord('movie', {
        name: listItemAttrs.name
      }),
      typeForForm = listItemAttrs.itemType,
      listItem = this.store.createRecord('listItem', listItemAttrs);
      listItem.set('item', item)
      this.set('listItemAttrs', {itemType: typeForForm});
      listItem.save();
    }
  },
  listItemAttrs: {},
  types: [
    "Movie",
    "Actor",
    "Director",
    "Song",
    "Album",
    "Artist",
    "Book",
    "Author"
  ]
});
