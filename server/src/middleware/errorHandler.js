const Constants = {
    UNKNOWN : 400,
    VALIDATION : 401,
    UNAUTHORIZED : 402,
    FORBIDDEN : 403,
    NOT_FOUND : 404,
    ALL_FIELD_MANDATORY : 405,
}

const errorHandler = (err, req, res, next) => {
    const statusCode = res.statusCode ? res.statusCode : 400;

    switch (statusCode) {
        case Constants.VALIDATION: 
            res.json({
                status: Constants.VALIDATION,
                errorMessage: err.message, 
            });
            break;
        case Constants.UNAUTHORIZED: 
            res.json({
                status: Constants.UNAUTHORIZED,
                errorMessage: err.message, 
            });
            break;
        case Constants.FORBIDDEN: 
            res.json({
                status: Constants.FORBIDDEN,
                errorMessage: err.message, 
            });
            break;
        case Constants.NOT_FOUND: 
            res.json({
                status: Constants.NOT_FOUND,
                errorMessage: err.message, 
            });
            break;
        case Constants.ALL_FIELD_MANDATORY: 
            res.json({
                status: Constants.ALL_FIELD_MANDATORY,
                errorMessage: err.message, 
            });
            break;
        default: 
            res.json({
                status: Constants.UNKNOWN,
                errorMessage: err.message, 
            });
            break;
    }
}

module.exports = errorHandler;