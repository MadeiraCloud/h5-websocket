@user_collection = new Meteor.Collection("user");

class @UserPublisher extends Publisher

	constructor :->

		super "user"

	publishCall : ( username, session_id ) ->

		check username, String

		check session_id, String

		@onStop stopFunc = () =>

			clearInterval @interval

		sessionVerify this, username, session_id, return_call = (true_or_false) =>

			if true_or_false == true

				console.info "Open user subscription for session #{session_id}, user #{username}"

				query = {

							'username'  : username,

						}

				user_collection.find(
					query
					{
						fields:
							{
								'payment_state'	:	1,
								'username'	:	1,
								'has_card'	:	1,
								'current_quota'	:	1

							}
					}
				)

			else

				@error( new Meteor.Error( 404, ERROR_CODE.INVALID_SESSION, ERROR_CODE.INVALID_SESSION_DETAIL ) )