class @Publisher

	constructor : (@publish_name) ->

	publishCall : ->

	publish :->

		current_time = new Date()

		console.info "#{current_time}, Publish open for: " + @publish_name

		Meteor.publish @publish_name, @publishCall
