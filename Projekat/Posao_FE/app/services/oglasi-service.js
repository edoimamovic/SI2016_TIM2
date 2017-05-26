import Ember from 'ember';
import BaseService from './base-service';
import Oglas from '../models/oglas';

export default BaseService.extend({
    timeService: Ember.inject.service('time-service'),

    all: function() {
        var oglasi = [];
        this.ajax({ url: `oglasi/all`, type: "GET"}).then(function(data) {
            data.forEach(function(oglas) {
                oglasi.addObject(Oglas.create(oglas));
            });
        });

        return oglasi;
    },

    details: function(id) {
        var oglas = Oglas.create({});
        this.ajax({ url: `oglasi/get?id=${id}`, type: "GET"}).then(function(data) {
            oglas.setProperties(data);
        });
        return oglas;        
    },

    my: function(id){
        var oglasi = [];
        this.ajax({ url: `oglasi/poslodavac?id=${id}`, type: "GET"}).then(function(data) {
            data.forEach(function(oglas) {
                oglasi.addObject(Oglas.create(oglas));
            });
        });

        return oglasi;
    },

    postavi: function(oglas) {
    return this.ajax({ url: `oglasi/postavioglas`, type: "POST", data: JSON.stringify(oglas)});
    },

    prijava: function(userid, adid) {
    return this.ajax({ url: `prijave/add?korisnik=${userid}&oglas=${adid}`, type: "POST", data: {}});
    },

    zatvori: function(id) {
    return this.ajax({ url: `oglasi/close?id=${id}`, type: "POST", data: {}});
    },

    delete: function(adid) {
    return this.ajax({ url: `oglasi/remove?id=${adid}`, type: "DELETE", data: {}});
    },

    search: function(name, kategorijaId, filter, asc){
        let query = "oglasi/search?";

        if (kategorijaId !== null && filter !== null){
            query = query + "idk=" + kategorijaId + "&idlok=" + filter;
            
            if (name !== null){
                query = query + "&name=" + name;
            }
        }
        else if (kategorijaId === null && filter !== null){
            query = query + "idlok=" + filter;

            if (name !== null){
                query = query + "&name=" + name;
            }
        }
        else if (kategorijaId !== null && filter === null){
            query = query + "idk=" + kategorijaId;

            if (name !== null){
                query = query + "&name=" + name;
            }
        }
        else if (name !== null){
            query = query + "name=" + name;
        }

        if (asc){
            if(name !== null || kategorijaId !== null || filter !== null){
                query = query + "&asc=true";
            }
            else
                query = query + "asc=true";
        }

        var oglasi = [];
        this.ajax({ url: query, type: "GET"}).then(function(data) {
            data.forEach(function(oglas) {
                oglasi.addObject(Oglas.create(oglas));
            });
        });

        return oglasi;
    }

});