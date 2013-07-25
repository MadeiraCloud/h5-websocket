@app_collection = new Meteor.Collection("app");

class @AppPublisher extends Publisher

	constructor :->

		super "app"

	publishCall : ( username, session_id, region ) ->

		check username, String

		check session_id, String

		@onStop stopFunc = () =>

			clearInterval @interval

		sessionVerify this, username, session_id, return_call = (true_or_false) => 

			if true_or_false == true 

				console.info "Open app subscription for session #{session_id}, user #{username}"

				query = {
							
							'username'	: username,
							'state'		: {
								'$nin'	: [
									APP_STATE.STATE_APP_TERMINATED,
									APP_STATE.STATE_APP_CANCELLED
								]
							}
						}
						
				if region

					query.region = region

				app_collection.find(
					query
					{
						fields: 
							{
								'description'	:	1
								'time_create'	:	1
								'region'		:	1
								'state'			:	1
								'time_update'	:	1
								'version'		:	1
								'property'		:	1
								'id'			:	1
								'name'			:	1
								'owner'			:	1
								'stack_id'		:	1
							}
					}
				)

			else

				@error( new Meteor.Error( 404, ERROR_CODE.INVALID_SESSION, ERROR_CODE.INVALID_SESSION_DETAIL ) )