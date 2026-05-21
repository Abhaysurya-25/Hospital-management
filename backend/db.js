const mysql = require('mysql2');
require('dotenv').config();

const pool = mysql.createPool({
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_NAME,
    port: process.env.DB_PORT,
    waitForConnections: true,
    connectionLimit: 10,
    queueLimit: 0
});

// Test connection
pool.getConnection((err, connection) => {
    if (err) {
        console.error('Error connecting to MySQL database:', err);
        return;
    }

    console.log('Connected to MySQL database!');
    connection.release();
});

function executeQuery(sql_query, req) {
    return new Promise((resolve) => {

        let status = 200;
        let message = 'OK';

        req.db.getConnection((err, connection) => {

            if (err) {
                console.error('Database connection error:', err);

                status = 500;
                message = 'Internal Server Error';

                resolve({
                    status,
                    message,
                    rows: []
                });

                return;
            }

            connection.query(sql_query, (err, rows) => {

                if (err) {
                    console.log(err);

                    status = 400;
                    message = 'SQL query error';
                }

                connection.release();

                resolve({
                    status,
                    message,
                    rows
                });
            });
        });
    });
}

module.exports = {
    executeQuery,
    pool
};