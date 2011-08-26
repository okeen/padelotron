$(function(){
    GameEvent = Backbone.Model.extend({
        initalize: function(){
            _.bindAll(this,[]);
        }
    });
    GameEventsController = Backbone.Collection.extend({
        model: GameEvent,
        place_id: $("input[name='init_place_id']")[0].value,
        url: function(){
            return '/customers/agenda/games.json';
        },
        comparator: function(todo) {
            return todo.get('play_date');
        }
    });
    window.GameEvents = new GameEventsController();

    GameEventView = Backbone.View.extend({
        initialize: function() {
            this.model.bind('change', this.render, this);
        },
        render: function() {
            return this;
        }
    });

    ShowCustomerAgendaView= Backbone.View.extend({
        el: $("div#main_panel"),
        events: {
        },
        initialize: function() {
            GameEvents.bind('add',   this.addGameEvent, this);
            GameEvents.bind('reset', this.resetGameEvents, this);
            scheduler.init('scheduler',null,"day");
            scheduler.config.api_date=""

            GameEvents.fetch({
                data: {
                    place_id: GameEvents.place_id
                    }
                });
    },
    render: function() {
        },
        addGameEvent: function(event){
            var conversor= scheduler.date.str_to_date("%Y-%m-%dT%H:%i:%sZ");
            var start_date = conversor(event.get('play_date').replace("Z", " ").replace("T", " "));
            var end_date = scheduler.date.add(start_date, 1, "hour");

            scheduler.addEvent({
                start_date: start_date,
                end_date: end_date,
                id: event.get("id"),
                text:event.get('description'),
                custom_data:"some data"
            });
        },
        resetGameEvents: function(){

        }
    });
Backbone.sync= function(method, model, options){
    if (method == "read"){
        $.ajax({
            url: "/customers/agenda/games.json",
            data: options.data,
            type: "GET",
            success: function(data,response){
                console.log("Customers:Agenda got games:" + data.length);
                var returningList= [];
                for (var i=0; i< data.length; i++){
                    var event= data[i];
                    console.log("Customers:Agenda processing Event" + event.id);
                    window.GameEvents.add(new GameEvent(event));
                }

            },
            error: function(event,response){
                console.log("Customers:Agenda read error:" + response);
                var data = JSON.parse(response.responseText);
                if (response.status == 200){
                    try {
                        if (data.model){
                            return;
                        }
                    }
                    catch(ex){
                        console.debug("Maybe actually something DID go wrong..." + ex);
                    }
                }
            }
        })
    }
}
window.App = new ShowCustomerAgendaView();
    })
