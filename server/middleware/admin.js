const jwt = require('jsonwebtoken');
const User = require('../models/user');

const admin = async (req, res, next) => {
    try {
        const token = req.header('x-auth-token');
        if (!token) {
            return res.status(401).json({ msg: "no auth token, access denied" })
        }
        const ifverfied = jwt.verify(token, 'passwordKey');
        if (!ifverfied) return res.status(401).json({ msg: 'Token verification failed. authorization denied' })

        const user = await User.findById(verified.id)

        if(user.type == 'user' || user.type == 'seller'){
            return res.status(401).json({ msg: 'You Are Not An Admin!!!' })
        }

        req.user = ifverfied.id;
        req.token = token;
        next();
    } catch (e) {
        res.status(500).json({ err: err.message });
    }
};

module.exports = admin;