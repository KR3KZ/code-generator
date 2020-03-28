var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    if (req.query.id && req.query.accounts && req.query.accounts.length) {
        if (typeof req.query.accounts === "string")
            req.query.accounts = [req.query.accounts]
        const id = Buffer.from(req.query.id).toString('base64')
        console.log(`id: ${req.query.id}`)
        console.log(`b64: ${id}`)
        const accList = `"${req.query.accounts.join('" "')}"`
        const accLength = req.query.accounts.length
        res.render('pcode', { ticketId: id, accounts: accList, accountsCount: accLength });
    } else
        res.status(422).send("invalid params")
});

module.exports = router;