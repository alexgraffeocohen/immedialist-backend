import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  item: DS.belongsTo('item', { polymorphic: true, async: true }),
  itemType: DS.attr('string'),
  search: DS.belongsTo('search', { async: true })
});
