import Ember from 'ember';

export default Ember.Controller.extend({
	oglasiService: Ember.inject.service('oglasi-service'),
	session: Ember.inject.service(),
    noviDatumIsteka: null,
    prijavaSuccess: false,
    prijavaError: false,
    reopenSuccess: false,
    reopenError: false,
    zatvaranjeSuccess: false,
    zatvaranjeError: false,

	prijava: function(korisnik, oglas) {
        var self = this;

        return this.get('oglasiService').prijava(korisnik, oglas).then(x => {
            self.set("prijavaSuccess", true);
            self.set("prijavaError", false);

            self.set("zatvaranjeSuccess", false);
            self.set("zatvaranjeError", false);
            self.set("reopenSuccess", false);
            self.set("reopenError", false);

            self.set("model.imaprijava", true)}).catch(err => {
                self.set("prijavaSuccess", false);
                self.set("prijavaError", true);

                self.set("zatvaranjeSuccess", false);
                self.set("zatvaranjeError", false);
                self.set("reopenSuccess", false);
                self.set("reopenError", false);
            });
    },

    delete: function(oglasId) {
        return this.get('oglasiService').delete(oglasId);
    },

    zatvori: function(oglasId) {
        return this.get('oglasiService').zatvori(oglasId);
    },

    reopen: function(oglasId, brojDana) {
        var self = this;
        this.get('oglasiService').reopen(oglasId, brojDana).then(x => {
            self.set("reopenSuccess", true);
            self.set("reopenError", false);
            self.set("datumError", false);
            self.set("model.oglas.zatvoren", 0);

            self.set("zatvaranjeSuccess", false);
            self.set("zatvaranjeError", false);
            self.set("prijavaSuccess", false);
            self.set("prijavaError", false);

        }).catch(err => {
            self.set("reopenError", true);
            self.set("reopenSuccess", false);
            self.set("datumError", false);

            self.set("zatvaranjeSuccess", false);
            self.set("zatvaranjeError", false);
            self.set("prijavaSuccess", false);
            self.set("prijavaError", false);            
        });
    },

    actions: {
    	prijava: function(oglasId){
			let korisnikId = this.get("session.data.authenticated.userid");
			this.prijava(korisnikId, oglasId);
    	},

    	delete: function(){
            var self = this;

		    let oglasId = this.get("model.oglas.idOglasa");
            this.delete(oglasId).then(x => {
                self.transitionToRoute('index');
            });
    	},

        zatvori: function(){
            var self = this;

            let oglasId = this.get("model.oglas.idOglasa");
            this.zatvori(oglasId).then(x => {
                self.set('model.oglas.zatvoren', 1);
                self.set("zatvaranjeSuccess", true);
                self.set("zatvaranjeError", false);

                self.set("reopenSuccess", false);
                self.set("reopenError", false);
                self.set("prijavaSuccess", false);
                self.set("prijavaError", false);

            }).catch(err => {
                self.set("zatvaranjeSuccess", false);
                self.set("zatvaranjeError", true);
                self.set("reopenSuccess", false);
                self.set("reopenError", false);
                self.set("prijavaSuccess", false);
                self.set("prijavaError", false);
            });
        },

        reopen: function(){
            let oglasId = this.get("model.oglas.idOglasa");
            let noviDatum = this.get("noviDatumIsteka");
            this.reopen(oglasId, noviDatum);
        },
    }
});