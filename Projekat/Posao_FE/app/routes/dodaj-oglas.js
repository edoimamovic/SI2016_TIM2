import Ember from 'ember';

export default Ember.Route.extend({
	templateService: Ember.inject.service('template-service'),
	kategorijaService: Ember.inject.service(),
	lokacijaService: Ember.inject.service(),
	session: Ember.inject.service('session'),

	beforeModel: function(transition) {

		if(!this.get('session.isAuthenticated') || (this.get('session.data.authenticated.role') !== "ROLE_POSLODAVAC" )) {
			return this.transitionTo("unauthorized");
		}
	},

	model: function(params, transition) {
		return Ember.RSVP.hash({
        	templatei: this.get("templateService").all(),
	        lokacije: this.get('lokacijaService').all(),
			kategorije: this.get('kategorijaService').all(),

    	})
	}
});
