import Ember from 'ember';

export default Ember.ArrayController.extend({
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
