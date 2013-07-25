@stack_collection = new Meteor.Collection("stack");

class @StackPublisher extends Publisher

	constructor :->

		super "stack"

	publishCall : ( username, session_id, region ) ->

		check username, String

		check session_id, String

		@onStop stopFunc = () =>

			clearInterval @interval

		sessionVerify this, username, session_id, return_call = (true_or_false) => 

			if true_or_false == true 

				console.info "Open stack subscription for session #{session_id}, user #{username}"

				query = {
							
							'username'  : username,
							'state'     : {
								'$ne'   : STACK_STATE.STATE_STACK_REMOVED
							}
							
						}
						
				if region

					query.region = region

				stack_collection.find(
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
							}
					}
				)

			else

				@error( new Meteor.Error( 404, ERROR_CODE.INVALID_SESSION, ERROR_CODE.INVALID_SESSION_DETAIL ) )