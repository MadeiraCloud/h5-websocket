@import_collection = new Meteor.Collection("imports");

class @ImportPublisher extends Publisher

	constructor :->

		super "imports"

	publishCall : ( username, session_id ) ->

		check username, String

		check session_id, String

		@onStop stopFunc = () =>

			clearInterval @interval

		sessionVerify this, username, session_id, return_call = (true_or_false) =>

			if true_or_false == true

				console.info "Open imports subscription for session #{session_id}, user #{username}"

				query = {

							'username'  : username
						}

				import_collection.find(
					query
				)

			else

				@error( new Meteor.Error( 404, ERROR_CODE.INVALID_SESSION, ERROR_CODE.INVALID_SESSION_DETAIL ) )