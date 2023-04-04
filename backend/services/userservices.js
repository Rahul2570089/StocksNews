const UserModel = require('../model/usermodel');
const jwt = require('jsonwebtoken');

class UserService {
    static async createUser(email, password) {
        try {
            const newUser = new UserModel({ email, password });
            const result = await newUser.save();
            return result;
        } catch (error) {
            throw error;
        }
    }

    static async checkUser(email) {
        try {
            return await UserModel.findOne({ email });
        } catch (error) {
            throw error;
        }
    }

    static async generateToken(tokenData, secretKey, expiresIn) {
        try {
            return jwt.sign(tokenData, secretKey, { expiresIn: expiresIn });
        } catch (error) {
            throw error;
        }
    }
}

module.exports = UserService;