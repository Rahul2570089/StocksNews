const Router = require('express').Router()

const UserController = require('../controller/usercontroller')

Router.post('/user/register', UserController.register);
Router.post('/user/login', UserController.login);

module.exports = Router;