@state_collection = new Meteor.Collection("status");

class @StatePublisher extends Publisher

	constructor :->

		super "status"

	publishCall : ( username, session_id ) ->

		check username, String

		check session_id, String

		@onStop stopFunc = () =>

			clearInterval @interval

		sessionVerify this, username, session_id, return_call = (true_or_false) =>

			if true_or_false == true

				console.info "Open status subscription for session #{session_id}, user #{username}"

				query = {
							'username'  : username
						}

				state_collection.find(
					query
					{
						fields:
							{
								'app_id'		:	1
								'res_id'		:	1
								'statuses'		:	1
								'waiting'		:	1
							}
					}
				)

			else

				@error( new Meteor.Error( 404, ERROR_CODE.INVALID_SESSION, ERROR_CODE.INVALID_SESSION_DETAIL ) )