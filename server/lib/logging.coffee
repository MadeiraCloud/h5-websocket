os              =   Npm.require "os"

hostname        =   os.hostname()

@scribeInit = () ->

    scribeClient    =   Scribe.Scribe

    scribeLogger    =   Scribe.Logger

    scribeRequestLog =  Scribe.RequestLog

    scribe         =   new scribeClient CONFIG.scribe_host, CONFIG.scribe_port, {autoReconnect:true}

    logger         =   new scribeLogger scribe, "#{hostname}-NodejsWebsocket"

    scribe.open func = (err) ->

        if err

            return console.log err;

        logger.replaceConsole() # replaces console with logger

        console.info "ScribeLogger Initiliazing."
