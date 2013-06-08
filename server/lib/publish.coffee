class @Publisher 

	constructor : (@publish_name) ->		

	publishCall : ->

	publish :-> 

		console.info "Publish open for: " + @publish_name

		Meteor.publish @publish_name, @publishCall
