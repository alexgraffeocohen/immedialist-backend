import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  listItem: DS.belongsTo('listItem'),
  type: DS.attr('string')
});
