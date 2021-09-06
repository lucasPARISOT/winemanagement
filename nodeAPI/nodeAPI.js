const http = require('http');
const mongoClient = require('mongodb').MongoClient;

const port = 3000
const host = '127.0.0.1'

const mongoUrl = 'mongodb://localhost:27017/';
const mongoDb = 'test';
const mongoCollection = 'test';

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

                    try {
                        mongoClient.connect(mongoUrl, async function (err, client) {

                            // TODO: Remove db test and associated collections
                            const db = client.db(mongoDb);
                            const collection = db.collection(mongoCollection);

                            result = await collection.find({}).toArray().catch(function () {
                                console.log('error');
                            });

                            console.log(result);

                            response.statusCode = 200;
                            response.setHeader('Access-Control-Allow-Origin','*');
                            response.setHeader('Access-Control-Allow-Methods','GET');
                            response.setHeader('Access-Control-Allow-Headers','X-Requested-With, Access-Control-Allow-Origin, Accept');
                            response.write(JSON.stringify(result));
                            response.end();

                        });
                    } catch (exception) {

                    }


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

                    mongoClient.connect(mongoUrl, function(err, client) {

                        // TODO: Remove db test and associated collections
                        const db = client.db(mongoDb);
                        const collection = db.collection(mongoCollection);

                        const result = collection.insertOne(json);

                        console.log(`le document a été ajouté à la collection '${mongoCollection}' de la base de données '${mongoDb}'`);
                    });

                    console.log(json);

                    response.statusCode = 201;
                    response.setHeader('Access-Control-Allow-Origin','*');
                    response.setHeader('Access-Control-Allow-Methods','POST');
                    response.setHeader('Access-Control-Allow-Headers','X-Requested-With, Access-Control-Allow-Origin, Accept');
                    response.end()
                })
        }

    }

})

server.listen(port, host)
console.log(`Listening at http://${host}:${port}`)