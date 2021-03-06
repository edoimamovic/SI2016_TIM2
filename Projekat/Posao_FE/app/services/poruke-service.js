import BaseService from './base-service';
import Poruka from '../models/poruka';
import getTimeAgo from '../globals';

export default BaseService.extend({

    all: function(id) {
        var poruke = [];
        this.ajax({ url: `poruke/get?recipient=${id}`, type: "GET"}).then(function(data) {
            data.forEach(function(poruka) {
                poruka.vrijeme = getTimeAgo(poruka.vrijeme);
                poruke.addObject(Poruka.create(poruka));
            });
        });

        return poruke;
    },

    my: function(id) {
        var poruke = [];
        this.ajax({ url: `poruke/get/sender?sender=${id}`, type: "GET"}).then(function(data) {
            data.forEach(function(poruka) {
                poruka.vrijeme = getTimeAgo(poruka.vrijeme);
                poruke.addObject(Poruka.create(poruka));
            });
        });

        return poruke;
    },

    send: function(poruka) {
        return this.ajax({ url: `poruke/send`, type: "POST", data: JSON.stringify(poruka)});
    },

    getUnread: function(id){
        return this.ajax({ url: `poruke/unread?korisnik=${id}`, type: "GET"});
    },
});