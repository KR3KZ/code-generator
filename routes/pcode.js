var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
    if (req.query.accounts && req.query.accounts.length) {
        if (typeof req.query.accounts === "string")
            req.query.accounts = [req.query.accounts]
        const accList = `"${req.query.accounts.join('" "')}"`
        const accLength = req.query.accounts.length
        res.render('pcode', { accounts: accList, accountsCount: accLength });
    } else
        res.send("invalid params")
});

module.exports = router;