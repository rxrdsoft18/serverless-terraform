const uuidv4 = require('uuid');
class Uuid {
    constructor() {
        this.uuid = uuidv4();
    }

    getUuid() {
        return this.uuid;
    }
}

module.exports = name;
