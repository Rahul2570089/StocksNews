const mongoose = require('mongoose');

mongoose.connect('mongodb+srv://rahul:rasdassas456@cluster0.roweuhe.mongodb.net/?retryWrites=true&w=majority').then(() => {
    console.log('Connected to MongoDB');
}).catch((err) => {
    console.log('Error connecting to MongoDB', err);
})

module.exports = mongoose;