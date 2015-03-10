import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  listItem: DS.belongsTo('listItem'),
  items: DS.hasMany('item', { polymorphic: true, async: true })
});
