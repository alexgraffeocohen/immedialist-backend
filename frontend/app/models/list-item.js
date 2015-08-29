import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  item: DS.belongsTo('item', { polymorphic: true, async: true }),
  search: DS.belongsTo('search', { async: true }),
  resolved: DS.attr('boolean'),

  mediaType: function() {
    return this.get('item.mediaType');
  }.property('item'),
  itemClass: function() {
    return this.get('item.className');
  }.property('item')
});
