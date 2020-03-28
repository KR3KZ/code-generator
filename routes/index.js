var express = require('express');
var router = express.Router();
var http = require('http'),
    Stream = require('stream').Transform,
    fs = require('fs');

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('index', { title: 'Express' });
});

router.post('/', function(req, res) {
    const accounts = req.body.accounts.split("\r\n")
    const id = req.body.id
    const filename = `DoAction${id}.pcode`
    const queryParams = `?id=${id}&accounts=${accounts.join("&accounts=")}`
    const url = `http://localhost:3000/pcode${queryParams}`
    console.log(url)

    http.request(url, function(response) {
        var data = new Stream();

        response.on('data', function(chunk) {
            data.push(chunk);
        });

        response.on('end', function() {
            fs.writeFileSync(filename, data.read());

            const exec = require('child_process').exec;
            const childPorcess = exec(`java -jar jpex\\ffdec.jar -format script:pcode -replace core.swf core${id}.swf "\\__Packages\\dofus\\graphics\\gapi\\ui\\Login" "${filename}"`, function(err, stdout, stderr) {
                if (err) {
                    console.log(err)
                    res.status(500).send(err)
                }
                else res.send(stdout)
            })
        });
    }).end();
});

module.exports = router;