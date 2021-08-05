const http = require("http")

let body = JSON.stringify({
    title: "Make a request with Node's http module"
})

const server = http.createServer((request, response) => {
    let data = []
    request
        .on("data", d => {
            data.push(d)
        })
        .on("end", () => {
            data = Buffer.concat(data).toString()
            const json = JSON.parse(data);
            console.log(json.test)

            response.statusCode = 201
            response.end()
        })
})

const port = 3000
const host = '127.0.0.1'
const url = '/test'
server.listen(port, host)
console.log(`Listening at http://${host}:${port}${url}`)