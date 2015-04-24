import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  mediaType: DS.attr('string'),
  listItems: DS.hasMany('list-item'),

  className: function() {
    return this.get('constructor.typeKey');
  }.property('constructor')
});
