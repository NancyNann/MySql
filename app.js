var faker = require('faker');
var mysql = require('mysql');
function generateAddress(){
    console.log(faker.address.streetAddress());
    console.log(faker.address.city());
    console.log(faker.address.state())
}

var connection = mysql.createConnection(
    {
        host        :   'localhost',
        user        :   'root',
        password    :   'Nl12345678',
        database    :   'join_us',

    }
)

/*
var q = 'SELECT COUNT(*) AS total FROM users';
connection.query(q, function(error, results, filefields)
{
    if (error) throw error;
    console.log('the solution is: ', results[0]);
}
);
connection.end();*/

// INSERTING DATA

/*var person = {
    email: faker.internet.email(),
    create_at: faker.date.past()
}
var end_result = connection.query('INSERT INTO users SET ?', person, function(err,results)
{
    if (err) throw err;
    console.log(results);
});

console.log(end_result.sql);
connection.end();*/

var data = [];
for (i = 0; i<500; i++)
{
    data.push([
    faker.internet.email(),
    faker.date.past()
])
}

var q = 'INSERT INTO users (email, create_at) VALUES ?';
connection.query(q, [data], function(err, result)
{
    console.log(err);
    console.log(result)
});

console.log(faker.date.past());
connection.end();
