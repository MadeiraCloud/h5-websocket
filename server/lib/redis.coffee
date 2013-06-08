Future = Npm.require("fibers/future")

class @redisClient
 
	constructor : (hostname, port=8285, db=0, password=null, timeout=null) ->

		@redis_client = redis.createClient port, hostname, { connect_timeout : timeout }
										 
		@redis_client.auth password, null

		@redis_client.select db if db != 0

		this


	verifySync : (username, session_id, result_call) ->

		future = new Future

		@redis_client.hgetall username, (err, obj) ->

			console.log err if err

			if obj and obj.id == session_id

				future.return true

			else

				console.log "Invalid session, username: #{username}, session: #{session_id}"

				future.return false


		if future.wait() then result_call true else result_call false



	checkHashValueAsync : (hash, field, value, result_call) ->

		@redis_client.hget hash, field, (err, obj) ->

			console.log err if err

			if obj == value

				result_call true

			else

				result_call false
