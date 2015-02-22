import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  type: DS.attr('string')
}).reopenClass({
  FIXTURES: [
    { id: 1, name: "Die Hard", type: "movie" },
    { id: 2, name: "More Than a Feeling", type: "song" },
    { id: 3, name: "Edward Norton", type: "actor" }
  ]
});
