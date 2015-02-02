@project_collection = new Meteor.Collection("project");

class @ProjectPublisher extends Publisher

	constructor :->

		super "project"

	publishCall : ( username, session_id, project_id ) ->

		check username, String

		check session_id, String

		check project_id, String

		@onStop stopFunc = () =>

			clearInterval @interval

		sessionVerify this, username, session_id, return_call = (true_or_false) =>

			if true_or_false == true

				console.info "Open project subscription for session #{session_id}, user #{username}"

				user_info = user_collection.findOne({
						'username': username
					},{
						fields:	{
							'id'	:	1
						}
					})

				query = {
							'id'  : project_id,
							'members.id': {
		                        '$in': [
		                            user_info['id']
		                        ],
		                    },
						}

				project_collection.find(
					query
					{
						fields:
							{
								'payment'	:	1,
								'members'	:	1,
								'state'		:	1,
								'name'		:	1,
								'id'		:	1,
								'credentials.id':1,
								'credentials.is_demo':1,
								'credentials.provider':1,
								'credentials.aliases':1,
								'tokens'	:	1
							}
					}
				)

			else

				@error( new Meteor.Error( 404, ERROR_CODE.INVALID_SESSION, ERROR_CODE.INVALID_SESSION_DETAIL ) )