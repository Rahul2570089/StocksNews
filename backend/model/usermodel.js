const mongoose = require('mongoose')
const bcrypt = require('bcrypt')

const UserSchema = new mongoose.Schema({
    email: {
        type: String,
        lowercase: true,
        required: true,
        unique: true
    },
    password: {
        type: String,
        required: true
    },
    tokens: [{
        type: Object
    }]
})

UserSchema.pre('save', async function () {
    try {
        const salt = await bcrypt.genSaltSync(10);
        const hashedPassword = await bcrypt.hashSync(this.password, salt)
        this.password = hashedPassword;
    } catch (error) {
        throw error;
    }
})

UserSchema.methods.isValidPassword = async function (password) {
    try {
        return await bcrypt.compare(password, this.password)
    } catch (error) {
        throw error;
    }
}

const UserModel = mongoose.model('User', UserSchema)

module.exports = UserModel