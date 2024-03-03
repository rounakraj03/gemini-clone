const Constants = {
    UNKNOWN : 406,
    VALIDATION : 401,
    UNAUTHORIZED : 402,
    FORBIDDEN : 403,
    NOT_FOUND : 404,
    ALL_FIELD_MANDATORY : 405,
}

const errorHandler = (err, req, res, next) => {
    const statusCode = res.statusCode ? res.statusCode : 406;

    switch (statusCode) {
        case Constants.VALIDATION: 
            res.status(statusCode).json({
                status: Constants.VALIDATION,
                errorMessage: err.message, 
            });
            break;
        case Constants.UNAUTHORIZED: 
            res.status(statusCode).json({
                status: Constants.UNAUTHORIZED,
                errorMessage: err.message, 
            });
            break;
        case Constants.FORBIDDEN: 
            res.status(statusCode).json({
                status: Constants.FORBIDDEN,
                errorMessage: err.message, 
            });
            break;
        case Constants.NOT_FOUND: 
            res.status(statusCode).json({
                status: Constants.NOT_FOUND,
                errorMessage: err.message, 
            });
            break;
        case Constants.ALL_FIELD_MANDATORY: 
            res.status(statusCode).json({
                status: Constants.ALL_FIELD_MANDATORY,
                errorMessage: err.message, 
            });
            break;
        default:
            res.status(statusCode).json({
                status: Constants.UNKNOWN,
                errorMessage: err.message, 
            });
            break;
    }
}

export default errorHandler;