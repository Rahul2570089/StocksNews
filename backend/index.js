const app = require('./app')
const db = require('./config/db')

const port = process.env.PORT || 3000

app.get('/', (req, res) => {
    res.send('Server running....')
})

app.listen(port, () => {
    console.log(`Listening on port ${port}`)
})