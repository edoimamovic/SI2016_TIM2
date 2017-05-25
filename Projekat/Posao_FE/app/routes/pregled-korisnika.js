import Ember from 'ember';

export default Ember.Route.extend({

	korisnikService: Ember.inject.service('korisnik-service'),

	beforeModel: function(transition) {
		//console.log(this.get('session.data.authenticated.role'));
		//console.log(this.get('session.data.authenticated.role') !== "ROLE_POSLODAVAC");
		//console.log((!this.get('session.isAuthenticated' || (this.get('session.data.authenticated.role') !== "ROLE_POSLODAVAC" ))));

		if(!this.get('session.isAuthenticated') || (this.get('session.data.authenticated.role') !== "ROLE_POSLODAVAC" )) {
			return this.transitionTo("error");
		}
	},

	model: function(params, transition) {
		return Ember.RSVP.hash({
			korisnici: this.get("korisnikService").nezaposleni()
		});
	}
});
