import Ember from 'ember';

export default Ember.Component.extend({
  classNames: ['list-item__detail'],
  item: function() {
    return this.get('listItem.item');
  }.property('listItem')
});
