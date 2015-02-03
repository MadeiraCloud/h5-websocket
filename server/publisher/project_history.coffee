@history_collection = new Meteor.Collection("project_history");

class @HistoryPublisher extends Publisher

	constructor :->

		super "history"

	publishCall : ( username, session_id, project_id ) ->

		check username, String

		check session_id, String

		check project_id, String

		@onStop stopFunc = () =>

			clearInterval @interval

		sessionVerify this, username, session_id, return_call = (true_or_false) =>

			if true_or_false == true

				console.info "Open project history subscription for session #{session_id}, user #{username}, project_id #{project_id}"

				user_info = user_collection.findOne({
						'username': username
					},{
						fields:	{
							'id'	:	1
						}
					})

				allow_history_type = []

				admin_query = project_collection.findOne(
					{
						'id'  : project_id,
						'members.id': {
							'$in': [
								user_info['id']
								]
						},
						'members.role': {
							'$in': [
								'admin'
							]
						}
					}
					{
						fields:
							{
								'id'		:	1,
							}
					}
				)
				if not admin_query
					user_query = project_collection.findOne(
						{
							'id'  : project_id,
							'members.id': {
								'$in': [
									user_info['id']
								],
							},
							'members.role': {
								'$in': [
									'admin'
								]
							}
						}
						{
							fields:
								{
									'id'		:	1,
								}
						}
					)
					if user_query
						allow_history_type = ['stack', 'app']
					else
						@error( new Meteor.Error( 404, ERROR_CODE.INVALID_SESSION, ERROR_CODE.INVALID_SESSION_DETAIL ) )

				else
					allow_history_type = ['stack', 'app', 'member', 'payment', 'credential', 'token', 'project']

				timestamp = Math.round(new Date().getTime()/1000) - 86400*7
				console.info(timestamp)
				history_collection.find(
					{
						'project_id'  : project_id,
						'type': {
							'$in': allow_history_type,
						},
						'time' : {'$gt' : timestamp}
					}
				)

			else

				@error( new Meteor.Error( 404, ERROR_CODE.INVALID_SESSION, ERROR_CODE.INVALID_SESSION_DETAIL ) )