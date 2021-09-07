const http = require('http');
const mongoClient = require('mongodb').MongoClient;

const connection = require('./connection');

const server = http.createServer((request, response) => {

    const urlTemp = request.url.split('?');
    const url = urlTemp[0];

    if (request.method === 'GET') {

        if(url === '/test' || url ==='/test/') {

            request
                .on('data', d => {
                })
                .on('end', () => {

                    let result = 'no data';

                    mongoClient.connect(connection.mongoUrl, async function (err, client) {

                        // TODO: Remove db test and associated collections
                        const db = client.db(connection.mongoDb);
                        const collection = db.collection(connection.mongoCollection);

                        result = await collection.find({quantite: {$exists: true, $gt: 0}}).toArray();

                        response.statusCode = 200;
                        response.setHeader('Access-Control-Allow-Origin','*');
                        response.setHeader('Access-Control-Allow-Methods','GET');
                        response.setHeader('Access-Control-Allow-Headers','X-Requested-With, Access-Control-Allow-Origin, Accept');
                        response.write(JSON.stringify(result));
                        response.end();

                    });
                })
        }
    }

    if (request.method === 'POST') {

        if(url === '/test' || url ==='/test/') {
            let data = []

            request
                .on('data', d => {
                    data.push(d)
                })
                .on('end', () => {
                    data = Buffer.concat(data).toString()
                    const json = JSON.parse(data);

                    mongoClient.connect(connection.mongoUrl, function(err, client) {

                        // TODO: Remove db test and associated collections
                        const db = client.db(connection.mongoDb);
                        const collection = db.collection(connection.mongoCollection);

                        collection.insertOne(json);

                    });

                    response.statusCode = 201;
                    response.setHeader('Access-Control-Allow-Origin','*');
                    response.setHeader('Access-Control-Allow-Methods','POST');
                    response.setHeader('Access-Control-Allow-Headers','X-Requested-With, Access-Control-Allow-Origin, Accept');
                    response.end()
                })
        }

    }

})

server.listen(connection.port, connection.host)
console.log(`Listening at http://${connection.host}:${connection.port}`)