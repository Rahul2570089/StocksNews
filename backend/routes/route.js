const Router = require('express').Router()

const UserController = require('../controller/usercontroller')

Router.post('/user/register', UserController.register);
Router.post('/user/login', UserController.login);
Router.post('/user/logout', UserController.logout);

module.exports = Router;