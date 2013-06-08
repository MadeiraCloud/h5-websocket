

Meteor.startup start = () ->


	scribeInit()

	request_publisher = new RequestPublisher 

	request_detail_publisher = new RequestDetailPublisher

	request_publisher.publish()

	request_detail_publisher.publish()