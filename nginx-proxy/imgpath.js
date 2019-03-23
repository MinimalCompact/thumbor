function file_path(r) {
    var digest = require('crypto').createHash('sha1').update(r.uri).digest('hex');
    return digest.slice(NaN, 2) + "/" + digest.slice(2, 4) + "/" + digest.slice(4);
}
