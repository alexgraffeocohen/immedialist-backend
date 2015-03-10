import Ember from 'ember';

export default Ember.ArrayController.extend({
  actions: {
    createListItem: function() {
      var listItemParams = this.get('listItemAttrs'),
      item = this.store.createRecord(
        listItemParams.itemType.toLowerCase(), {name: listItemParams.name}
      ),
      typeForForm = listItemParams.itemType,
      listItem = this.store.createRecord('listItem', listItemParams);
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
