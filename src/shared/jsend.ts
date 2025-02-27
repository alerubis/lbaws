// https://github.com/omniti-labs/jsend

export class JSend {

    static success(data: any): any {
        return {
            'status': 'success',
            'data': data
        };
    }

    static fail(data: any): any {
        return {
            'status': 'fail',
            'data': data
        };
    }

    static error(message: any): any {
        return {
            'status': 'error',
            'message': message
        };
    }

}
