@Request_collection = new Meteor.Collection("request");

class @RequestPublisher extends Publisher

	constructor :->

		super "request"

	publishCall : ( username, session_id, region ) ->

		check username, String

		check session_id, String

		#check region, String

		@onStop stopFunc = () =>

			clearInterval @interval

		sessionVerify this, username, session_id, return_call = (true_or_false) => 

			if true_or_false == true 

				console.info "Open subscription for session #{session_id}, user #{username}"

				query = {
							'$and'	: [	
									{'$or'	: [{'username':username}, {'owner':username}]},									
									{'code'	  : {'$nin'	:	[REQUEST_CODE.OPS_NOTIFY_EMAIL, REQUEST_CODE.OPS_APP_NOTIFY]}},
									{
										'$or' : [
											{'$or' : [{'state':REQUEST_STATE.STATE_OPS_PENDING}, {'state':REQUEST_STATE.STATE_OPS_INPROCESS}]},
											{
												'$and'	: [
													{'$or' : [{'state':REQUEST_STATE.STATE_OPS_DONE}, {'state':REQUEST_STATE.STATE_OPS_FAILED}]},
													{'time_update' : {'$gt' : Math.round(new Date().getTime()/1000) - 86400}}
												]
											}
										]
									}
								]
						}
						
				if region

					query['$and'].push {'region' : region}

				Request_collection.find(
					query
					{
						fields: 
							{
								'id'			:	1
								'code'			:	1
								'state'			:	1
								'data'			:	1
								'service'		:	1
								'resource'		:	1
								'rid'			:	1
								'brief'			:	1
								'time_submit'	:	1
								'time_begin'	:	1
								'time_end'		:	1
							}
					}
				)

			else

				@error( new Meteor.Error( 404, ERROR_CODE.INVALID_SESSION, ERROR_CODE.INVALID_SESSION_DETAIL ) )


class @RequestDetailPublisher extends Publisher

	constructor :->

		super "request_detail"

	publishCall : ( username, session_id, region, request_id ) ->

		check username, String

		check session_id, String

		check request_id, String

		@publish_name = "request_detail"

		#@onStop stopFunc = () =>

		#	clearInterval @interval

		sessionVerify this, username, session_id, return_call = (true_or_false) => 

			if true_or_false == true 

				query 	= 	Request_collection.find(
								{
									'id' 		: 	request_id
									'username' 	: 	username
									'region'	:	region
								}
								{
									fields	:	{
										'id'			:	1
										'dag.spec.history'	:	1
									}
									
								}
							)

				handler = 	query.observeChanges(
								{
								    changed: addFunc = (id, fields) ->

									    	self.changed @publish_name, request_id, {field: fields}

								}
							)

				# handle query and handler
				@added @publish_name, request_id, {field: query.fetch()[0]}

				@ready()

				@onStop stopFunc = () ->

					handler.stop()

					clearInterval @interval

			else

				@error( new Meteor.Error( 404, ERROR_CODE.INVALID_REQUEST, ERROR_CODE.INVALID_REQUEST_DETAIL ) )
