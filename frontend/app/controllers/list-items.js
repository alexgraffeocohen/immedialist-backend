import Ember from 'ember';

export default Ember.ArrayController.extend({
  actions: {
    createListItem: function() {
      var store = this.store;
      var formParams = this.get('attributes');
      var requestedItem = this.store.createRecord(
        'requested-item', {name: formParams.name, mediaName: formParams.mediaType}
      );
      this.set('attributes', {mediaType: formParams.mediaType});
      requestedItem.save().then(function(item) {
        var listItem = store.createRecord(
          'listItem', {name: formParams.name, item: item}
        );
        listItem.save();
      });
    }
  },
  attributes: {},
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
