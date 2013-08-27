
@sessionVerify = ( publish_handler, username, session_id, session_call) ->

	is_valid = false

	redis_host = CONFIG.redis_host

	if redis_host

		client = new redisClient redis_host

		client.verifySync username, session_id, verify_call = (true_or_false) ->

				if true_or_false

					sessionVerifyIntervel = () ->


						client.checkHashValueAsync username, "id", session_id, verify_call = (true_or_false) ->

							if not true_or_false

								clearInterval publish_handler.interval

								console.info "Session expired, session #{session_id}, user #{username}"

								publish_handler.error( new Meteor.Error( 404, ERROR_CODE.INVALID_SESSION, ERROR_CODE.INVALID_SESSION_DETAIL ) )

					# start interval when valid is done
					publish_handler.interval = setInterval sessionVerifyIntervel, 10000

					# stop intervel when socket is close
					publish_handler._session.socket.on "close", stopFunc = () =>

						console.info "Connection closed, session #{session_id}, user #{username}"

						clearInterval publish_handler.interval
						#stop publish when socket is close
						publish_handler.stop()

					session_call true

				else

					session_call false


	else
		console.error ERROR_CODE.REDIS_CONFIG

