const UserService = require('../services/userservices');

exports.register = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const result = await UserService.createUser(email, password);
        res.json({ status: true, success: "User created successfully" })
    } catch (error) {
        throw error;
    }
}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const user = await UserService.checkUser(email);

        if (!user) {
            res.json({ status: false, error: "User not found" })
            throw new Error("User not found");
        }

        const isPasswordValid = await user.isValidPassword(password)
        if (!isPasswordValid) {
            res.json({ status: false, error: "Password is not valid" })
            throw new Error("Password is not valid");
        }

        let tokenData = { id: user._id, email: user.email }
        const token = await UserService.generateToken(tokenData, "process.env.JWT_SECRET", "1h");
        res.status(200).json({ status: true, token: token, success: "User logged in successfully" })

    } catch (error) {
        throw error;
    }
}